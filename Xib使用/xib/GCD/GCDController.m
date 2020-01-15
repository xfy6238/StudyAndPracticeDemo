//
//  GCDController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/9/14.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "GCDController.h"

@interface GCDController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *timerBtn;
@property (nonatomic,assign) NSInteger timeCount;
@end

@implementation GCDController

- (void)viewDidLoad {
    [super viewDidLoad];


//    [self simpleUseOfGCD];
//    [self downloadImage];
    
//    串行队列 + 同步执行
//    [self GCDDemo1];

//    串行队列 + 异步任务
//    [self GCDDemo2];

//    并行队列 + 同步执行
//    [self GCDDemo3];

//    并行队列 + 异步执行
//    [self GCDDemo4];
    
    //死锁
//    [self GCDDemo5];
    
    //GCD定时器
    _timeCount = 16;
    
    //MARK: dispatch_group 完成功能
    [self orderImplementGCD];
    
    //MARK: 使用信号量完成此功能
//    [self dispatchSignal];
}



//打印一些线程队列
- (void)logDisptachQueue{
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //NSLog(@"当前主队列是:  %@",mainQueue);
    
    //获得其它所有队列
    dispatch_queue_t otherQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //NSLog(@"其它队列: %@",otherQueue);
    
    //同步函数(在当前线程中执行, 不具备开启新线程的能力)
    dispatch_sync(otherQueue, ^{
        //NSLog(@"同步 %@",[NSThread currentThread]);
    });
    
    //异步函数(在另一条线程中执行,具备开启新线程的能力)
    dispatch_async(otherQueue, ^{
        //NSLog(@"异步 %@",[NSThread currentThread]);
    });
    
    // 当前线程: {number = 1, name = main}
    // 同步 {number = 1, name = main}
    // 异步 {number = 3, name = (null)}  为什么number是3 呢?
    
    
}


//以下代码来源于http://www.jianshu.com/p/cbd01e54f6ea


//GCD的简单实用
- (void)simpleUseOfGCD{
    
    //获得全局队列,开辟了一个子线程,执行任务
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //NSLog(@"%@",[NSThread currentThread]);
//    });
    
    //线程间的通信.   开辟一个子线程,做一些耗时的操作, 操作完成之后,获得主线程,更新UI

    //在全局队列中开辟一个子线程, 用来做耗时操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"假装在努力下载 %@", [NSThread currentThread]);
        
        //下载完成之后,更新UI
        //回到主线程 进行UI数据更新
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"加载在更新UI... %@",[NSThread currentThread]);
        });
    });
    }


//开辟一个子线程,下载图片
- (void)downloadImage{

    NSURL *url = [NSURL URLWithString:@"http://atth.eduu.com/album/201203/12/1475134_1331559643qMzc.jpg"];

    //这个方法是将托图片以二进制流的形式下载下来,放在主线程中造成卡死现象,需要开辟一个子线程
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = image;
    });
}

//串行队列 + 同步任务
/**
    不开线程
    有序执行
 */

- (void)GCDDemo1{
    /**
        创建串行队列
        参数1: 队列的标识符
        参数2: 队列的属性,决定了队列是串行的还是并行的
        DISPATCH_QUEUE_SERIAL: 串行队列
     */
    dispatch_queue_t queue = dispatch_queue_create("GL", DISPATCH_QUEUE_SERIAL);
    
    for (NSInteger i = 0; i < 10; i ++) {
        dispatch_sync(queue, ^{
            NSLog(@"%zd %@",i, [NSThread currentThread]);
        });
    }
    
    NSLog(@"串行队列要一个一个执行完之后,才会执行这一句");
}


//串行队列 + 异步任务
- (void)GCDDemo2{
    dispatch_queue_t queue = dispatch_queue_create("GL", DISPATCH_QUEUE_SERIAL);
    
    for (NSInteger i = 0; i < 10; i ++) {
        dispatch_async(queue, ^{
            NSLog(@"%zd %@",i,[NSThread mainThread]);
        });
    }
    
    NSLog(@"先执行这一句,在执行之上的异步任务");
}


