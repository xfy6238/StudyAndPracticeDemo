//
//  FifthController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/9/13.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "MoreController.h"
#import "GCDController.h"
#import "ChartController.h"
#import "DatePickerControllerViewController.h"
#import "SandController.h"
#import "WaterViewController.h"
#import "ButtonSetController.h"
#import "MetalViewController.h"
#import "VideoPlayeController.h"
#import "ImageProcessingController.h"
#import "RunLoopController.h"
#import "PropertyController.h"
#import "NetSpeedController.h"
#import "StackController.h"
//#import "RunTimeController.h"


@interface MoreController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (nonatomic,strong) NSMutableArray *datasource;
@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *testArray = [NSMutableArray array];

    [testArray insertObject:@"1" atIndex:0];
    NSLog(@"*******%@",testArray);
    
  
    
    
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    _mainTableView

    _datasource = [NSMutableArray array];
    NSString *gcdStr = @"GCD";
    NSString *chartStr = @"折线图";
    NSString *timeSelectStr = @"时间选择器";
    NSString *sandStr = @"沙盒";

    NSString *waterStr = @"瀑布流";

    NSString *btnStr = @"UIButton设置";
    
    NSString *metalStr = @"meatl图形";
    NSString *videoStr = @"视频播放";
    NSString *imageStr = @"图形处理";
    NSString *loopStr = @"RunLoop";
    NSString *propertyStr = @"指针属性";
    NSString *netSpeedStr = @"网速测试";
    NSString *stackStr = @"stackView";
    NSString *runTimeStr = @"RunTimeController";
    NSString *xibStr = @"XibController";
    NSString *camerFilterStr = @"CamerImageFilterController";
    NSString *mineOrder = @"MineOrderController";
    NSString *openGlOrder = @"OpenGLESController";
    NSString *viewControllersFirst = @"FirstViewController";
    NSString *strateStr  = @"StrategicController";
    [_datasource addObject:gcdStr];
    [_datasource addObject:chartStr];
    [_datasource addObject:timeSelectStr];
    [_datasource addObject:sandStr];
    [_datasource addObject:waterStr];
    [_datasource addObject:btnStr];
    [_datasource addObject:metalStr];
    [_datasource addObject:videoStr];
    [_datasource addObject:imageStr];
    [_datasource addObject:loopStr];
    [_datasource addObject:propertyStr];
    [_datasource addObject:netSpeedStr];
    [_datasource addObject:stackStr];
    [_datasource addObject:runTimeStr];
    [_datasource addObject:xibStr];
    [_datasource addObject:camerFilterStr];
    [_datasource addObject:mineOrder];
    [_datasource addObject:openGlOrder];
    [_datasource addObject:viewControllersFirst];
    [_datasource addObject:strateStr];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSString *title = _datasource[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}


#pragma 写成组件化的样式

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSString *str = _datasource[indexPath.row];
    
    UIViewController *controller;
    
    if ([str isEqualToString:@"GCD"]) {
        GCDController *controller = [[GCDController alloc]init];
        controller.title = @"GCD练习场所";
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }else if ([str isEqualToString:@"折线图"]){
        ChartController *controller = [[ChartController alloc]init];
        controller.title = @"折线图";
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"时间选择器"]){
        DatePickerControllerViewController *controller = [[DatePickerControllerViewController alloc]init];
        controller.title = @"折线图";
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"沙盒"]){
        SandController *controller = [[SandController alloc]init];
        controller.title = @"沙盒";
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"瀑布流"]){
        WaterViewController *controller = [[WaterViewController alloc]init];
        controller.title = @"瀑布流";
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"UIButton设置"]){
        ButtonSetController *controller = [[ButtonSetController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];

    }else if ([str isEqualToString:@"meatl图形"]){
        MetalViewController *controller = [[MetalViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"视频播放"]){
        VideoPlayeController *controller = [[VideoPlayeController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"图形处理"]){
        ImageProcessingController *controller = [[ImageProcessingController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"RunLoop"]){
        controller = [[RunLoopController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"指针属性"]){
        controller = [[PropertyController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"网速测试"]){
        controller = [[NetSpeedController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"stackView"]){
        Class classController = NSClassFromString(@"StackController");
        controller = [[classController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    Class classController = NSClassFromString(str);
    controller = [[classController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
