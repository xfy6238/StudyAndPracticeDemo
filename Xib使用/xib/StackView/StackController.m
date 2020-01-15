//
//  StackController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/11/22.
//  Copyright © 2018 微光星芒. All rights reserved.
//

#import "StackController.h"

@interface StackController ()

@end

@implementation StackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *datasource = [@[@"1",@"2",@"3",@"4"] mutableCopy];\
    NSLog(@"没赋值之前 :%p*******%p",datasource,&datasource);

    [self removeLastObject:datasource];
    
//    NSLog(@"*******%@",datasource);
}

-(void)removeLastObject:(NSMutableArray *)array{
    //拷贝的是地址 可以对其进行操作
    [array removeLastObject];
    NSLog(@"没赋值之前 :%p*******%p",array,&array);
//    array = [@[@"1",@"2",@"3",@"4",@"5"] mutableCopy];
//    NSLog(@"赋了不同的值之后的 :%p*******%p",array,&array);
    array = [@[@"1",@"2",@"3",@"4"] mutableCopy];
    NSLog(@"之后又赋值了相同的值 %p*******%p",array,&array);


    //赋值操作和其它方法操作 不一样
    //赋值 导致内部的变量重新指向一个地址 但是其它操作不会  为什么?
    //赋值是在内存中新开辟一块空间
    
}

@end
