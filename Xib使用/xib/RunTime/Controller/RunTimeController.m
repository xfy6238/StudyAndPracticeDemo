//
//  RunTimeController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/12/6.
//  Copyright © 2018 微光星芒. All rights reserved.
//

#import "RunTimeController.h"
#import "RunTimeObject.h"
#import "objc/Runtime.h"
#import "objc/message.h"


@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;

@end

@implementation Sark

-(void)speak{
    NSLog(@"*******my name is %@",self.name);
}

@end

@interface RunTimeController ()

@end

@implementation RunTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //super viewdidload 是self 执行父类的viewDidLoad方法; 不是父类去执行viewdidload
    
    RunTimeObject *runTime = [[RunTimeObject alloc]init];
    //打印类名
//    NSLog(@"类名*******%@",[runTime class]);
    
    //isMemberOfClass  是否是这个类的对象: 更加严格
    //isKindOfClass  是否是任意继承这个类的对象: 更加宽泛
    /*
    NSLog(@"*******%d",[runTime isKindOfClass:[RunTimeObject class]]);
    
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    
    NSLog(@"%ld*******%ld",res1,res2);
    SEL selector = sel_registerName("testMethond");
    NSString *str = NSStringFromSelector(selector);
    
    NSLog(@"方法名字*******%@",str);
    */

    id cls = [Sark class];
    void *obj = &cls;
    [(__bridge id)obj speak];


    
}

-(void)testMethond{
    
}

//1.NSObject的结构
/*
struct objc_class {
    Class isa  OBJC_ISA_AVAILABILITY;
    
#if !__OBJC2__
    Class super_class                                        OBJC2_UNAVAILABLE;
    const char *name                                         OBJC2_UNAVAILABLE;
    long version                                             OBJC2_UNAVAILABLE;
    long info                                                OBJC2_UNAVAILABLE;
    long instance_size                                       OBJC2_UNAVAILABLE;
    struct objc_ivar_list *ivars  //成员变量列表的指针                           OBJC2_UNAVAILABLE;
    struct objc_method_list **methodLists // 指向objc_method_list指针的指针                  OBJC2_UNAVAILABLE;
 //*methodLists 是指向方法列表的指针; 动态的修改它的值来添加成员方法(category实现原理)
 
 
    struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
    struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
#endif
} OBJC2_UNAVAILABLE;

*/


@end
