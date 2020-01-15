
//
//  MeatlViewController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/7/13.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "MetalViewController.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

@interface MetalViewController ()

@property (nonatomic, copy) MTKView *mtkView;


@end

@implementation MetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    获得GPU, 提供以下能力:
//    查询设备状态
//     创建buffer和texture
//    指令转换和队列渲染进行指令的计算
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    if (device == nil) {
        NSLog(@"此设备不支持metal");
    }else{
        NSLog(@"*******这是一个支持metal的设备");
    }

//    创建一个渲染队列MTLCommandQueue,为单一,线程安全队列,确保指令按顺序执行, 存放的是要渲染的指令MTLCommandBuffer,可以支持多个MTLCommanndBuffer 同时编码
    id<MTLCommandQueue> queue = device.newCommandQueue;

//    需要使用MTKView进行绘制

    _mtkView = [[MTKView alloc] initWithFrame:self.view.frame device:device];
    [self.view addSubview:_mtkView];
    
//    渲染
//    简单的流程就是先构造 MTLCommandBuffer ，再配置 CommandEncoder ，包括配置资源文件，渲染管线等，再通过 CommandEncoder 进行编码，最后才能提交到队列中去。
//    直接操作GPU,所有的工作都是自己来完成
    
    //    创建buffer: 轻量级对象
    id<MTLCommandBuffer> commandBuffer = [queue commandBuffer];
//    执行
//    enqueue 顺序执行
//    commit 插队尽快执行 （如果前面有 commit 就还是排队等着）
//    监听buffer执行结果


    
    UIView __autoreleasing *thisIsNilView = nil;
    NSLog(@"1.0 指针指向的地址 %p*******指针本身地址: %p",thisIsNilView,&thisIsNilView);
    
    [self createViewWithSecRankPointer:&thisIsNilView];
    NSLog(@"4.0 指针指向的地址 %p*******指针本身地址: %p",thisIsNilView,&thisIsNilView);
}


-(void)createViewWithSecRankPointer:(UIView **)view{
    NSLog(@"2.0 指针指向的地址 %p*******指针本身地址: %p",*view,& *view);
    
    *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    NSLog(@"3.0 指针指向的地址 %p*******指针本身地址: %p",*view,& *view);
}

/*
 1.0 指针指向的地址 0x0*******指针本身地址: 0x7ffeeb136420
 2018-11-27 14:22:42.206871+0800 Xib使用[53015:8441548] 2.0 指针指向的地址 0x0*******指针本身地址: 0x7ffeeb136418
 2018-11-27 14:22:42.207010+0800 Xib使用[53015:8441548] 3.0 指针指向的地址 0x7fa6e2525420*******指针本身地址: 0x7ffeeb136418
 2018-11-27 14:22:42.207108+0800 Xib使用[53015:8441548] 4.0 指针指向的地址 0x7fa6e2525420*******指针本身地址: 0x7ffeeb136420
 */


@end
