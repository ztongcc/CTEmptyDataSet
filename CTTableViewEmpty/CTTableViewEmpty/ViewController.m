//
//  ViewController.m
//  CTTableViewEmpty
//
//  Created by Admin on 2017/1/20.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "TableController.h"
#import "CollectionController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *table;
@property (nonatomic, strong) NSArray * dataAry;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataAry = @[@"TableView",@"CollectionView"];
    [self.view addSubview:self.table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = _dataAry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * text = _dataAry[indexPath.row];
    if ([text isEqualToString:@"TableView"])
    {
        TableController * tableVC = [[TableController alloc] init];
        [self.navigationController pushViewController:tableVC animated:YES];
    }
    else
    {
        CollectionController * collVC = [[CollectionController alloc] init];
        [self.navigationController pushViewController:collVC animated:YES];
    }
}

- (UITableView *)table
{
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableFooterView = [UIView new];
    }
    return _table;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
