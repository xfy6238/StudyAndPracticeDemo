
//
//  PropertyController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/10/26.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "PropertyController.h"


typedef struct MyStruct {
    int a;
    int b;
} MyStruct;



@interface TestModel : NSObject

@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, assign) BOOL isBind;

@end


@implementation TestModel

@end


@interface Fatehr : NSObject

@end

@implementation Fatehr

@end

@interface Son : Fatehr

@end

@implementation Son


- (id)init

{
    
    self = [super init];
    
    if (self){
        
        NSLog(@"%@", NSStringFromClass([self class]));
        
        NSLog(@"%@", NSStringFromClass([super class]));
        
    }
    
    return self;
    
}

@end


@interface PropertyController ()

@property (nonatomic, copy) NSString *imCopyStr;
@property (nonatomic, weak) NSString *str1;

@property (nonatomic, copy) NSString *NormalStr;

@property (nonatomic, weak) NSString *str2;
@property (nonatomic, weak) NSString *str3;

@property (nonatomic) MyStruct mySt;

@end

@implementation PropertyController

- (void)viewDidLoad {
    [super viewDidLoad];

    MyStruct st = {6 , 6};
    st.a = 7;
    
    
    //字符串不同的初始化方法, 会有不同的变化; Apple 应该有优化
    __weak NSString *tmpStr = @"1234";
    
    //  _imCopyStr = [[NSString alloc] initWithUTF8String:"hello World"];

   _imCopyStr = @"hello word";

     _NormalStr = @"123456";
   
    _str1 = _imCopyStr;
    _imCopyStr = nil;
    NSLog(@"weak 的指针值: %@",_str1);

    _str1 = tmpStr;
    _str2 = tmpStr;
    _str3 = tmpStr;
    _imCopyStr = _str1;
        
    //两个指针的指向的值的内存地址一样
    NSLog(@"指向的值: %x , %x",_imCopyStr, _str1);
    
    //确认%p 到底哪个是获得指针地址
    //第一个堆上的地址0x102728808
    //第二个是栈上的地址
    //%p是打印指针地址  直接打印是指针指向的内存地址 &取的是指针本身地址
    NSLog(@"`````````%p  %p", _NormalStr, &_NormalStr);
    
    
    tmpStr = nil;
    //tmpStr 指向0x0(nil)
    //这两个仍有值指向原来地地址
    NSLog(@"指针指向: %p*******%@",tmpStr,_imCopyStr);
    NSLog(@"弱引用此时的值: %@ ",_str1);


    NSInteger value1 = 10;
    NSInteger value2 = 20;
        
    [self swapValueWithFistValue: &value1 secondValue: &value2];
    
    
    /*
    NSString *str1 = @"my string";
    NSString *str3 = [[NSString alloc] initWithString:@"my string"];
    
    
    // %p是指针本身地址
    // %x 是指针指向的内存的地址
    NSLog(@"*******%p \n 第二个指针地址:%p  第三个指针地址: %p",&str1,&str2,&str3);
    //两个变量指向的内存是一样的
    */

    int a = 1;
    int *p1 = &a; //指针p1指向了int变量a的地址
    int b = *p1; //效果等同于b=a

    //这里修改了p1指针指向的内存地址,指向了不知道是哪的一个地址(随便写的)
    //而a的内存地址是0x1
    p1 = &a;
     //
    *p1 = 2;
    NSLog(@"%d$$$$$$$$$%p",a, p1);
    int *p2 = &a;
//    p2, *p2  是不同的  p2 是一个指针,存放了的一个内存地址
    //*p2 表示 这个内存地址 所存放的值
    *p2 = 3;
    int c = *p2;
    
    //可以将a看成值1的一个替身,便于我们操作.  a 是什么? 是一个值,为1,也可以认为它是一块内存储存的值;
    //&a 得到这个值,这块内存的地址;
    // *p1 得到p1 这个指针所指向内存的值
    // p1存储的是a在所在内存的地址
  
    [self callStructMethod];
    //存储在栈
    int number1 = 9;
    //存储在堆上
    TestModel *model = [TestModel new];
    
    NSLog(@"指针内存地址: %p 值所在内存地址: %p", &number1, number1);
    NSLog(@"指针内存地址: %p 值所在内存地址:%p", &model, model);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"此时的 %@,copy修饰的值:%@; 弱引用的值: %@ ",_imCopyStr,_NormalStr,_str1);
    
}

//MARK: 对象类型的引用传参


- (void)swapString {
    //交换两个字符串
    
    NSString *testStr1 = @"123";
    NSString *testStr2 = @"345";
    //传入的都是指针的地址 而不是对象的地址
    [self swapValueWithFirstPointer:&testStr1 secondPointer:&testStr2];
    NSLog(@"%@*******%@",testStr1,testStr2);
}

///oc对象是一个结构体指针对象, 从C语言用法,可以传递这个指针对象,然后在方法内部通过指针解引用,改变结构体的值,但实际不行,需要遵循OC对象的生成方式,


//MARK: 值类型的 引用传参
- (void)changeExterVar {
     
    NSUInteger money = 10;

    //定义一个指针pMoney, 指向money的地址
    NSUInteger *pMoney = &money;
    //将这个指针传入
    if ([self takeMoney:pMoney]) {
        NSLog(@"*******取钱成功 %lu",money);
    }
    //money 已经被赋值了
}

/**
    值传递
    常量在方法中进行的是值传递而不是指针传递, 所以在方法内交换的只是值, 而不是外部变量的两个变量
 */
- (void)swapValueWithFistValue:(char *)value1 secondValue:(char *)value2{
    char tmp;
    tmp = *value1;
    *value1  = *value2;
    *value2 = tmp;
    NSLog(@"%s*******%s",value1,value2);
    
    NSString *str = @"2";
    
    str; //str 是什么 ? 指针?
    *str; // *str 是什么? 它的值"2"?
    &str; //&str 是什么? 指针本身地址

    
}


- (void)swapValueWithFirstPointer:(NSString * *)value1 secondPointer:(NSString * *)value2{
    char tmp = *value1;
    
    //传入的是指针的指针
    
    //在oc中是无法是自己通过(*p) 进行赋值操作;
    //只能通过 *(*p) 进行操作操作, 对z
    
    *value1 = *value2;
    *value2 = @(tmp);
    
//    NSString * * tmp = value1;
//
//    value1 = value2;
//    value2 = tmp;
}


/**
    这里使用了引用传值, 传的不是值(值传递),而是指针. 可以在方法内部直接改变
 */
-(BOOL)takeMoney:(NSUInteger *)money{
    //参数是个指针  通过*money 修改指针指向内存区域存储的值
    //实现了在方法内存修改外部变量的值
    *money = 100;
    return YES;
}


//MARK: 在方法内部改变struct的值
- (void)callStructMethod{
    //MARK: 在方法内部改变struct
      MyStruct st;
      [self changeStruct:&st];
      NSLog(@"结构体%d %d",st.a,st.b);
      //定义了两个结构指针, 通过解引用 进行赋值
      MyStruct *st1;
      MyStruct *st2;
//      *st1 = *st2 ;

}

- (void)changeStruct:(MyStruct *)myStruct {
    //传入的是一个指针; *myStruct获得指针指向的内存
    //给内存写入值
    *myStruct = ({
        MyStruct st;
        st.a = 1;
        st.b = 2;
        st;
    });
}

@end
