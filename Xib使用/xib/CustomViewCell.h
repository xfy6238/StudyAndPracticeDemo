//
//  TableViewCell.h
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/14.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface CustomViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

- (void)CellStyle;

@property (nonatomic,strong) ChatModel *model;

@end
