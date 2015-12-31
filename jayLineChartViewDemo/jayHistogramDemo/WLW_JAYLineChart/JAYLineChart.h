//
//  JAYLineChart.h
//  JAYChartDemo
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JAYColor.h"

@interface JAYLineChart : UIView

@property (strong, nonatomic) NSArray * xLabels;

@property (strong, nonatomic) NSArray * yLabels;

@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic, strong) NSArray * colors;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) CGFloat yValueMax;
//1组
@property (nonatomic, assign) CGRange markRange;
//2组
@property (nonatomic,assign) JAYGroupRange groupMarkRange;

@property (nonatomic, assign) CGRange chooseRange;

@property (nonatomic, assign) BOOL showRange;

@property (nonatomic, retain) NSMutableArray *ShowHorizonLine;

@property (nonatomic, retain) NSMutableArray *hideYLabelValue;

@property (nonatomic, retain) NSMutableArray *ShowMaxMinArray;

@property (nonatomic,assign) CGFloat strokeAnimateDuration;//描点时间
@property (nonatomic,assign) NSInteger maxNumbersDotForX;//单屏单组数据点数
@property (nonatomic,assign) NSInteger numberLabelsForY;//单屏单组数据点数
/**
 *  显示点的数值
 */
@property (nonatomic,assign,getter=isShowTextValue) BOOL showTextValue;

@property (nonatomic,copy) NSString *yUnitString;

@property (nonatomic,copy) NSString *viewTitle;


@property (nonatomic,assign) BOOL reloadFlag;
-(void)strokeChart;

- (NSArray *)chartLabelsForX;

@end
