//
//  JAYChart.m
//  JAYChart
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//

#import "JAYChart.h"

@interface JAYChart ()

@property (strong, nonatomic) JAYLineChart * lineChart;

@property (strong, nonatomic) JAYBarChart * barChart;

@property (assign, nonatomic) id<JAYChartDataSource> dataSource;

@end

@implementation JAYChart

-(id)initwithJAYChartDataFrame:(CGRect)rect withSource:(id<JAYChartDataSource>)dataSource withStyle:(JAYChartStyle)style{
    self.dataSource = dataSource;
    self.chartStyle = style;
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
	if (self.chartStyle == JAYChartLineStyle) { //折线图
        if(!_lineChart){
            _lineChart = [[JAYLineChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self addSubview:_lineChart];
        }
        //选择标记范围
        if ([self.dataSource respondsToSelector:@selector(JAYChartMarkRangeInLineChart:)]) {
            [_lineChart setMarkRange:[self.dataSource JAYChartMarkRangeInLineChart:self]];
        }
        //选择显示范围
        if ([self.dataSource respondsToSelector:@selector(JAYChartChooseRangeInLineChart:)]) {
            [_lineChart setChooseRange:[self.dataSource JAYChartChooseRangeInLineChart:self]];
        }
        //显示颜色
        if ([self.dataSource respondsToSelector:@selector(JAYChart_ColorArray:)]) {
            [_lineChart setColors:[self.dataSource JAYChart_ColorArray:self]];
        }
        //显示横线
        if ([self.dataSource respondsToSelector:@selector(JAYChart:ShowHorizonLineAtIndex:)]) {
            NSMutableArray *showHorizonArray = [[NSMutableArray alloc]init];
            for (int i=0; i<5; i++) {
                if ([self.dataSource JAYChart:self ShowHorizonLineAtIndex:i]) {
                    [showHorizonArray addObject:@"1"];
                }else{
                    [showHorizonArray addObject:@"0"];
                }
            }
            [_lineChart setShowHorizonLine:showHorizonArray];

        }
        //判断显示最大最小值
        if ([self.dataSource respondsToSelector:@selector(JAYChart:ShowMaxMinAtIndex:)]) {
            NSMutableArray *showMaxMinArray = [[NSMutableArray alloc]init];
            NSArray *y_values = [self.dataSource JAYChart_yValueArray:self];
            if (y_values.count>0){
                for (int i=0; i<y_values.count; i++) {
                    if ([self.dataSource JAYChart:self ShowMaxMinAtIndex:i]) {
                        [showMaxMinArray addObject:@"1"];
                    }else{
                        [showMaxMinArray addObject:@"0"];
                    }
                }
                _lineChart.ShowMaxMinArray = showMaxMinArray;
            }
        }
        
		[_lineChart setYValues:[self.dataSource JAYChart_yValueArray:self]];
		[_lineChart setXLabels:[self.dataSource JAYChart_xLableArray:self]];
        
        /**
         *  这个方法很重要,根据数据进行渲染
         */
		[_lineChart strokeChart];

	}else if (self.chartStyle == JAYChartBarStyle)//柱状图
	{
        if (!_barChart) {
            _barChart = [[JAYBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self addSubview:_barChart];
        }
        if ([self.dataSource respondsToSelector:@selector(JAYChartChooseRangeInLineChart:)]) {
            [_barChart setChooseRange:[self.dataSource JAYChartChooseRangeInLineChart:self]];
        }
        if ([self.dataSource respondsToSelector:@selector(JAYChart_ColorArray:)]) {
            [_barChart setColors:[self.dataSource JAYChart_ColorArray:self]];
        }
		[_barChart setYValues:[self.dataSource JAYChart_yValueArray:self]];
		[_barChart setXLabels:[self.dataSource JAYChart_xLableArray:self]];
        
        [_barChart strokeChart];
	}
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



@end
