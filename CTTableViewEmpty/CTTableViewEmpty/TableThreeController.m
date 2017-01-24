//
//  TableThreeController.m
//  CTTableViewEmpty
//
//  Created by Admin on 2017/1/24.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "TableThreeController.h"
#import <MJRefresh/MJRefresh.h>
#import "UITableView+Empty.h"

@interface TableThreeController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *table;
@property (nonatomic, assign)NSInteger row;

@end

@implementation TableThreeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TableView";
    self.view.backgroundColor = [UIColor whiteColor];
    self.table.offsetCenterY = -100;
    self.table.customEmptyView = [self emptyView];
    [self.view addSubview:self.table];
    _row = 0;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _row = 0;
        [self.table.mj_header endRefreshing];
        [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _row ++;
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];
    }];
    self.table.tableFooterView = [UIView new];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (UITableView *)table
{
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (void)tapAction
{
    NSLog(@"%s", __func__);
}


- (UIView *)emptyView
{
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    UILabel * lab = [[UILabel alloc] init];
    lab.text = @"网络异常, 请重试!";
    [lab sizeToFit];
    [aView addSubview:lab];
    lab.center = CGPointMake(150, 50);
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(30, 100, 240, 40);
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitle:@"重试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:btn];
    return aView;
}

@end
