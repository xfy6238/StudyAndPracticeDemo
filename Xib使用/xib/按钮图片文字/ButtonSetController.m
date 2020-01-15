//
//  ButtonSetController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/6/21.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "ButtonSetController.h"
@interface ButtonSetController ()
@property (weak, nonatomic) IBOutlet UIButton *setButton;

@end


@implementation ButtonSetController

- (void)viewDidLoad{
    [_setButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [_setButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
//    _setButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _setButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    NSLog(@"文字的间距 %@",NSStringFromUIEdgeInsets(_setButton.imageEdgeInsets));
       NSLog(@"图片的间距 %@",NSStringFromUIEdgeInsets(_setButton.titleEdgeInsets));
    
    [self circulationTest];
    
}

/**
    在可变数组中进行删除删除操作,比如移除下标为3的元素, 原下标为4的元素变成下标为3,
 那么在下一次循环(这个循环有元素的比较)中,这个元素是不会被执行的, 因为位置变了;
 所以:
 1.不在for循环中进行数组删除
 2.在移除元素之后,将i-1, 回到这次循环之前.
  2.1: 使用i--,要保证是值比较,而不是下标比较,否则就停在这个循环了
 
 */
- (void)circulationTest{
    
    NSMutableArray *mutaArray = [@[@"0",@"1",@"2",@"3",@"4",@"5"]mutableCopy];
    
    
    for (int i = 0; i < mutaArray.count;i ++) {

        if ([mutaArray[i] isEqualToString:@"3"]) {
            [mutaArray removeObjectAtIndex:i];
            i--;
            continue;
        }
        NSLog(@"****************%@",mutaArray[i]);
    }
}


@end
