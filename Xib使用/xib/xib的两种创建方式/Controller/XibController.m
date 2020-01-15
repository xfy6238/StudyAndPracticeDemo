
//
//  XibController.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/1/14.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "XibController.h"
#import "XibFilerOwnerView.h"

@interface XibController ()

@property (weak, nonatomic) IBOutlet XibFilerOwnerView *testView;

@end

@implementation XibController

- (void)viewDidLoad {
    [super viewDidLoad];


    _testView.backgroundColor = [UIColor purpleColor];
}





@end
