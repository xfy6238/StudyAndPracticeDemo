//
//  StrategicController.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/6/30.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "StrategicController.h"
#import "PushModalController.h"

@interface StrategicController ()

@end

@implementation StrategicController



- (instancetype)init
{
    self = [super init];
    if (self) {
        // 关键的弹幕，让此控制器背景 为 设置的半透明颜色
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }else{
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        //
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //隐藏导航栏
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self doSomeThing];
    
    
//    [self addAView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)prefersStatusBarHidden

{
    
    return YES;
    
}


- (IBAction)btnAction:(UIButton *)sender {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    PushModalController *con = [[PushModalController alloc]init];
    [self presentViewController:con animated:YES completion:^{
    }];
}



//mark: 添加一个白色视图(动画)
- (void)addAView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [UIView animateWithDuration:0.3 animations:^{
       
        bgView.backgroundColor = [UIColor grayColor];
        bgView.alpha = 0.1;
        [self.view addSubview:bgView];
    }];
}

//mark: 第一种
- (void)doSomeThing{
    
}

//1. 将复杂的业务封装成invocation

//- (NSInvocation *)invcocationWithMethod:(SEL)selector {
//
//
//}


@end
