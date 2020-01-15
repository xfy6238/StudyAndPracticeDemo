//
//  SelectView.m
//  Xib使用
//
//  Created by 胥福阳 on 2019/9/5.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "SelectView.h"

@interface SelectView ()

@property (weak, nonatomic) IBOutlet UILabel *firstLab;


@end

@implementation SelectView


//自定义一个快速初始化方法
+ (instancetype)customInit{
    // 封装Xib的加载过程
    NSLog(@"再执行这个");

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self bringSubviewToFront:self.firstLab];
    NSLog(@"先执行这个");
}

@end
