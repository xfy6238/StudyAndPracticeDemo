//
//  DatePickerControllerViewController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/3/30.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "DatePickerControllerViewController.h"

#define kDatePicHeight 200
#define kTopViewHeight 44

@interface DatePickerControllerViewController ()

@property (nonatomic,strong) UIDatePicker *datePicker;

@end

@implementation DatePickerControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kTopViewHeight + 0.5, SCREEN_WIDTH, kDatePicHeight)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置该UIDatePicker的国际化Locale，以简体中文习惯显示日期，UIDatePicker控件默认使用iOS系统的国际化Locale
    _datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CHS_CN"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSString *minDateStr = @"2016-07-18";
    NSDate *minDate = [formatter dateFromString:minDateStr];
    
    NSDate *currentDate = [NSDate date];
    NSString *maxDateStr = @"2019-07-18";
//    NSDate *minDate = [formatter dateFromString:minDateStr];
    
    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60];
    
    _datePicker.minimumDate = minDate;
    _datePicker.maximumDate = maxDate;
    
    [self.view addSubview:_datePicker];
}



@end
