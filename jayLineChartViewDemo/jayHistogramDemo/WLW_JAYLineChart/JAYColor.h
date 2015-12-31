//
//  JAYColor.h
//  JAYChart
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 *  System Versioning Preprocessor Macros
 */

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define JAYLabelHeight    10
#define JAYYLabelwidth     30
#define JAYTagLabelwidth     80

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define JAYGrey         [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0f]
#define JAYLightBlue    [UIColor colorWithRed:94.0/255.0 green:147.0/255.0 blue:196.0/255.0 alpha:1.0f]
#define JAYGreen        [UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f]
#define JAYTitleColor   [UIColor colorWithRed:0.0/255.0 green:189.0/255.0 blue:113.0/255.0 alpha:1.0f]
#define JAYButtonGrey   [UIColor colorWithRed:141.0/255.0 green:141.0/255.0 blue:141.0/255.0 alpha:1.0f]
#define JAYFreshGreen   [UIColor colorWithRed:77.0/255.0 green:196.0/255.0 blue:122.0/255.0 alpha:1.0f]
#define JAYRed          [UIColor colorWithRed:245.0/255.0 green:94.0/255.0 blue:78.0/255.0 alpha:1.0f]
#define JAYMauve        [UIColor colorWithRed:88.0/255.0 green:75.0/255.0 blue:103.0/255.0 alpha:1.0f]
#define JAYBrown        [UIColor colorWithRed:119.0/255.0 green:107.0/255.0 blue:95.0/255.0 alpha:1.0f]
#define JAYBlue         [UIColor colorWithRed:82.0/255.0 green:116.0/255.0 blue:188.0/255.0 alpha:1.0f]
#define JAYDarkBlue     [UIColor colorWithRed:121.0/255.0 green:134.0/255.0 blue:142.0/255.0 alpha:1.0f]
#define JAYYellow       [UIColor colorWithRed:242.0/255.0 green:197.0/255.0 blue:117.0/255.0 alpha:1.0f]
#define JAYWhite        [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f]
#define JAYDeepGrey     [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1.0f]
#define JAYPinkGrey     [UIColor colorWithRed:200.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0f]
#define JAYHealYellow   [UIColor colorWithRed:245.0/255.0 green:242.0/255.0 blue:238.0/255.0 alpha:1.0f]
#define JAYLightGrey    [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0f]
#define JAYCleanGrey    [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0f]
#define JAYLightYellow  [UIColor colorWithRed:241.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0f]
#define JAYDarkYellow   [UIColor colorWithRed:152.0/255.0 green:150.0/255.0 blue:159.0/255.0 alpha:1.0f]
#define JAYPinkDark     [UIColor colorWithRed:170.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1.0f]
#define JAYCloudWhite   [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0f]
#define JAYBlack        [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0f]
#define JAYStarYellow   [UIColor colorWithRed:252.0/255.0 green:223.0/255.0 blue:101.0/255.0 alpha:1.0f]
#define JAYTwitterColor [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:243.0/255.0 alpha:1.0]
#define JAYWeiboColor   [UIColor colorWithRed:250.0/255.0 green:0.0/255.0 blue:33.0/255.0 alpha:1.0]
#define JAYiOSGreenColor [UIColor colorWithRed:98.0/255.0 green:247.0/255.0 blue:77.0/255.0 alpha:1.0]
#define JAYRandomColor   [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f]
//数据点连线颜色
#define JAYStrokeLineColor  [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1.0]
//坐标轴横竖线
#define kFirstLineColor [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1.0]

//虚线颜色
#define kDashLineColor [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0]

//高压值背景
#define JAYHighValueBackgoundColor  [UIColor colorWithRed:229/255.0 green:255/255.0 blue:231/255.0 alpha:1.0]
//低压值背景
#define JAYLowValueBackgoundColor  [UIColor colorWithRed:229/255.0 green:247/255.0 blue:255/255.0 alpha:1.0]

//心率背景
#define JAYHeartRateBackgoundColor  [UIColor colorWithRed:255/255.0 green:253/255.0 blue:223/255.0 alpha:1.0]
// 血糖背景 
#define JAYBloodSugarBackColor [UIColor colorWithRed:239/255.0 green:255/255.0 blue:223/255.0 alpha:1.0]





//范围
struct Range {
    CGFloat max;
    CGFloat min;
};
typedef struct Range CGRange;
CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange
CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}
static const CGRange CGRangeZero = {0,0};

//2组标记
struct groupRange {
    CGRange range1;
    CGRange range2;
};
typedef struct groupRange JAYGroupRange;
CG_INLINE JAYGroupRange JAYGroupRangeMake (CGRange range1, CGRange range2);

CG_INLINE JAYGroupRange
JAYGroupRangeMake (CGRange range1, CGRange range2){
    JAYGroupRange g;
    g.range1 = range1;
    g.range2 = range2;
    return g;
}


@interface JAYColor : NSObject
- (UIImage *)imageFromColor:(UIColor *)color;
@end
