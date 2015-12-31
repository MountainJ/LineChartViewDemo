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
     波形图横轴要求:
     1.体温监测:
     5分钟、10分钟、半小时、一小时、两小时、半天,一天;
     不超过60，下限不低于20;
     2.体重监测:
     天、五天、半月、一月;
     上下限不定;
     3.血压数据:
     同时显示收缩压,舒张压
     天、周平均、月平均
     两种上下限;
     4.血糖数据:
     天、周平均、月平均
     上下限;
     */
//    self.view.backgroundColor = JAYYellow;
    //添加柱状图
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 64, 120, 30);
    [btn setTitle:@"添加Histogram" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(addHistoGram:) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    //
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(80, self.view.frame.size.height-50, 100, 30)];
    label.backgroundColor = [UIColor redColor];
    _barValueLabel = label;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showValue:) name:@"clickValue" object:nil];
    [self.view addSubview:label];

}

- (void)showValue:(NSNotification *)notif
{
    NSNumber *numberV =(NSNumber *)notif.userInfo[@"value"];
    _barValueLabel.text =[NSString stringWithFormat:@"%f", [numberV floatValue]];
}



//横坐标标题数组
- (NSArray *)JAYChart_xLableArray:(JAYChart *)chart
{
    NSArray  *xLabels = @[@"时间1",@"时间2",@"时间3",@"时间4",@"时间5",@"时间6",@"时间7",@"时间8",@"时间9",@"时间10",@"时间11",@"时间12"];
    return xLabels;
}

//数值多重数组
- (NSArray *)JAYChart_yValueArray:(JAYChart *)chart
{
    NSArray *ary = @[@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100",@"110",@"120"];
    NSArray *ary1 = @[@"72",@"75",@"78",@"82",@"90",@"96",@"140",@"100",@"105",@"103",@"30",@"102"];
    NSArray  *yValues = @[ary1];//一组数据
//    yValues = @[ary,ary1];//两组数据
    return yValues;
}

//显示数值范围,根据最大数据和最小数据去设置
- (CGRange)JAYChartChooseRangeInLineChart:(JAYChart *)chart
{
        //这里设置的是需要正常显示的范围,即最大值最小值
        return CGRangeMake(90, 60);
}

//设置多组数据不同柱状条颜色
- (NSArray *)JAYChart_ColorArray:(JAYChart *)chart
{
    return @[JAYBrown ,JAYBlue];
}

#pragma mark -添加柱状图
- (void)addHistoGram:(UIButton *)btn
{
    if (chartView) {
        return;
    }
    chartView = [[JAYChart alloc]initwithJAYChartDataFrame:CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:JAYChartBarStyle];
    chartView.backgroundColor = JAYLightGrey;
    [chartView showInView:self.view];
    
}

#pragma mark -添加折线图
- (void)addLineView:(UIButton *)btn
{
    if (_lineChartView) {
        return;
    }
    _lineChartView = [[JAYChart alloc]initwithJAYChartDataFrame:CGRectMake(10, 350, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:JAYChartLineStyle];
    
    _lineChartView.backgroundColor = JAYLightGrey;
    _lineChartView.showRange = YES;
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
