//
//  TableController.m
//  CTTableViewEmpty
//
//  Created by Admin on 2017/1/22.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "TableController.h"
#import <MJRefresh/MJRefresh.h>
#import "UIScrollView+Empty.h"
#import "TableTwoController.h"

@interface TableController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *table;
@property (nonatomic, assign)NSInteger row;

@end

@implementation TableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TableView";
    self.view.backgroundColor = [UIColor whiteColor];
    self.table.empty_dispalyImage = [UIImage imageNamed:@"TableView_EmptyIcon"];
    self.table.empty_scrollEnable = NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TableTwoController * tableVC = [[TableTwoController alloc] init];
    [self.navigationController pushViewController:tableVC animated:YES];

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
