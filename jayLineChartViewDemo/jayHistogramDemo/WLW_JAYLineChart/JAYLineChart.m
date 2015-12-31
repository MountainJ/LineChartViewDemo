//
//  JAYLineChart.m
//  JAYChartDemo
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//

#import "JAYLineChart.h"
#import "JAYColor.h"
#import "JAYChartLabel.h"

#define kMinXLabelS  4  //单屏显示最少数据条数
#define kDotWH 6 //画图点的宽高
#define kYLableNumbers  self.numberLabelsForY+1 //纵轴显示数值单位个数
#define kBottomXLabelsH JAYLabelHeight*4 //横轴时间Lable高度

#define kStrokeLineWH  0.5//横线竖线的宽或高
#define kStrokeLineAlpha 1.0 //描线的透明度
#define kConnectLineWidth 1.0 //连接线的宽度

//坐标轴透明度
#define kFirstLineAlpha 1

#define kDashedLineLength 1  //虚线点的长度
#define kDashedLineMargin 3 //虚线的间隔



@interface JAYLineChart ()
{
    UIScrollView *_myScrollView;
    CGFloat  _xAxisLengh;
    
    
    NSInteger  _flag; //数据点少于标准点数的界面调整
    BOOL showFloatValue;
}

@end

@implementation JAYLineChart {
    NSHashTable *_chartLabelsForX;
}

- (void)setYUnitString:(NSString *)yUnitString
{
    _yUnitString = yUnitString;

}

- (void)setViewTitle:(NSString *)viewTitle
{
    _viewTitle = viewTitle;
}

-(void)setColors:(NSArray *)colors
{
    _colors = colors;
}

- (void)setMarkRange:(CGRange)markRange
{
    _markRange = markRange;
}

