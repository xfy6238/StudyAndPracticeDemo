//
//  XibFilerOwnerView.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/1/14.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "XibFilerOwnerView.h"

@implementation XibFilerOwnerView


- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
       NSArray *viewArray =  [[NSBundle mainBundle] loadNibNamed:@"XibFilerOwnerView" owner:self options:nil];
        UIView *contentView = viewArray[0];
        contentView.frame = self.bounds;
        [self addSubview:contentView];
        
        NSLog(@"%@*******%@",self,contentView);
        /*
        XibFilerOwnerView: 0x7f97ad62ef70; frame = (67.5 269.5; 240 128); autoresize = RM+BM; layer = <CALayer: 0x600001fa8000>>*******<UIView: 0x7f97ad63f020; frame = (0 0; 240 128); autoresize = W+H; layer = <CALayer: 0x600001fd65c0>>
        */
    }
    return self;
}
    




@end
