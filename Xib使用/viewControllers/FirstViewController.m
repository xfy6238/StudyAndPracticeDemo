//
//  FirstViewController.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/6/24.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface FirstViewController ()

@property (nonatomic, copy) NSMutableArray *payEndArray;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _payEndArray = [NSMutableArray array];
}


- (IBAction)nextBtnAction:(UIButton *)sender {
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    self.payEndArray = self.navigationController.viewControllers.mutableCopy;
    NSLog(@"*******%@",viewControllers);
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *newArray = [NSMutableArray array];
    for (UIViewController *con in viewControllers) {
        if ([con isKindOfClass:[self class]]) {
            break;
        }else{
            [newArray addObject:con];
        }
    }
    
    SecondViewController *con = [[SecondViewController alloc]init];
    con.backBlock = ^{
        
    };
    
    con.completeBlock = ^{
        NSMutableArray *newArray = [NSMutableArray array];
        for (UIViewController *con in self.payEndArray) {
            if ([con isKindOfClass:NSClassFromString(@"MoreController")]) {
                [newArray addObject:con];
                break;
            }else{
                [newArray addObject:con];
            }
        }
        
        //当前self 已经不在 weakSelf.navigationController.viewControllers 里了, 没有navigationControlle, 更没有viewControllers. 所以设置没有用
        
        ThirdViewController *con = [[ThirdViewController alloc]init];
        [newArray addObject:con];
        weakSelf.navigationController.viewControllers = newArray;
        
        NSLog(@"*******%@",weakSelf);
        NSLog(@"*******%@",weakSelf.navigationController);
        
        //需要判断nav 是否是navigation
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        nav.viewControllers = newArray;
        NSLog(@"APPdelegate拿到nav%@",nav);


    };
    
    [newArray addObject:con];
//    self.navigationController.viewControllers = newArray;
    
    NSLog(@"之前%@",self.navigationController);

    [self.navigationController setViewControllers:newArray];
    NSLog(@"之后%@",self.navigationController);

    
}

@end