- (void)setGroupMarkRange:(JAYGroupRange)groupMarkRange
{
    _groupMarkRange = groupMarkRange;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

- (void)setShowHorizonLine:(NSMutableArray *)ShowHorizonLine
{
    _ShowHorizonLine = ShowHorizonLine;
}

- (void)hideYLabelValue:(NSMutableArray *)hideYLabelValue
{
    _hideYLabelValue = hideYLabelValue;
}

-(void)setStokeAnimateDuration:(CGFloat)strokeAnimateDuration
{
    _strokeAnimateDuration  = strokeAnimateDuration;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, JAYLabelHeight*2, frame.size.width, frame.size.height-JAYLabelHeight)];
        _myScrollView.contentSize = CGSizeMake(frame.size.width, 0);
        _myScrollView.contentOffset = CGPointMake(0, 0);
        [self addSubview:_myScrollView];
        
        
    }
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    CGFloat max = 0.0;
    CGFloat min = 1000000000.0;

    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            CGFloat value = [valueString floatValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (max < 5) {
        max = 5;
    }
    if (self.showRange) {
        _yValueMin = min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
   //Y轴数值
   
    float level = (_yValueMax-_yValueMin) /(kYLableNumbers-1);
    CGFloat chartCavanHeight = _myScrollView.frame.size.height-kBottomXLabelsH;
    CGFloat levelHeight = chartCavanHeight /(kYLableNumbers-1);
    for (int i=0; i<kYLableNumbers; i++) {
        if (![_hideYLabelValue[i] integerValue]) {
            JAYChartLabel * label = [[JAYChartLabel alloc] initWithFrame:CGRectMake(0.0,2*JAYLabelHeight+i*levelHeight-JAYLabelHeight/2.0, JAYYLabelwidth, JAYLabelHeight)];
            label.text = [NSString stringWithFormat:@"%d",(int)(_yValueMax-i*level)];
            if (showFloatValue) {
            label.text = nil;
            label.text = [NSString stringWithFormat:@"%.1f",(_yValueMax-i*level)];
            }
            label.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            label.font = [UIFont systemFontOfSize:10.0];
            [self addSubview:label];
        }

    }
    //Y轴单位
    if (_yUnitString) {
        JAYChartLabel * yUnitlabel = [[JAYChartLabel alloc] initWithFrame:CGRectMake(JAYYLabelwidth/2.0, 5, JAYYLabelwidth*2, JAYLabelHeight)];
        yUnitlabel.text = _yUnitString;
        yUnitlabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:yUnitlabel];
    }
    //表标题
    if (_viewTitle) {
        CGFloat titilFrame = self.frame.size.width/self.maxNumbersDotForX;
        JAYChartLabel * titleLabel = [[JAYChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width-titilFrame*2, 0, titilFrame*2, JAYLabelHeight*2)];
        titleLabel.text = _viewTitle;
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
    
    //描横线
    for (int i=0; i<kYLableNumbers; i++) {
        if ([_ShowHorizonLine[i] integerValue]>0) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(JAYYLabelwidth,2*JAYLabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,2*JAYLabelHeight+i*levelHeight)];
          
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = path.CGPath;
            shapeLayer.lineWidth = kStrokeLineWH;
            shapeLayer.lineCap = kCALineCapRound;
            if (i!=kYLableNumbers-1) {
                shapeLayer.strokeColor = [[kDashLineColor colorWithAlphaComponent:kStrokeLineAlpha] CGColor];
            }else{ //最下方的横线
                shapeLayer.strokeColor = [[kFirstLineColor colorWithAlphaComponent:kFirstLineAlpha] CGColor];

             }
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            if (i!=kYLableNumbers-1) {
                shapeLayer.lineJoin = kCALineJoinRound;
                shapeLayer.lineDashPattern =[NSArray arrayWithObjects:[NSNumber numberWithInt:kDashedLineLength],
                                             [NSNumber numberWithInt:kDashedLineMargin],
                                             nil];
            }
            [self.layer addSublayer:shapeLayer];
            [path closePath];
        }
    }
  
    //单组数据
    if (_yValues.count ==1&&[super respondsToSelector:@selector(setMarkRange:)]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(JAYYLabelwidth, (1-(_markRange.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight,_xAxisLengh, (_markRange.max-_markRange.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
        view.backgroundColor = [_colors[0] colorWithAlphaComponent:0.6];
        [_myScrollView addSubview:view];

    }
    
    if (_yValues.count==2&&[super respondsToSelector:@selector(setGroupMarkRange:)]) {
        //2组数据
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(JAYYLabelwidth, (1-(_groupMarkRange.range1.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight,_xAxisLengh, (_groupMarkRange.range1.max-_groupMarkRange.range1.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
            view.backgroundColor = [_colors[0] colorWithAlphaComponent:0.6];
            [_myScrollView addSubview:view];
        
            //
            UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(JAYYLabelwidth, (1-(_groupMarkRange.range2.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight,_xAxisLengh, (_groupMarkRange.range2.max-_groupMarkRange.range2.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
            view2.backgroundColor = [_colors[1] colorWithAlphaComponent:0.6];
            [_myScrollView addSubview:view2];
    }
}



-(void)setXLabels:(NSArray *)xLabels
{
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    _xLabels = xLabels;
    if (_xLabels.count<=_maxNumbersDotForX) {
        _myScrollView.scrollEnabled = NO;
    }
    
    
    CGFloat num = 0;
   
    if (xLabels.count>=_maxNumbersDotForX) {
        num=_maxNumbersDotForX;
    }else if (xLabels.count >=4){
       num = xLabels.count;
    }
    else
    {
        num = xLabels.count+1;
        _flag = 1;
    }
    _xLabelWidth = (self.bounds.size.width - JAYYLabelwidth)/num;
    if (xLabels.count) {
        _xAxisLengh = _xLabelWidth *(xLabels.count+1);

    }else{
        _xAxisLengh = (self.bounds.size.width - JAYYLabelwidth);
        _flag = 0;
    }
    
    /*数据为空*/
    if (!xLabels.count) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(JAYYLabelwidth ,0)];
            [path addLineToPoint:CGPointMake(JAYYLabelwidth,_myScrollView.frame.size.height-kBottomXLabelsH)];
            shapeLayer.path = path.CGPath;
            shapeLayer.lineWidth = kStrokeLineWH;
            shapeLayer.lineCap = kCALineCapRound;
            shapeLayer.strokeColor = [[kDashLineColor colorWithAlphaComponent:kFirstLineAlpha] CGColor];
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            [_myScrollView.layer addSublayer:shapeLayer];
             [path closePath];
        return;
    }
    
    //画第一条竖线
    CAShapeLayer *verLineLayer = [CAShapeLayer layer];
    UIBezierPath *verPath = [UIBezierPath bezierPath];
    [verPath moveToPoint:CGPointMake(JAYYLabelwidth ,CGRectGetMinY(_myScrollView.frame))];
    [verPath addLineToPoint:CGPointMake(JAYYLabelwidth,_myScrollView.frame.size.height-kBottomXLabelsH +JAYLabelHeight*2)];
    verLineLayer.path = verPath.CGPath;
    verLineLayer.lineWidth = kStrokeLineWH;
    verLineLayer.lineCap = kCALineCapRound;
    verLineLayer.strokeColor = [[kFirstLineColor colorWithAlphaComponent:kFirstLineAlpha] CGColor];
    verLineLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:verLineLayer];
    [self bringSubviewToFront:_myScrollView];
    
    //横坐标
    for (int i=0; i<xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        JAYChartLabel * label = [[JAYChartLabel alloc] initWithFrame:CGRectMake(JAYYLabelwidth/2.0+5.0+i * _xLabelWidth+_xLabelWidth*_flag, _myScrollView.frame.size.height-kBottomXLabelsH-JAYLabelHeight*0.5, _xLabelWidth, kBottomXLabelsH)];
        label.numberOfLines = 2;
        label.font = [UIFont systemFontOfSize:9];
        label.text = labelText;
        label.textAlignment = NSTextAlignmentLeft;
        [_myScrollView addSubview:label];
        [_chartLabelsForX addObject:label];
        //描竖线
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        //数据点小于规定点数，调整描点的位置
        if (_flag) {
            [path moveToPoint:CGPointMake(JAYYLabelwidth +i*_xLabelWidth+_xLabelWidth*_flag,0)];
            [path addLineToPoint:CGPointMake(JAYYLabelwidth+i*_xLabelWidth+_xLabelWidth*_flag,_myScrollView.frame.size.height-kBottomXLabelsH)];
        }else{
            [path moveToPoint:CGPointMake(JAYYLabelwidth +i*_xLabelWidth,0)];
            [path addLineToPoint:CGPointMake(JAYYLabelwidth+i*_xLabelWidth,_myScrollView.frame.size.height-kBottomXLabelsH)];
        }
        shapeLayer.path = path.CGPath;
        shapeLayer.lineWidth = kStrokeLineWH;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];

        if (i!=0) {// 正常数据的虚竖线
            shapeLayer.strokeColor = [[kDashLineColor colorWithAlphaComponent:kStrokeLineAlpha] CGColor];
        }else if (i==0&&_flag!=0){//小于正常数据的第一条虚竖线
            shapeLayer.strokeColor = [[kDashLineColor colorWithAlphaComponent:kStrokeLineAlpha] CGColor];
        }else if(i==0){//正常数据的第一条虚竖线
            shapeLayer.strokeColor = [[kDashLineColor colorWithAlphaComponent:kStrokeLineAlpha] CGColor];
            shapeLayer.strokeColor = [[kDashLineColor colorWithAlphaComponent:0.0] CGColor];
        }else //坐标轴纵轴的竖线
        {
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:1.0] CGColor];
        }
         //画虚线
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineDashPattern =[NSArray arrayWithObjects:[NSNumber numberWithInt:kDashedLineLength],
                                         [NSNumber numberWithInt:kDashedLineMargin],
                                         nil];
        
        [_myScrollView.layer addSublayer:shapeLayer];

        [path closePath];
    }

    float max = (([xLabels count])*_xLabelWidth + chartMargin)+_xLabelWidth;
    if (_myScrollView.frame.size.width < max-_maxNumbersDotForX) {
        _myScrollView.contentSize = CGSizeMake(max, _myScrollView.frame.size.height);
    }

}

#pragma mark -  描点
-(void)strokeChart
{
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            return;
        }
        NSInteger max_i =0;
        NSInteger min_i =0;
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 2.0;
        _chartLine.strokeEnd   = 0.0;
        [_myScrollView.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        
        /*如果超过给定的范围，默认为边界值*/
          CGFloat unitValue =  (_chooseRange.max-_chooseRange.min) /(_myScrollView.frame.size.height-kBottomXLabelsH +JAYLabelHeight*2);
        if (firstValue>=_chooseRange.max) {
            firstValue = _chooseRange.max-unitValue *(kDotWH*0.5) ;
        }
        if (firstValue<=_chooseRange.min) {
            firstValue =_chooseRange.min+unitValue *(kDotWH*0.5);
        }
        //
        CGFloat xPosition = JAYYLabelwidth+_xLabelWidth*_flag;
        CGFloat chartCavanHeight = _myScrollView.frame.size.height - kBottomXLabelsH;
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.ShowMaxMinArray) {
            if ([self.ShowMaxMinArray[i] intValue]>0) {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
            }else{
                isShowMaxAndMinPoint = YES;
            }
        }
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight)
                 index:i
                isShow:self.showTextValue
                 value:firstValue];

        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight)];
        [progressline setLineWidth:kConnectLineWidth];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        
        for (NSString * valueString in childAry)
        {
            CGFloat dotValue = [valueString floatValue];
            if (dotValue>=_chooseRange.max) {
                dotValue = _chooseRange.max-unitValue *(kDotWH*0.5);
            }
            if (dotValue<=_chooseRange.min) {
                dotValue = _chooseRange.min+unitValue *(kDotWH*0.5);
            }
            
            float grade =(dotValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight);
                [progressline addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = YES;
                
                if (self.ShowMaxMinArray) {
                    if ([self.ShowMaxMinArray[i] intValue]>0) {
                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?NO:YES;
                    }else{
                        isShowMaxAndMinPoint = YES;
                    }
                }
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:self.showTextValue
                         value:[valueString floatValue]];
            }
            index += 1;
        }
        _chartLine.path = progressline.CGPath;
        _chartLine.strokeColor = JAYStrokeLineColor.CGColor;
        
        //添加数据图线绘画效果
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        if (_strokeAnimateDuration) {
             pathAnimation.duration = _strokeAnimateDuration;
        }else{
            pathAnimation.duration = _xLabels.count*0.05;
        }
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        _chartLine.strokeEnd = 1.0;
    }
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0 , kDotWH, kDotWH)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = kDotWH*0.5;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = JAYStrokeLineColor.CGColor;
    view.backgroundColor = [UIColor whiteColor];
     [_myScrollView addSubview:view];
    
    // 数值的显示
    if (isHollow) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-JAYTagLabelwidth/2.0, point.y-JAYLabelHeight*1.5, JAYTagLabelwidth, JAYLabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor =  [UIColor redColor];
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [_myScrollView addSubview:label];
    }
    
    
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}

@end
