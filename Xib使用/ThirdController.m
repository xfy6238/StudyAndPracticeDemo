//
//  ThirdController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/7.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "ThirdController.h"
#import "ForthController.h"
#import "ScrollViewController.h"

@interface ThirdController ()

@property (weak, nonatomic) IBOutlet UILabel *abcTitleLab; //农行优惠标题
@property (weak, nonatomic) IBOutlet UILabel *abcPriceLab; //农行优惠数

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *abcTitleHeight; //农行优惠标题的高度约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accPriceHeight; //农行优惠钱数高度约束




@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTopConstraint;


@end

@implementation ThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.backItem.title = @"支付";
    //选择自己喜欢的颜色

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    

}
- (IBAction)nextController:(UIButton *)sender {
    
    ForthController *controller = [[ForthController alloc]init];
    
    //当前的controller是present形式展现出来的,所以不在controller内,从而重新进行了设置; 但是这样做会丢失之前的nav中的viewController,但对功能并没有影响;
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:controller];
    //这里隐藏导航栏(记得在你需要的地方,再次显示出来)
//    controller.navigationController.navigationBar.hidden = YES;
    
    //controller会以present的形式展现出来,没有导航栏;  所以,
    [self presentViewController:navController animated:YES completion:nil];
//    [self presentViewController:navController animated:NO completion:nil];

}

- (IBAction)changeBtnOnClick:(UIButton *)sender {
    
    
    [UIView animateWithDuration:0.5 animations:^{
        sender.transform = CGAffineTransformMakeScale(0.8, 0.8);

    } completion:^(BOOL finished) {
        sender.transform = CGAffineTransformMakeScale(1.0, 1.0);

    }];
    
    BOOL selected = sender.selected;
    if (!selected) {
        _btnTopConstraint.constant = 0;

    }else{
        _btnTopConstraint.constant = 20;
        
    }
    [self changeViewsConstrantWithChange:selected];
    sender.selected = !sender.selected;

}



- (void)changeViewsConstrantWithChange:(BOOL)change{
    if (change) {
        _abcTitleLab.hidden = YES;
        _abcTitleHeight.constant = 0;
        
        _abcPriceLab.hidden = YES;
        _accPriceHeight.constant = 0;
    }else{
        _abcTitleLab.hidden = NO;
        _abcTitleHeight.constant = 20;
        
        _abcPriceLab.hidden = NO;
        _accPriceHeight.constant = 20;
    }
}






@end
