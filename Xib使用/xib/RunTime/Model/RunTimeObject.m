//
//  RunTimeObject.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/12/6.
//  Copyright © 2018 微光星芒. All rights reserved.
//

#import "RunTimeObject.h"

@implementation RunTimeObject

-(id)init{
    self = [super init];
    if (self) {
        NSLog(@"*******%@",self);
        NSLog(@"*******%@", NSStringFromClass([self class]));

        NSLog(@"*******%@", NSStringFromClass([super class]));
    }
    return self;
}

@end
