//
//  JAYChart.h
//	Version 0.1
//  JAYChart
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAYChart.h"
#import "JAYColor.h"
#import "JAYLineChart.h"

@class JAYChart;

@protocol JAYChartDataSource <NSObject>

@required

//横坐标标题数组
- (NSArray *)JAYChart_xLableArray:(JAYChart *)chart;

//纵坐标数值多重数组
- (NSArray *)JAYChart_yValueArray:(JAYChart *)chart;

@optional
//颜色数组
- (NSArray *)JAYChart_ColorArray:(JAYChart *)chart;

//显示数值范围
- (CGRange)JAYChartChooseRangeInLineChart:(JAYChart *)chart;

//1组数据标记区域
- (CGRange)JAYChartMarkRangeInLineChart:(JAYChart *)chart;

//2组数据标记区域
- (JAYGroupRange)JAYGroupChartMarkRangeInLineChart:(JAYChart *)chart;

//判断显示横线条
- (BOOL)JAYChart:(JAYChart *)chart ShowHorizonLineAtIndex:(NSInteger)index;

//判断是否显示某一行的纵坐标数值
- (BOOL)JAYChart:(JAYChart *)chart hideYLabelValueAtIndex:(NSInteger)index;


@end


@interface JAYChart : UIView
/**
 *  Y轴数值单位
 */
@property (nonatomic, copy) NSString *yLabelUnit;
/**
 *  图标的名称
 */
@property (nonatomic,copy) NSString *title;
/**
 *  描点绘图时间
 */
@property (nonatomic,assign) CGFloat strokeDuration;
/**
 *  单组数据单屏显示最多点数
 */
@property (nonatomic,assign) NSInteger maxDotsNumberForX;
/**
 *  单组数据单屏显示最多点数
 */
@property (nonatomic,assign) NSInteger numberOfLabelsForY;
/**
 * 显示点的数值
 */
@property (nonatomic,assign,getter=isShowDotValue) BOOL showDotValue;

-(id)initwithJAYChartDataFrame:(CGRect)rect withSource:(id<JAYChartDataSource>)dataSource;

- (void)showInView:(UIView *)view;

/*刷新表格数据*/
- (void)reloadLineChartData;


@end
