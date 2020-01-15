//
//  TableViewController.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/8/11.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "TableViewController.h"
#import "CustomViewCell.h"
#import "OrderTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ChatCell.h"
#import "MasonryCell.h"

#import "ChatModel.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic,strong) NSMutableArray *datasource;

@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_datasource != nil) {
        [_datasource removeAllObjects];
    }else{
        _datasource = [NSMutableArray array];
    }
    
    /*
    for (int i = 0; i < 28; i ++) {
    
        NSString *str = [NSString stringWithFormat:@"这是第%d行",i];
        ChatModel *model = [[ChatModel alloc]init];
        model.content = str;
        
        [_datasource addObject:model];
    }
    */
    
    NSArray *titleArray = @[@"这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行",@"这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行",@"这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行这是第几行"];
    for (NSString *str in titleArray) {
        ChatModel *model = [[ChatModel alloc]init];
        model.content = str;
        [_datasource addObject:model];
    }
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableView registerNib:[UINib nibWithNibName:@"ChatCell" bundle:nil] forCellReuseIdentifier:@"ChatCell"];
    [_mainTableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderTableViewCell"];
    
    [_mainTableView registerClass:[MasonryCell class] forCellReuseIdentifier:@"MasonryCell"];

  
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        __weak typeof(self) weakself = self;
        if (indexPath.section == 0) {
            return [tableView fd_heightForCellWithIdentifier:@"ChatCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
                NSLog(@"++++++%@",cell);
                ChatCell *chatCell = (ChatCell *)cell;
                ChatModel *model = weakself.datasource[indexPath.row];
                chatCell.model = model;
            }];
        }else{
            return [tableView fd_heightForCellWithIdentifier:@"OrderTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
                NSLog(@"++++++%@",cell);
                OrderTableViewCell *orderCell = (OrderTableViewCell *)cell;
                ChatModel *model = weakself.datasource[indexPath.row];
                //            orderCell.model = model;
            }];
        }
    }else{
        return 55;
    }

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)
tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return 1;
    }
    
    return _datasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 2) {
        MasonryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasonryCell"];
        cell.textLabel.text = @"测试label";
        return cell;
    }
//    CustomViewCell *cell = [_mainTableView dequeueReusableCellWithIdentifier:@"CustomViewCell"];
    
    ChatModel *model = _datasource[indexPath.row];
    if (indexPath.section == 0) {
        ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    
        cell.model = model;
        
        return cell;
    }else{
        OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
//        cell.model = model;
        return cell;
    }
    
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma  mark  tableview 左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_datasource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}


// 修改编辑按钮文字(原本是英文)
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


/*
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.editingIndexPath = nil;
}



- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //title不设为nil 而是空字符串 理由为啥 ？   自己实践 跑到ios11以下的机器上就知道为啥了
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"        " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSLog(@"哈哈哈哈");
        [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
    }];
    return @[deleteAction];
}

//自定义删除样式
#pragma mark - viewDidLayoutSubviews
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath){
        [self configSwipeButtons];
    }
}


#pragma mark - configSwipeButtons
- (void)configSwipeButtons{
    // 获取选项按钮的reference
    if (@available(iOS 11.0, *)){
        
        ChatCell *cell = [self.mainTableView cellForRowAtIndexPath:self.editingIndexPath];
        
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in cell.subviews)
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
        ChatCell *tableCell = [self.mainTableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews){
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
  */

@end
