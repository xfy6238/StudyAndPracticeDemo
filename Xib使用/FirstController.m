//
//  FirstController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/4.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "FirstController.h"

@interface FirstController ()

@property (weak, nonatomic) IBOutlet UILabel *sizeLab;
@property (weak, nonatomic) IBOutlet UILabel *normalLab;
@property (weak, nonatomic) IBOutlet UILabel *nextLab;

@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _sizeLab.text = @"xib使用的本质, 其实还是frame,只是换了个形式, 感觉多了一个比例. 使用frame时 这个比例可以自己去计算 但是使用xib  换成了系统去计算这个比例";
    _sizeLab.text =@"nil";
    
    
    _normalLab.text = @"自适应宽度";
    _nextLab.text =@"哈哈哈哈";

}



@end
