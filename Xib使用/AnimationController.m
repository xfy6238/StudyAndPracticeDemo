//
//  AnimationController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/11.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()
@property (weak, nonatomic) IBOutlet UIView *animationView1;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(animationView1Tap)];
    [_animationView1 addGestureRecognizer:tapGesture];
    
    [self loginAnimationShow];
}


- (void)animationView1Tap{
    CGRect view1Frame = _animationView1.frame;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
        
//    代码块实现动画
    

    /*
    [UIView animateWithDuration:1.0 animations:^{
        _animationView1.frame = CGRectMake(0, 0, view1Frame.size.width, view1Frame.size.height);
    } completion:^(BOOL finished) {
        _animationView1.frame = view1Frame;
    }];
    */

    //begin commit 模式
    
    /*
    [UIView beginAnimations:nil context:nil]; //开始动画
    [UIView setAnimationDuration:3.0];
    _animationView1.frame = CGRectMake(0, 0, view1Frame.size.width, view1Frame.size.height);
    [UIView commitAnimations];
     */
    
    //基础动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(screenW, screenH/2.0)];
    animation.duration = 1.0;
    [_animationView1.layer addAnimation:animation forKey:@"positionAnimation"];
    
}


- (void)loginAnimationShow{
    CGPoint accountCenter = _accountField.center;
    CGPoint passCenter = _passwordField.center;
    
    accountCenter.x -= 2 * _accountField.frame.size.width;
    passCenter.x = 2 *_passwordField.frame.size.width;
    //两个控件先放置在屏幕外侧
    _accountField.center = accountCenter;
    _passwordField.center = passCenter;

    //还原中心坐标
    accountCenter.x += 200;
    passCenter.x += 200;
    
    //开始执行动画(UIKit的动画API)
    
    //不是很美观
    [UIView animateWithDuration:0.5 animations:^{
        self.accountField.center = accountCenter;
//        self.passwordField.center = passCenter;
    }];
     
    
    //美观
    
    // UIViewAnimationOptionCurveEaseInOut 时间曲线函数，缓入缓出，中间快
    /*
    duration：  动画时长
    delay：  决定了动画在延迟多久之后执行
    options：用来决定动画的展示方式，接下来会进行讲解
    animations：转化成动画表示的代码
    completion：动画结束后执行的代码块
    */
    
    [UIView animateWithDuration:0.5 delay:0.35 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.passwordField.center = passCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.loginBtn.alpha = 1;
        }];
    }];
    
    //生成动画的属性大致分成三类: 坐标尺寸, 视图显示, 形态变化
    /*
     坐标尺寸: bounds, frame, center
     视图显示类: backgroundColor(颜色渐变,本质是系统不断修改tintcolor来实现的)
               alpah, 可以产生淡入淡出的效果
               hidden, 可以制作翻页隐藏的效果
               transform: 可以实现旋转,形变,移动,翻转
     
     */
    
    
    /**动画参数
     
     
     
     */
    
}


@end
