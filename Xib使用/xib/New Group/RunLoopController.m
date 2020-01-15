//
//  RunLoopController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/10/9.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "RunLoopController.h"
#import "MyThread.h"

@interface RunLoopController ()

@property (nonatomic, weak) NSThread *threadOne;

//保持线程存活,让线程在我们需要的时候相应消息
@property (nonatomic, strong) MyThread *threadThree;

@end

@implementation RunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //runloop和线程一一对应, runloop并不会主动创建

    
    NSLog(@"%@开辟子线程",[NSThread currentThread]);
    //controller不持有此线程,线程执行完会自动释放
//    MyThread *thread = [[MyThread alloc]initWithTarget:self selector:@selector(subThreadTodo) object:nil];
//    thread.name = @"不持有此线程";
//    [thread start];
    
    /*
    //a: controller持有此线程,线程仍在内存(死亡),不会释放,无法再次调用
    _threadOne = [[MyThread alloc]initWithTarget:self selector:@selector(threadOneDo) object:nil];
    
    [_threadOne start];
    //b: 如果再次执行,会崩溃
//    [_threadOne start];
    
    */
    
    /*
    //1 将线程加入到runloop中
    MyThread *threadTwo = [[MyThread alloc]initWithTarget:self selector:@selector(threadTwoDo) object:nil];
    threadTwo.name = @"第三个线程";
    [threadTwo start];
    
    */
    
    //a
    _threadThree = [[MyThread alloc]initWithTarget:self selector:@selector(threadThreeDo) object:nil];
    _threadThree.name = @"第四个线程";
    [_threadThree start];
}

//b runloop模式下的 子线程执行
-(void)threadThreeDo{
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(wantTodo) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

//    [loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    [loop run];
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
}

//c 点击屏幕时,发消息给子线程执行
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //这个时候 执行 runloop执行的是source0的事件源, 而runloop  使用此方法unMode:beforeDate运行,会自动停止,导致线程执行完自动退出
    //而使用第二个方法则不会,创建了一个timer
    [self performSelector:@selector(afterDelayTodo) onThread:self.threadThree withObject:nil waitUntilDone:NO];
    
    //


    /*
    CFRunLoopObserverRef observe = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"*******RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"*******RunLoop要处理Timers");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"*******RunLoop要处理Source了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"*******RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"*******RunLoop即将唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"*******RunLoop退出");
                break;
                
        }
    });
    
    
    //给runloop添加监听者
    CFRunLoopAddObserver(CFRunLoopGetMain(), observe, kCFRunLoopDefaultMode);
    CFRelease(observe);
     */
}

//d 我们希望在子线程中执行的任务
-(void)wantTodo{
    //断点2
    NSLog(@"当前线程:%@执行任务处理数据", [NSThread currentThread]);
    
    [self performSelector:@selector(afterDelayTodo) withObject:nil afterDelay:0];
}

- (void)afterDelayTodo{
    NSLog(@"*******%@",[NSThread currentThread]);
}




/*
-(void)threadTwoDo{
    //
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:UITrackingRunLoopMode];
//    NSLog(@"RunLoop:%@",runLoop);

    [runLoop run];
    
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
}

*/
/*

-(void)threadOneDo{
    NSLog(@"*******%@ 执行子线程",[NSThread currentThread]);
}

-(void)subThreadTodo{
    NSLog(@"*******%@ 执行子线程",[NSThread currentThread]);
}
 */




@end
