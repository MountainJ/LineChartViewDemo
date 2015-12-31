//
//  ViewController.m
//  jayHistogramDemo
//
//  Created by JayZY on 15/11/10.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ViewController.h"

#import "JAYColor.h"
#import  "JAYChart.h"


@interface ViewController ()<JAYChartDataSource>
{
    JAYChart *chartView;
    UILabel *_barValueLabel;
    JAYChart *_lineChartView;

}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     该Demo需求:
     纵坐标需要设置上限,下限两个特殊值,两个特殊值用横线划出便于分辨;
     横坐标的数据可以点击查看数值的大小;
     超过上限值或者低于下限值的进行特殊标注;
     在显示时间下面用颜色标明图标代表的是什么...
     */
    /*
   
     */
    self.view.backgroundColor = JAYLightGrey;
    //添加柱状图
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 64, 120, 30);
    [btn setTitle:@"添加Histogram" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
//    [btn addTarget:self action:@selector(addHistoGram:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UIButton *lineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lineBtn.frame = CGRectMake(20, CGRectGetMaxY(btn.frame)+20, 120, 30);
    [lineBtn setTitle:@"添加LineView" forState:UIControlStateNormal];
    lineBtn.backgroundColor = [UIColor greenColor];
    [lineBtn addTarget:self action:@selector(addLineView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lineBtn];
    
    //删除柱状图
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteBtn.frame = CGRectMake(CGRectGetMaxX(btn.frame)+10, CGRectGetMinY(btn.frame), CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
    [deleteBtn setTitle:@"删除Histogram" forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor greenColor];
    [deleteBtn addTarget:self action:@selector(deleteHistoGram:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    //
    UIButton *deleteLineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteLineBtn.frame = CGRectMake(CGRectGetMaxX(lineBtn.frame)+10, CGRectGetMinY(lineBtn.frame), CGRectGetWidth(lineBtn.frame), CGRectGetHeight(lineBtn.frame));
    [deleteLineBtn setTitle:@"删除LineView" forState:UIControlStateNormal];
    deleteLineBtn.backgroundColor = [UIColor greenColor];
    [deleteLineBtn addTarget:self action:@selector(deleteLineView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteLineBtn];

}

- (void)showValue:(NSNotification *)notif
{
    NSNumber *numberV =(NSNumber *)notif.userInfo[@"value"];
    _barValueLabel.text =[NSString stringWithFormat:@"%f", [numberV floatValue]];
}



//横坐标标题数组
- (NSArray *)JAYChart_xLableArray:(JAYChart *)chart
{
    NSArray  *xLabels = @[@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09",@"12/09\n18:09"];
    return xLabels;
}

//数值多重数组
- (NSArray *)JAYChart_yValueArray:(JAYChart *)chart
{
    NSArray *ary = @[@"99",@"88",@"85",@"89",@"92",@"100",@"111",@"100",@"98",@"112",@"112",@"96"];
    NSArray *ary1 = @[@"81",@"77",@"68",@"78",@"72",@"73",@"82",@"83",@"80",@"85",@"90",@"68"];
//    NSArray *ary2 = @[@"70",@"55",@"69",@"59",@"102",@"104",@"121",@"99",@"96",@"39",@"77",@"84"];
    NSArray  *yValues = @[ary];//1组数据
    yValues = @[ary,ary1];//2组数据
//    yValues = @[ary,ary1,ary2];//3组数据
    return yValues;
}

//设置Y轴需要显示的数值范围，最大值-最小值
- (CGRange)JAYChartChooseRangeInLineChart:(JAYChart *)chart
{
        //这里设置的是需要正常显示的范围,即最大值最小值
        return CGRangeMake(240, 00);
}
//2组数值区域
- (JAYGroupRange)JAYGroupChartMarkRangeInLineChart:(JAYChart *)chart
{
    CGRange range1 = CGRangeMake(140, 90);
    CGRange range2 = CGRangeMake(90, 60);
    return JAYGroupRangeMake(range1, range2);
    
}

//设置正常范围需要渲染的背景
- (CGRange)JAYChartMarkRangeInLineChart:(JAYChart *)chart
{
    return CGRangeMake(135, 65);
}

//设置多组数据不同柱状条颜色
- (NSArray *)JAYChart_ColorArray:(JAYChart *)chart
{
    return @[JAYBrown ,JAYBlue];
}



#pragma mark -添加折线图
- (void)addLineView:(UIButton *)btn
{
    if (_lineChartView) {
        return;
    }
    _lineChartView = [[JAYChart alloc]initwithJAYChartDataFrame:CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width-20, 300)
                                              withSource:self];
    
    _lineChartView.backgroundColor = JAYWhite;
    _lineChartView.maxDotsNumberForX = 7;
    _lineChartView.strokeDuration = 4.f;
    
    [_lineChartView showInView:self.view];
    
}


#pragma mark - 删除柱状图
- (void)deleteHistoGram:(UIButton *)btn
{
    [chartView removeFromSuperview];
     chartView = nil;
    _barValueLabel.text = nil;
}

#pragma mark - 删折线图
- (void)deleteLineView:(UIButton *)btn
{
    [_lineChartView removeFromSuperview];
    _lineChartView = nil;
    _barValueLabel.text = nil;
}
//判断显示横线条
- (BOOL)JAYChart:(JAYChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

@end
