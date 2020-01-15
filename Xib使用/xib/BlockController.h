//
//  BlockController.h
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/17.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passValue)(NSString *str);

extern NSString *const biliStr;


@interface BlockController : UIViewController

@property (nonatomic,copy) passValue passBlock;


- (void)returnValue:(passValue)passBlock;
@end
