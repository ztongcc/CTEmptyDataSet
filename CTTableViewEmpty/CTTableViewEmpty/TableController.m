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
    
    [self.view addSubview:self.table];
    [self setEmptyPage];

    _row = 0;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _row = 0;
        [self.table reloadEmptyDispalyStatus:CTDispalyLoadingStatus];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table.mj_header endRefreshing];
            [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];

    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _row ++;
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];
    }];
    self.table.tableFooterView = [UIView new];

}

- (void)setEmptyPage
{
    __weak typeof(self) weakSelf = self;
    [self.table setEmpty_tapBlock:^{
        weakSelf.row++;
        [weakSelf.table reloadData];
    }];
    
    [self.table setEmpty_willDispalyStatusBlock:^(UIView * dispalyView, CTDispalyStatus status){
        
        NSLog(@"will %@ \n %@ \n%ld", dispalyView, dispalyView.subviews, (long)status);
        UIActivityIndicatorView * activity = [dispalyView viewWithTag:100];
        [activity startAnimating];
    }];
    
    [self.table setEmpty_endDispalyStatusBlock:^(UIView * dispalyView, CTDispalyStatus status){
        
        NSLog(@"end %@ \n %@ \n%ld", dispalyView, dispalyView.subviews, (long)status);
        if (status == CTDispalyLoadingStatus) {
            UIActivityIndicatorView * activity = [dispalyView viewWithTag:100];
            [activity stopAnimating];
        }
    }];
    
    [self.table setEmptyOffsetCenterY:-100 status:CTDispalyNormalStatus];
    [self.table setEmptyDispalyImage:[UIImage imageNamed:@"emptyImage"] status:CTDispalyNormalStatus];
    
    UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    activity.tag = 100;
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.table setEmptyCustomView:activity status:CTDispalyLoadingStatus];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.row--;
        [self.table beginUpdates];
        [self.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.table endUpdates];
    }
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
