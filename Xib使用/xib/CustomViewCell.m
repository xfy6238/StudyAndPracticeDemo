//
//  TableViewCell.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/14.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "CustomViewCell.h"

@interface CustomViewCell()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation CustomViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)CellStyle{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(ChatModel *)model{
    
    if (model.content != nil) {
        _contentLab.text = model.content;
    }
    
}

@end