//并行队列 + 同步任务
/**
     不开线程
     有序执行
 */

- (void)GCDDemo3{
    //创建并行队列
    //DISPATCH_QUEUE_CONCURRENT: 并行队列
    //并行队列只能决定"是否"可以同时调度多个任务; 不能决定开不开线程
    dispatch_queue_t queue = dispatch_queue_create("GL", DISPATCH_QUEUE_CONCURRENT);
    for (NSInteger i = 0; i < 10; i ++) {
        dispatch_sync(queue, ^{
            NSLog(@"%zd %@",i,[NSThread mainThread]);
        });
    }
    
    NSLog(@"并行队列可以同时调度多个任务, 但是由于是同步任务,也只能是一个一个有序执行");
}

/**
     并行队列 + 异步任务
 */
- (void)GCDDemo4{
    //并行队列
    dispatch_queue_t queue = dispatch_queue_create("GL", DISPATCH_QUEUE_CONCURRENT);
    //异步任务
    for (NSInteger i = 0; i < 10; i ++) {
        dispatch_async(queue, ^{
            NSLog(@"%zd  %@",i,[NSThread mainThread]);
        });
    }
    NSLog(@"并行队列 + 异步任务 导致 任务执行没有顺序");
}

/**
     死循环
 */
- (void)GCDDemo5{
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
}

/**
    执行完ABC,在执行D
 */

- (void)orderImplementGCD{
    //使用enter / leave 这种形式, 让线程实际是按串行执行的;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"执行第一个任务");
        dispatch_group_leave(group);
        
        NSLog(@"*******%@",[NSThread currentThread]);
    });
    
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"执行第二个任务");
        dispatch_group_leave(group);
        NSLog(@"*******%@",[NSThread currentThread]);

    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"执行第三个任务");
        dispatch_group_leave(group);
        NSLog(@"*******%@",[NSThread currentThread]);

    });
    
    
    dispatch_group_notify(group, queue, ^{
       NSLog(@"以上任务全部执行完,执行最终任务");
        NSLog(@"*******%@",[NSThread currentThread]);
    });
    
    NSLog(@"*******%@",[NSThread currentThread]);
}

//使用信号量完成此功能
//顺序执行 task1 task2
-(void)dispatchSignal{
    //create 的value表示, 最多几个资源可访问
    //即 能允许同时执行几个任务;若是1个,就成了 串行 执行了
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(queue, ^{
       
        //进入wait,防止资源抢夺
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"*******run task one");
        sleep(1);
        NSLog(@"*******complete task");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"*******run task2");
        sleep(1);
        NSLog(@"*******complete task2");
        dispatch_semaphore_signal(semaphore);
    });
    
}



/**
    GCD 实现倒计时
 */
- (IBAction)countDown:(UIButton *)sender {
    //获得当前全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //获得主队列 : 属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //定时循环执行事件  打出dispatch_source_t timer ; 会有代码补全自动出现下列代码,只要进行设置参数即可;  不确定xcode9之前是不是也会有此功能;
    
    //创建一个定时器, 放在全局并发队列中
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    
    //对这个定时器进行设置  最后一个参数(leeway), 表示定时器的误差程度, 越精确越好,就传0, 允许60秒误差,就传60; 以秒为单位
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        //在这里进行
        if (_timeCount <= 0) { //计时结束
            //取消计时
            dispatch_cancel(timer);
            //开辟子线程,回到主线程
            dispatch_async(mainQueue, ^{
                _timerBtn.enabled = YES;
                [_timerBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
            
        }else{
            
            _timeCount--;
            NSLog(@"current time: %ld",_timeCount);

            dispatch_async(mainQueue, ^{
                _timerBtn.enabled = NO;
                NSString *titleStr = [NSString stringWithFormat:@"%ld秒",(long)_timeCount];
                [_timerBtn setTitle:titleStr forState:UIControlStateNormal];
            });
        }
    });
    
    //激活定时器
    dispatch_resume(timer);
}











@end
