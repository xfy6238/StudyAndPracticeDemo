
//
//  ChartController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/3/23.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "ChartController.h"
#import "AAChartView.h"

typedef NS_ENUM(NSUInteger, ShadowCornerStyle) {
    ShadowCornerStyleTop,
    ShadowCornerStyleBottom,
};

@interface ChartController ()

@property (nonatomic,strong) AAChartView *aaChartView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation ChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    /*
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = self.view.frame.size.height-250;
    _aaChartView = [[AAChartView alloc]init];
    _aaChartView.frame = CGRectMake(0, 60, chartViewWidth, chartViewHeight);
    ////禁用 AAChartView 滚动效果(默认不禁用)
    //self.aaChartView.scrollEnabled = NO;
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //_aaChartView.contentHeight = chartViewHeight;
    [self.view addSubview:_aaChartView];
    
    
    //配置模型
    AAChartModel *aaChartModel= AAObject(AAChartModel)
//    .chartTypeSet(AAChartTypeColumn)//设置图表的类型(这里以设置的为柱状图为例)
    .chartTypeSet(AAChartTypeAreaspline)//曲线图
    .titleSet(@"编程语言热度")//设置图表标题
    .subtitleSet(@"虚拟数据")//设置图表副标题
    .categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++"])//图表横轴的内容
    .yAxisTitleSet(@"摄氏度")//设置图表 y 轴的单位
    
    /*
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2019")
                 .dataSet(@[@0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2020")
                 .dataSet(@[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8]),
                 ])
    ;
     */
    /*
    .seriesSet(@[AAObject(AASeriesElement)
                .nameSet(@"")
                .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6]),]
               );
    
    [_aaChartView aa_drawChartWithChartModel:aaChartModel];
*/
    
    _backgroundView = [self  makeCornerWithView:_backgroundView cornerStyle:ShadowCornerStyleTop];
}



//切上圆角 下圆角
-(UIView *)makeCornerWithView:(UIView *)view cornerStyle:(ShadowCornerStyle)cornerStyle{
    
    UIRectCorner corner;
    if (cornerStyle == ShadowCornerStyleTop) {
        corner = UIRectCornerTopRight | UIRectCornerTopLeft;
    } else {
        corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
    
    cornerRadiusLayer.frame = view.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    view.layer.mask = cornerRadiusLayer;
    return view;
}


@end
