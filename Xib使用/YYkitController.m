//
//  YYkitController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/18.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "YYkitController.h"
#import "YYLabel.h"

@interface YYkitController ()
//@property (weak, nonatomic) IBOutlet YYLabel *yyLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtnWidth;



@end

@implementation YYkitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    /*
    _yyLab.text = @"hello word  看看YYkit 到底有多强大 异步渲染  究竟有多强";
    
    //异步渲染 在显示巨量文字时会体现其优处
    _yyLab.displaysAsynchronously = YES;
    
    _yyLab.numberOfLines = 0;
    YYTextContainer *titleContarer = [YYTextContainer new];
    
    //限制宽度
    titleContarer.size = CGSizeMake(100, MAXFLOAT);
//    NSMutableAttributedString *titleAttri = [NSMutableAttributedString ];
     */
    
    
    /*********************/
    //在xib设置中, 如果设置左侧leftBtn的宽度约束是一个固定值, 然后根据情况进行对应的更改,这种事正确的
    //如果是SCREEN_WIDTH 的倍数, 则会出现问题; 改变约束的constant不会起效果;
    //原因未知  哎
}


//- (NSMutableAttributedString *)getArray:(NSString *)title{
//    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]initWithString:title];
//    
//    
//}
- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.selected) {
        _leftBtnWidth.constant = SCREEN_WIDTH * 0.5;

    }else{
        _leftBtnWidth.constant = 0;

    }
    sender.selected = !sender.selected;
}


@end
