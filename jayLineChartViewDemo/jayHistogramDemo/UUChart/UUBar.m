//
//  UUBar.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUBar.h"
#import "UUColor.h"

@implementation UUBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapSquare;
		_chartLine.fillColor   = [[UIColor whiteColor] CGColor];
		_chartLine.lineWidth   = self.frame.size.width;
		_chartLine.strokeEnd   = 0.0;
		self.clipsToBounds = YES;
		[self.layer addSublayer:_chartLine];
		self.layer.cornerRadius = 2.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBarValue:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)showBarValue:(id)sender
{
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickValue" object:nil userInfo:@{@"value":[NSNumber numberWithFloat:self.barValue]}];
    _chartLine.strokeColor = [UUGreen CGColor];
    //考虑设置长按或者短按颜色突然变化然后变回原来的
   [UIView animateWithDuration:0.1 delay:1 options:0 animations:^{
       [weakSelf startUpAnimationTimeInterval:0.001];
   } completion:^(BOOL finished) {
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           _chartLine.strokeColor = [_barColor CGColor];
           [weakSelf startUpAnimationTimeInterval:0.001];
       });
   }];
}

-(void)setGrade:(float)grade
{
    if (grade==0)return;
	_grade = grade;
    if (_barColor) {
        _chartLine.strokeColor = [_barColor CGColor];
    }else{
        _chartLine.strokeColor = [UUBlue CGColor];
    }
    [self drawBezierPathLayer];
}

- (void)drawBezierPathLayer
{
    UIBezierPath *progresslinePath = [UIBezierPath bezierPath];
    [progresslinePath moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height+30)];
    [progresslinePath addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1 - _grade) * self.frame.size.height+self.yInsetChart)];
    
    [progresslinePath setLineWidth:1.0];
    [progresslinePath setLineCapStyle:kCGLineCapSquare];
    _chartLine.path = progresslinePath.CGPath;
    [self startUpAnimationTimeInterval:1.0f];
}

- (void)startUpAnimationTimeInterval:(float)duration
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _chartLine.strokeEnd = 1.0;
}

- (void)drawRect:(CGRect)rect
{
	//Draw BG
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextFillRect(context, rect);
}


@end
