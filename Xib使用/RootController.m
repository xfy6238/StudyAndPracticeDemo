//
//  RootController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/7/27.
//  Copyright © 2017年 微光星芒. All rights reserved.
//


#import "RootController.h"
#import "ThirdController.h"
#import "AnimationController.h"
#import "TableViewController.h"
#import "BlockController.h"
#import "YYkitController.h"
#import "MoreController.h"

typedef NS_ENUM(NSUInteger, TestEnumType) {
    TestEnumTypeOne,
    TestEnumTypeTwo,
    TestEnumTypeThree,
};

@interface RootController ()

@property (weak, nonatomic) IBOutlet UILabel *phoneLbab;
@property (weak, nonatomic) IBOutlet UILabel *passWordLab;


@property (weak, nonatomic) NSString *weakStr1;
@property (weak, nonatomic) NSString *weakStr2;


@end

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"*******%@",biliStr);
    
    NSArray *array = @[@(TestEnumTypeOne),@(TestEnumTypeTwo),@(TestEnumTypeThree)];

    for (int i = 0; i < array.count; i++) {
        //强制类型转换
        TestEnumType type = (TestEnumType)[array[i] integerValue];
        NSLog(@"当前枚举类型*******%ld",type);
    }
 
    if (KiPhoneX) {
        NSLog(@"*******这是iPhone X 系列");
    }

    CGSize size = [[UIScreen mainScreen] currentMode].size;
    NSLog(@"*******%@",NSStringFromCGSize(size));
    
    
    
    
    _weakStr1 = @"1";
    _weakStr2 = _weakStr1;
    
    
    NSLog(@"%@ %@",_weakStr1, _weakStr2);
    _weakStr1 = nil;
    
    NSLog(@"%@ ", _weakStr2);

}

//进入下一界面
- (IBAction)onClick:(UIButton *)sender {
    
    ThirdController *controller = [[ThirdController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

//动画
- (IBAction)animationOnClick:(UIButton *)sender {
    AnimationController *controller = [[AnimationController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

//表视图
- (IBAction)tableViewOnClick:(UIButton *)sender {
    TableViewController *controller = [[TableViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)blockOnClick:(UIButton *)sender {
    
    BlockController *controller = [[BlockController alloc]init];
   
    
    /*
    NSLog(@"Stack trace: %@",[NSThread callStackSymbols]);
    NSLog(@"Current selector: %@",NSStringFromSelector(_cmd));
    NSLog(@"Object class: %@",NSStringFromClass([self class]));
    NSLog(@"Filename: %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent]);
     */
    
    
    [controller returnValue:^(NSString *str) {
        NSLog(@"resut = %@",str);
    }];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)yyKitOnClick:(UIButton *)sender {
    
    YYkitController *controller = [[YYkitController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

//里面有更多的东西
- (IBAction)moreWorld:(UIButton *)sender {
    MoreController *controller= [[MoreController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
