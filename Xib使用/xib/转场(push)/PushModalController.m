//
//  PushModalController.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/6/30.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "PushModalController.h"

@interface PushModalController ()

@end

@implementation PushModalController


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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"*******进入此方法");
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)btnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)tapAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
