//
//  JAYChart.h
//	Version 0.1
//  JAYChart
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//  数据源存储

#import <UIKit/UIKit.h>
#import "JAYChart.h"
#import "JAYColor.h"
#import "JAYLineChart.h"
#import "JAYBarChart.h"
//类型
typedef enum {
	JAYChartLineStyle,
	JAYChartBarStyle
} JAYChartStyle;


@class JAYChart;
@protocol JAYChartDataSource <NSObject>

@required
//横坐标标题数组
- (NSArray *)JAYChart_xLableArray:(JAYChart *)chart;

//数值多重数组
- (NSArray *)JAYChart_yValueArray:(JAYChart *)chart;

@optional
//颜色数组
- (NSArray *)JAYChart_ColorArray:(JAYChart *)chart;

//显示数值范围
- (CGRange)JAYChartChooseRangeInLineChart:(JAYChart *)chart;

#pragma mark 折线图专享功能
//标记数值区域
- (CGRange)JAYChartMarkRangeInLineChart:(JAYChart *)chart;

//判断显示横线条
- (BOOL)JAYChart:(JAYChart *)chart ShowHorizonLineAtIndex:(NSInteger)index;

//判断显示最大最小值
- (BOOL)JAYChart:(JAYChart *)chart ShowMaxMinAtIndex:(NSInteger)index;
@end


@interface JAYChart : UIView

//是否自动显示范围
@property (nonatomic, assign) BOOL showRange;

@property (assign) JAYChartStyle chartStyle;

-(id)initwithJAYChartDataFrame:(CGRect)rect withSource:(id<JAYChartDataSource>)dataSource withStyle:(JAYChartStyle)style;

- (void)showInView:(UIView *)view;

-(void)strokeChart;

@end
