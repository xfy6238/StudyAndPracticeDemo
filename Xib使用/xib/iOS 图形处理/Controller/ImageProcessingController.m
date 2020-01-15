//
//  ImageProcessingController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/7/18.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "ImageProcessingController.h"
#import "GraphicsView.h"
#import "SelectView.h"

@interface ImageProcessingController ()

@end

@implementation ImageProcessingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GraphicsView *view = [[GraphicsView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:view];
    

    /*
    UIImage *image = [self drawImageViewRect:CGRectMake(100, 100, 100, 100)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    imageView.image = image;
    [self.view addSubview:imageView];
    */
    
    SelectView *selectView = [SelectView customInit];
    selectView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 100);
    [self.view addSubview:selectView];
    
    CGFloat xPoint = 10;
    CGFloat yPoint = 100;
    CGFloat width = 50;

//MARK: 使用for循环创建多个视图, 查看视图层级关系
    for (int i = 0; i < 4; i ++) {
        
        xPoint += 10 + width;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(xPoint, yPoint, width, width)];
        view.backgroundColor = UIColor.blackColor;
        [self.view addSubview:view];
    }
    
    
    
/*
    
    xPoint = 10;
    yPoint = yPoint + width +10;

    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(xPoint, yPoint, width, width)];
    view1.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:view1];
    
    
    //  下面这行代码能够将view2  调整到父视图的最下面
//    [self.view bringSubviewToFront:view1];
    
    xPoint += 10 + width;

    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(xPoint, yPoint, width, width)];
    view2.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:view2];
    
    //  下面这行代码能够将view2  调整到父视图的最下面
//    [self.view bringSubviewToFront:view2];
    
    
    xPoint += 10 + width;

    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(xPoint, yPoint, width, width)];
    view3.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:view3];
    
    //  下面这行代码能够将view2  调整到父视图的最下面
//    [self.view bringSubviewToFront:view3];
    
    xPoint += 10 + width;

     UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(xPoint, yPoint, width, width)];
     view4.backgroundColor = UIColor.orangeColor;
     [self.view addSubview:view4];
    
    //  下面这行代码能够将view2  调整到父视图的最下面
//    [self.view bringSubviewToFront:view4];
    */
}

- (UIImage *)drawImageViewRect:(CGRect)rect{
    //    1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    2. 拼接路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startP = CGPointMake(10, 125);
    CGPoint endP = CGPointMake(240, 125);
    CGPoint controlP = CGPointMake(125, 0);
    [path moveToPoint:startP];
    [path addQuadCurveToPoint:endP controlPoint:controlP];
    
    //    3.把路径添加到上下文中
    CGContextAddPath(ctx, path.CGPath);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //    4.渲染上下文到视图
    CGContextStrokePath(ctx);
    return image;
}










@end
