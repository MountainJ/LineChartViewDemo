//
//  JAYColor.m
//  JAYChart
//
//  Created by JayZY on 14-7-24.
//  Copyright (c) 2014年 MountainJ. All rights reserved.
//

#import "JAYColor.h"

@implementation JAYColor

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(UIImage *)imageFromColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}




@end
