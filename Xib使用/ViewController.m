//
//  ViewController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/7/27.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//单例创建
+(UIViewController *)shareViewController{
    static dispatch_once_t onceToken;
    static ViewController *controller = nil;
    dispatch_once(&onceToken, ^{
        controller = [[ViewController alloc]init];
        //或者通过xib创建;
    });
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
