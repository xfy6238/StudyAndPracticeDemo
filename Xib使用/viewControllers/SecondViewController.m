//
//  SecondViewController.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/6/24.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)backBtnAction:(UIButton *)sender {
//    if (self.backBlock) {
//        self.backBlock();
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)payEnd:(UIButton *)sender {
    if (self.completeBlock) {
        self.completeBlock();
    }
    
}


 
@end
