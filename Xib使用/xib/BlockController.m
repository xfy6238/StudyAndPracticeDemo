//
//  BlockController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/17.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "BlockController.h"


//顶一个block时.只知道这个block需要传入的参数和返回的值; 这个block具体是干什么的,此时还不知道,所以说它是一个匿名函数,因为这个时候还不知道究竟是做什么功能的;
//所以一个block可以在多个地方使用, 因为它只是定义了一个函数的形式,并没有定义函数的功能
typedef void(^passValue)(NSString *str);


//定义了一个block类型 可以创建多个这种类型的实例变量
typedef void(^firstBlock)(NSString *str);


@interface BlockController ()


@property(nonatomic,copy) firstBlock firstBlock;

@property (nonatomic, strong) NSMutableString *mutaStr;

@property (nonatomic, strong) NSMutableArray *array;

@end


NSString *const biliStr = @"哔哩哔哩";

@interface BlockController()


@end

@implementation BlockController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_mutaStr setValue:@"" forKey:@"1"];
    
    
    int buttonId;

    
    /*
    //a. 实现一个类型的block
    _firstBlock = ^(NSString *str){
        NSLog(@"这是一个block 传入的参数是: %@",str);
    };
    //b. 调用一次这种类型的block
    _firstBlock(@"hello");
    
    //2. 声明并赋值定义一个block变量
    int(^addBlock)(int,int) = ^(int x, int y){
        return x + y;
    };
    
    //3. 调用这个方法,block作为参数
//    [self userBlockForOc:addBlock];
    
    // 将2,3 两步传入
    [self userBlockForOc:^int(int x, int y) {
        return x - y;
    }];
     
     */
    
    //block和全局变量和局部变量
    /*
    __block NSMutableString *str = [@"abc" mutableCopy];
    _mutaStr = [@"123" mutableCopy];
    void (^blk)(int) = ^(int x){
        str = [@"cba" mutableCopy];
        NSLog(@"*******%@",str);
        [str appendString:@"abc"];
        NSLog(@"*******%@",str);
        
        
        _mutaStr = [@"321" mutableCopy];
        NSLog(@"*******%@",_mutaStr);
    };

    blk(5);
    
    */
    
    [self ceateGlobalBlock];
    
}




//MARK: 视图将消失
- (void)viewWillDisappear:(BOOL)animated{
    if (_passBlock) {
        _passBlock(@"hello");
    }
}

//block传值    block作为一个参数在方法里
- (void)returnValue:(passValue)passBlock{
    _passBlock = passBlock;
}


//1. 定义了一个形参为block的方法
- (void)userBlockForOc:(int(^)(int ,int))aBlock{
    NSLog(@"result = %d",aBlock(100,100));
}


/**
    block的三种类型
    _NSConcreteGlobalBlock  保存在数据区域
    _NSConcreteMallocBlock  保存在堆控件
    _NSConcreteStackBlock   保存在栈控件
 */


#pragma 创建一个全局block
//保存在数据区域
-(void)ceateGlobalBlock{
    
    //2
    NSInteger privateLocalInteger = 10;
    
    
    //1. 定义一个block
    void(^privaeLocalBlock)(void) = ^(){

        NSLog(@"*******%@",_mutaStr);
        
//        NSLog(@"*******%@",privaeLocalBlock);
    };
    
    privaeLocalBlock();
    NSLog(@"block %@",privaeLocalBlock);
    
}












@end
