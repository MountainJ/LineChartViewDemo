//
//  JAYChart.m
//  JAYChart
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//

#import "JAYChart.h"

@interface JAYChart ()
{
    BOOL reloadFlag;
}


@property (strong, nonatomic) JAYLineChart * lineChart;


@property (assign, nonatomic) id<JAYChartDataSource> dataSource;

@end

@implementation JAYChart

-(id)initwithJAYChartDataFrame:(CGRect)rect withSource:(id<JAYChartDataSource>)dataSource {
    self.dataSource = dataSource;
    return [self initWithFrame:rect];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
    }
    return self;
}

-(void)setUpChart{
        if (reloadFlag) {
        [_lineChart removeFromSuperview];
        _lineChart = nil;
        }
    
        if(!_lineChart){
            _lineChart = [[JAYLineChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            if (_showDotValue) {
                _lineChart.showTextValue = YES;//显示数据点的数值
            }
            _lineChart.yUnitString = _yLabelUnit;
            _lineChart.viewTitle = _title;
            _lineChart.strokeAnimateDuration = _strokeDuration;
            if (_maxDotsNumberForX) {
                _lineChart.maxNumbersDotForX = _maxDotsNumberForX;
            }else{
            _lineChart.maxNumbersDotForX = 9;
            }
            if (!_numberOfLabelsForY) {
                _numberOfLabelsForY = 8;
            }
           _lineChart.numberLabelsForY = _numberOfLabelsForY;
            
            
            [self addSubview:_lineChart];
        }
        //选择标记范围
        if ([self.dataSource respondsToSelector:@selector(JAYChartMarkRangeInLineChart:)]) {
            [_lineChart setMarkRange:[self.dataSource JAYChartMarkRangeInLineChart:self]];
        }
        //2组数据背景渲染的范围
        if ([self.dataSource respondsToSelector:@selector(JAYGroupChartMarkRangeInLineChart:)]) {
            [_lineChart setGroupMarkRange:[self.dataSource JAYGroupChartMarkRangeInLineChart:self]];
        }
        //选择显示范围
        if ([self.dataSource respondsToSelector:@selector(JAYChartChooseRangeInLineChart:)]) {
            [_lineChart setChooseRange:[self.dataSource JAYChartChooseRangeInLineChart:self]];
        }
        //显示颜色
        if ([self.dataSource respondsToSelector:@selector(JAYChart_ColorArray:)]) {
            [_lineChart setColors:[self.dataSource JAYChart_ColorArray:self]];
        }
        //显示横线，默认显示
        if ([self.dataSource respondsToSelector:@selector(JAYChart:ShowHorizonLineAtIndex:)]) {
            NSMutableArray *showHorizonArray = [[NSMutableArray alloc]init];
            for (int i=0; i<_numberOfLabelsForY+1; i++) {
                if ([self.dataSource JAYChart:self ShowHorizonLineAtIndex:i]) {
                    [showHorizonArray addObject:@"1"];
                }else{
                    [showHorizonArray addObject:@"0"];
                }
            }
            [_lineChart setShowHorizonLine:showHorizonArray];
        }
    
    //显示纵坐标数值，默认显示
    if ([self.dataSource respondsToSelector:@selector(JAYChart:hideYLabelValueAtIndex:)]) {
        NSMutableArray *hideYlabelArray = [[NSMutableArray alloc]init];
        for (int i=0; i<_numberOfLabelsForY+1; i++) {
            if ([self.dataSource JAYChart:self hideYLabelValueAtIndex:i]) {
                [hideYlabelArray addObject:@"1"];
            }else{
                [hideYlabelArray addObject:@"0"];
            }
        }
        [_lineChart setHideYLabelValue:hideYlabelArray];
    }else{
        NSMutableArray *hideYlabelArray = [[NSMutableArray alloc]init];
        for (int i=0; i<_numberOfLabelsForY+1; i++) {
            
            if (i==0||i==_numberOfLabelsForY) {
                [hideYlabelArray addObject:@"1"];
            }else{
              [hideYlabelArray addObject:@"0"];
            }
        }
        [_lineChart setHideYLabelValue:hideYlabelArray];
    }
    
        [_lineChart setXLabels:[self.dataSource JAYChart_xLableArray:self]];
		[_lineChart setYValues:[self.dataSource JAYChart_yValueArray:self]];
        /**
         *  根据数据进行渲染
         */
		[_lineChart strokeChart];

}

- (void)showInView:(UIView *)view
{
    [self setUpChart];
    [view addSubview:self];
}

-(void)strokeChart
{
	[self setUpChart];
	
}

- (void)reloadLineChartData
{
    reloadFlag = YES;
    [self setUpChart];
}


@end
