//
//  SecondViewController.h
//  Xib使用
//
//  Created by 微光星芒 on 2019/6/24.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController
@property (nonatomic, copy) void (^backBlock)(void);
@property (nonatomic, copy) void (^completeBlock)(void);

@end

NS_ASSUME_NONNULL_END
