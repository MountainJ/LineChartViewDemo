//
//  JAYLineChart.h
//  JAYChartDemo
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JAYColor.h"

//#define chartMargin     10
//#define xLabelMargin    15
//#define yLabelMargin    15
//#define JAYLabelHeight    10
//#define JAYYLabelwidth     30
//#define JAYTagLabelwidth     80

@interface JAYLineChart : UIView

@property (strong, nonatomic) NSArray * xLabels;

@property (strong, nonatomic) NSArray * yLabels;

@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic, strong) NSArray * colors;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) CGFloat yValueMax;

@property (nonatomic, assign) CGRange markRange;

@property (nonatomic, assign) CGRange chooseRange;

@property (nonatomic, assign) BOOL showRange;

@property (nonatomic, retain) NSMutableArray *ShowHorizonLine;
@property (nonatomic, retain) NSMutableArray *ShowMaxMinArray;

-(void)strokeChart;

- (NSArray *)chartLabelsForX;

@end
