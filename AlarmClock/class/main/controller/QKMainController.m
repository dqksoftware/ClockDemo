//
//  ViewController.m
//  AlarmClock
//
//  Created by 丁乾坤 on 2016/12/13.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKMainController.h"
#import "QKMainCell.h"
#import "QKDialView.h"

@interface QKMainController ()

@property(nonatomic, strong)NSMutableArray *datasource;

@end

@implementation QKMainController

static NSString *cellIdentifer = @"maincellIdentifer";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationViewItem];
    self.tableView.tableFooterView = [UIView new];
    self.datasource = [NSMutableArray array];
   
   
}

#pragma mark   ----- tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return self.datasource.count;
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QKMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    if (!cell) {
        cell = [[QKMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    return cell;
}


#pragma mark  ------ 添加子视图
-  (void)addNavigationViewItem{
    //编辑按钮
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake( 0, 0, 33.5, 33.5);
    [editButton setImage:[[UIImage imageNamed:@"nav_plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [editButton setImage:[[UIImage imageNamed:@"nav_plus_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateHighlighted];
    [editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    
    //新建闹钟
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 33.5, 33.5);
    [addButton setImage:[[UIImage imageNamed:@"nav_menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [addButton setImage:[[UIImage imageNamed:@"nav_menu_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItems = @[editButtonItem, addButtonItem];
    
    //注册cell
    [self.tableView registerClass:[QKMainCell class] forCellReuseIdentifier:cellIdentifer];
    //设置tableview的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置tableview的单元格类型
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //背景视图
    UIImageView *backGroudImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Andrew-Neel.jpg"]];
    backGroudImageV.frame = CGRectMake(44.f, 0, SWIDTH, SHEIGHT);
     self.tableView.backgroundView = backGroudImageV;
    //刻度盘
    CGFloat dialViewHeight = 200.f;
    QKDialView *dialView = [[QKDialView alloc] initWithFrame:CGRectMake(0, SHEIGHT - dialViewHeight - 64, SWIDTH, dialViewHeight)];
    [self.tableView addSubview:dialView];
//    [dialView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(125.f));
//        make.bottom.equalTo(self.tableView.mas_bottom);
//        make.left.equalTo(@0);
//        make.right.equalTo(self.tableView.mas_right);
//    }];
    
}




#pragma mark ----   单击事件
///新建闹钟
- (void)addAction{
    
}

//编辑闹钟
- (void)editAction{
    
}







@end
