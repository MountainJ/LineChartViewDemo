//
//  JAYBarChart.h
//  JAYChartDemo
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//    控件布局

#import <UIKit/UIKit.h>
#import "JAYColor.h"

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define JAYLabelHeight   10
#define JAYYLabelwidth   30

@interface JAYBarChart : UIView

/**
 * This method will call and troke the line in animation
 */

-(void)strokeChart;

@property (strong, nonatomic) NSArray * xLabels;

@property (strong, nonatomic) NSArray * yLabels;

@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic) CGFloat xLabelWidth;

@property (nonatomic) float yValueMax;
@property (nonatomic) float yValueMin;

@property (nonatomic, assign) BOOL showRange;

@property (nonatomic, assign) CGRange chooseRange;

@property (nonatomic, strong) NSArray * colors;

- (NSArray *)chartLabelsForX;

@end
