//
//  MasonryCell.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/7/14.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "MasonryCell.h"

@implementation MasonryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (@available(iOS 11.0, *)){
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.subviews)
        {
            NSLog(@"%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 1)
            {
                // 和iOS 10的按钮顺序相反
                UIButton *deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
    else{
        // iOS 8-10层级 (Xcode 8编译): UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        for (UIView *subview in self.subviews){
            NSLog(@"subview%@-----%zd",subview,subview.subviews.count);
            
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 1)
            {
                UIButton *deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
}

//设置删除按钮样式
- (void)configDeleteButton:(UIButton *)deleteButton{
    if (deleteButton) {
        //        [deleteButton setImage:[UIImage imageNamed:@"list_deleting"] forState:UIControlStateNormal];
        //        [deleteButton setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
        
        [deleteButton setBackgroundColor:[UIColor orangeColor]];
    }
}

@end
