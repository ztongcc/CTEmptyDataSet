//
//  CollectionController.m
//  CTTableViewEmpty
//
//  Created by Admin on 2017/1/23.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "CollectionController.h"
#import <MJRefresh.h>
@interface CollectionController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView * collView;
@property (nonatomic, assign)NSInteger row;

@end

@implementation CollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CollectionView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collView];
    
    _row = 0;
    
    self.collView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _row = 0;
        [self.collView.mj_header endRefreshing];
        [self.collView reloadData];
        
    }];
    
    self.collView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _row ++;
        [self.collView.mj_footer endRefreshing];
        [self.collView reloadData];
    }];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section  == 2) {
        return _row;
    }
    return 0;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel * lab = [cell viewWithTag:100];
    if (lab == nil) {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        lab.tag = 100;
        lab.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lab];
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        cell.layer.borderWidth = 1;
    }
    NSLog(@" -- %ld %ld--", indexPath.section,indexPath.row);
    lab.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

- (UICollectionView *)collView
{
    if (_collView ==nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) collectionViewLayout:layout];
        _collView.dataSource = self;
        _collView.delegate = self;
        _collView.alwaysBounceVertical = YES;
        _collView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        [_collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    }
    return _collView;
}

@end
