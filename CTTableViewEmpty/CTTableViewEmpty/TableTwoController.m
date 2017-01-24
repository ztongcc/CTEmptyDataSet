//
//  TableTwoController.m
//  CTTableViewEmpty
//
//  Created by Admin on 2017/1/23.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "TableTwoController.h"
#import <MJRefresh/MJRefresh.h>
#import "UITableView+Empty.h"


@interface TableTwoController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *table;
@property (nonatomic, assign)NSInteger row;

@end

@implementation TableTwoController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TableView";
    self.view.backgroundColor = [UIColor whiteColor];
    self.table.emptyViewEnable = NO;
    
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

@end
