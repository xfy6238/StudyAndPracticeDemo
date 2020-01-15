//
//  ForthController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/8.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "ForthController.h"
#import "ScrollViewController.h"

@interface ForthController ()

@end

@implementation ForthController


- (instancetype)init
{
    self = [super init];
    if (self) {
        // 关键的弹幕，让此控制器背景 为 设置的半透明颜色
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }else{
            self.modalPresentationStyle=UIModalPresentationCurrentContext;
        }
        //
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
    }
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (IBAction)backController:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)nextPage:(UIButton *)sender {
    
    
    NSLog(@"%@",self.navigationController.viewControllers);
    
    ScrollViewController *controller = [[ScrollViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}


@end
