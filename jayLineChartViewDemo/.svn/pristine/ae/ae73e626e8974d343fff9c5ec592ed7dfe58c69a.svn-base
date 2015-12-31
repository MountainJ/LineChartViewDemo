//
//  JAYBarChart.m
//  JAYChartDemo
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//

#import "JAYBarChart.h"
#import "JAYChartLabel.h"
#import "JAYBar.h"

#define kMaxLabelNumber  8.0  //单屏显示最多柱状图数目
#define kMinLabelNumber  4.0  //单屏显示最少柱状图数目

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height



#define kYLableNumbers (5.0) //纵轴显示数值单位个数
#define kYExtralLabelNum (2.0) //最大值最小值之外显示Label数目

@interface JAYBarChart ()
{
    UIScrollView *myScrollView;
    float yNormalRangeMax;
    float yNormalRangeMin;
    
}
@end

@implementation JAYBarChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.clipsToBounds = YES;
        myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(JAYYLabelwidth, JAYLabelHeight, frame.size.width-JAYYLabelwidth, frame.size.height)];
        [self addSubview:myScrollView];
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
    float max = 0.;
    float min = 1000000000.;
    for (NSArray * ary in yLabels)
    {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (self.showRange) {
        _yValueMin = (int)min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (int)max;

    if (_chooseRange.max!=_chooseRange.min) {
        //指定正常范围的值
        yNormalRangeMax = _chooseRange.max;
        yNormalRangeMin = _chooseRange.min;
    }
    float level = (yNormalRangeMax-yNormalRangeMin) /(kYLableNumbers-1);//分成的每一份表示数值的大小
    _yValueMin = yNormalRangeMin-level*kYExtralLabelNum;//Y轴原点;
    _yValueMax = yNormalRangeMax+level*kYExtralLabelNum;//Y轴显示最大值;
    CGFloat chartCavanHeight = self.frame.size.height - JAYLabelHeight*3;//显示的chart表格大小
    CGFloat levelHeight = chartCavanHeight /(kYLableNumbers-1+4);
   //Y轴图标
    for (int i=0; i<kYLableNumbers+kYExtralLabelNum*2; i++)
    {
        JAYChartLabel * label = [[JAYChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+JAYLabelHeight/2, JAYYLabelwidth, JAYLabelHeight)];
		label.text = [NSString stringWithFormat:@"%.1f",level * i+_yValueMin];
//        label.backgroundColor = [UIColor yellowColor];
		[self addSubview:label];
    }
    //画横线
    for (int i=0; i<kYLableNumbers+kYExtralLabelNum*2; i++)
    {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(JAYYLabelwidth,JAYLabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width-5,JAYLabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
           if (i==2||i==6) {//正常值的上限2;正常值下限6,飘红
            shapeLayer.strokeColor = [[[UIColor redColor] colorWithAlphaComponent:0.5] CGColor];
            shapeLayer.lineWidth = 0.5;
           }else{
            shapeLayer.strokeColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.3] CGColor];
            shapeLayer.lineWidth = 0.3;
           }
         shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        [self.layer addSublayer:shapeLayer];
    }

}

-(void)setXLabels:(NSArray *)xLabels
{
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xLabels = xLabels;
    NSInteger num;
    if (xLabels.count>=kMaxLabelNumber) {
        num = kMaxLabelNumber;
    }else if (xLabels.count<=kMinLabelNumber){
        num = kMinLabelNumber;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = myScrollView.frame.size.width/num;
    //横坐标
    for (int i=0; i<xLabels.count; i++) {
        JAYChartLabel * label = [[JAYChartLabel alloc] initWithFrame:CGRectMake((i *  _xLabelWidth ), myScrollView.frame.size.height-JAYLabelHeight*3, _xLabelWidth, JAYLabelHeight)];
        label.text = xLabels[i];
        [myScrollView addSubview:label];
        [_chartLabelsForX addObject:label];
    }
    float max = (([xLabels count]-1)*_xLabelWidth + chartMargin)+_xLabelWidth;
    if (myScrollView.frame.size.width < max-10) {
        myScrollView.contentSize = CGSizeMake(max, self.frame.size.height);
    }
    //底部颜色指示图
    if (_yValues.count==2) {
        [self configBottomColorIndicator];
    }
    
}
#pragma  mark -
- (void)configBottomColorIndicator
{
    JAYChartLabel * leftlabel = [[JAYChartLabel alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-2*_xLabelWidth, self.frame.size.height-JAYLabelHeight, _xLabelWidth/2, JAYLabelHeight)];
    leftlabel.backgroundColor = [_colors firstObject];
    [self addSubview:leftlabel];
    JAYChartLabel * leftTextlabel = [[JAYChartLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftlabel.frame), self.frame.size.height-JAYLabelHeight, _xLabelWidth, JAYLabelHeight)];
    leftTextlabel.text = @"收缩压";
    [self addSubview:leftTextlabel];
    //
    JAYChartLabel * rightLabel = [[JAYChartLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftTextlabel.frame)+xLabelMargin, self.frame.size.height-JAYLabelHeight, _xLabelWidth/2, JAYLabelHeight)];
    rightLabel.backgroundColor = [_colors lastObject];
    [self addSubview:rightLabel];
    JAYChartLabel * rightTextLabel = [[JAYChartLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rightLabel.frame), self.frame.size.height-JAYLabelHeight, _xLabelWidth, JAYLabelHeight)];
    rightTextLabel.text = @"舒张压";
    [self addSubview:rightTextLabel];
}

-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}


-(void)strokeChart
{
    
    CGFloat chartCavanHeight = self.frame.size.height - JAYLabelHeight*3;
    for (int i=0; i<_yValues.count; i++)
    {
        NSArray *childAry = _yValues[i];
        for (int j=0; j<childAry.count; j++)
        {
            NSString *valueString = childAry[j];
            float value = [valueString floatValue];
            float grade = ((float)value-_yValueMin) / ((float)_yValueMax-_yValueMin);
            JAYBar * bar = [[JAYBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, 0, _xLabelWidth * (_yValues.count==1?0.8:0.45), chartCavanHeight)];
            if (_yValues.count>1) { //校准图像位置与横线位置出现的偏差
                bar.yInsetChart = JAYLabelHeight/2.0;
            }else{
                bar.yInsetChart = JAYLabelHeight+JAYLabelHeight/6.0;
            }
            bar.barColor = [_colors objectAtIndex:i];
            bar.grade = grade;
            bar.barValue = value;
            [myScrollView addSubview:bar];
            
        }
    }
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}

@end
