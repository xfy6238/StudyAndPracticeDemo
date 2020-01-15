
//
//  SandController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/3/30.
//  Copyright © 2018年 微光星芒. All rights reserved.
//
/*
 沙盒文件层级:
 Documnets
 Library
 tmp
 
 
 */


#import "SandController.h"

@interface SandController ()

@end

@implementation SandController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //获取程序的Home目录
    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"APP的主目录: %@",homeDirectory);
    
    //获取document的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"这应该是主路径: %@",documentsDirectory);
    
    
    UIImage*image = [UIImage imageNamed:@"ic_main_color@2x"];
    
    
}




@end
