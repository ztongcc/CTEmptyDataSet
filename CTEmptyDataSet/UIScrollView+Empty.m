
//
//  UIScrollView+Empty.m
//  Pods
//
//  Created by Admin on 2017/1/23.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "UIScrollView+Empty.h"
#import <objc/runtime.h>

#define EMPTY_X(__VIEW__)  CGRectGetMinX(__VIEW__.frame)
#define EMPTY_Y(__VIEW__)  CGRectGetMinY(__VIEW__.frame)
#define EMPTY_W(__VIEW__)  CGRectGetWidth(__VIEW__.frame)
#define EMPTY_H(__VIEW__)  CGRectGetHeight(__VIEW__.frame)

#define EMPTY_MID_W(__VIEW__)  (CGRectGetWidth(__VIEW__.frame)/2.0)
#define EMPTY_MID_H(__VIEW__)  (CGRectGetHeight(__VIEW__.frame)/2.0)


#define EMPTY_R(__VIEW__)  CGRectGetMaxX(__VIEW__.frame)
#define EMPTY_B(__VIEW__)  CGRectGetMaxY(__VIEW__.frame)


@implementation UIScrollView (Empty)

+ (void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // tableView
        [[self class] swizzledSelector:@selector(reloadData)
                            toSelector:@selector(empty_reloadTableData)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(endUpdates)
                            toSelector:@selector(empty_endUpdates)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(reloadSections:withRowAnimation:)
                            toSelector:@selector(empty_reloadSections:withRowAnimation:)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(reloadRowsAtIndexPaths:withRowAnimation:)
                            toSelector:@selector(empty_reloadRowsAtIndexPaths:withRowAnimation:)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(deleteSections:withRowAnimation:)
                            toSelector:@selector(empty_deleteSections:withRowAnimation:)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(deleteRowsAtIndexPaths:withRowAnimation:)
                            toSelector:@selector(empty_deleteRowsAtIndexPaths:withRowAnimation:)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(insertRowsAtIndexPaths:withRowAnimation:)
                            toSelector:@selector(empty_insertRowsAtIndexPaths:withRowAnimation:)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(insertSections:withRowAnimation:)
                            toSelector:@selector(empty_insertSections:withRowAnimation:)
                               inClass:[UITableView class]];

        
        // collectionView
        [[self class] swizzledSelector:@selector(reloadData)
                            toSelector:@selector(empty_reloadCollectionData)
                               inClass:[UICollectionView class]];
        
        [[self class] swizzledSelector:@selector(reloadSections:)
                            toSelector:@selector(empty_reloadSections:)
                               inClass:[UICollectionView class]];
        
        [[self class] swizzledSelector:@selector(reloadItemsAtIndexPaths:)
                            toSelector:@selector(empty_reloadItemsAtIndexPaths:)
                               inClass:[UICollectionView class]];
        
        [[self class] swizzledSelector:@selector(insertSections::)
                            toSelector:@selector(empty_insertSections:)
                               inClass:[UICollectionView class]];

        [[self class] swizzledSelector:@selector(deleteSections:)
                            toSelector:@selector(empty_deleteSections:)
                               inClass:[UICollectionView class]];

        [[self class] swizzledSelector:@selector(insertItemsAtIndexPaths:)
                            toSelector:@selector(empty_insertItemsAtIndexPaths:)
                               inClass:[UICollectionView class]];

        [[self class] swizzledSelector:@selector(deleteItemsAtIndexPaths:)
                            toSelector:@selector(empty_deleteItemsAtIndexPaths:)
                               inClass:[UICollectionView class]];

    });
}

+ (void)swizzledSelector:(SEL)orgSel toSelector:(SEL)toSel inClass:(Class)cls
{
    Method originalMethod = class_getInstanceMethod(cls, orgSel);
    Method swizzledMethod = class_getInstanceMethod(cls, toSel);
    BOOL didAddMethod =
    class_addMethod(cls, orgSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,toSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - setter getter method -

- (BOOL)empty_enable
{
    return ![objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEmpty_enable:(BOOL)enable
{
    objc_setAssociatedObject(self, @selector(empty_enable), @(!enable), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)empty_scrollEnable
{
    return ![objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEmpty_scrollEnable:(BOOL)empty_scrollEnable
{
    objc_setAssociatedObject(self, @selector(empty_scrollEnable), @(!empty_scrollEnable), OBJC_ASSOCIATION_ASSIGN);
}

- (UIImage *)empty_dispalyImage
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmpty_dispalyImage:(UIImage *)emptyImage
{
    objc_setAssociatedObject(self, @selector(empty_dispalyImage), emptyImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)empty_customView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmpty_customView:(UIView *)customEmptyView
{
    objc_setAssociatedObject(self, @selector(empty_customView), customEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat )empty_offsetCenterY
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setEmpty_offsetCenterY:(CGFloat)offsetCenterY
{
    objc_setAssociatedObject(self, @selector(empty_offsetCenterY), @(offsetCenterY), OBJC_ASSOCIATION_ASSIGN);
}

- (NSAttributedString *)empty_dispalyText
{
    NSMutableString * str = objc_getAssociatedObject(self, _cmd);
    return str?str:[[NSAttributedString alloc] initWithString:@"~ 暂无内容 ~" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],
          NSFontAttributeName:[UIFont systemFontOfSize:14]}];
}

- (void)setEmpty_dispalyText:(NSAttributedString *)dispalyText
{
    objc_setAssociatedObject(self, @selector(empty_dispalyText), dispalyText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CTEmptyDispalyType)empty_dispalyType
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setEmpty_dispalyType:(CTEmptyDispalyType)dispalyType
{
    objc_setAssociatedObject(self, @selector(empty_dispalyType), @(dispalyType), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)empty_verticalSpace
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setEmpty_verticalSpace:(CGFloat)verticalSpace
{
    objc_setAssociatedObject(self, @selector(empty_verticalSpace), @(verticalSpace), OBJC_ASSOCIATION_ASSIGN);
}

- (dispatch_block_t)empty_tapBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmpty_tapBlock:(dispatch_block_t)tapBlock
{
    objc_setAssociatedObject(self, @selector(empty_tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Collection method -
- (void)empty_reloadCollectionData
{
    [self empty_reloadCollectionData];
    
    [self autoDispayEmptyView];
}

- (void)empty_reloadSections:(NSIndexSet *)sections;
{
    [self empty_reloadSections:sections];
    
    [self autoDispayEmptyView];
}

- (void)empty_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self empty_reloadItemsAtIndexPaths:indexPaths];
    
    [self autoDispayEmptyView];
}

- (void)empty_insertSections:(NSIndexSet *)sections
{
    [self empty_insertSections:sections];
    
    [self autoDispayEmptyView];
}

- (void)empty_deleteSections:(NSIndexSet *)sections
{
    [self empty_deleteSections:sections];
    
    [self autoDispayEmptyView];
}

- (void)empty_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self empty_insertItemsAtIndexPaths:indexPaths];
    
    [self autoDispayEmptyView];
}

- (void)empty_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self empty_deleteItemsAtIndexPaths:indexPaths];
    
    [self autoDispayEmptyView];
}

#pragma mark - tableView method -
- (void)empty_reloadTableData
{
    [self empty_reloadTableData];
    
    [self autoDispayEmptyView];
}

- (void)empty_endUpdates
{
    [self empty_endUpdates];
    
    [self autoDispayEmptyView];
}

- (void)empty_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self empty_reloadSections:sections withRowAnimation:animation];
    
    [self autoDispayEmptyView];
}

- (void)empty_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self empty_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self autoDispayEmptyView];
}

- (void)empty_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self empty_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self autoDispayEmptyView];
}

- (void)empty_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self empty_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self autoDispayEmptyView];
}

- (void)empty_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self empty_insertRowsAtIndexPaths:sections withRowAnimation:animation];
    
    [self autoDispayEmptyView];
}

- (void)empty_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self empty_deleteSections:sections withRowAnimation:animation];
    
    [self autoDispayEmptyView];
}
#pragma mark - commom metnod -

- (UILabel *)detailLableWithPosition:(CGPoint)position
{
    UILabel * lab = [[UILabel alloc] init];
    lab.attributedText = self.empty_dispalyText;
    [lab sizeToFit];
    lab.center = position;
    return lab;
}

- (UILabel *)imageViewWithPosition:(CGPoint)position
{
    CGSize size = self.empty_dispalyImage.size;
    CGFloat scale = self.empty_dispalyImage.scale;
    UIImageView * emptyIM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width/scale, size.height/scale)];
    emptyIM.backgroundColor = [UIColor clearColor];
    emptyIM.contentMode = UIViewContentModeScaleAspectFill;
    emptyIM.image = self.empty_dispalyImage;
    emptyIM.center = position;
    return emptyIM;
}

- (UIView *)specialDisplayContentWithCenter:(CGPoint)center
{
    UIView * contentView = [[UIView alloc] init];
    if (self.empty_dispalyType == CTDispalyCustomViewAndTextType)
    {
        if (self.empty_customView) {
            [contentView addSubview:self.empty_customView];
        }
        if (self.empty_dispalyText) {
            UILabel * lab = [self detailLableWithPosition:CGPointZero];
            CGPoint point = CGPointMake(EMPTY_MID_W(self.empty_customView), EMPTY_H(self.empty_customView)+EMPTY_MID_H(lab) + self.empty_verticalSpace);
            lab.center = point;
            [contentView addSubview:lab];
        }
    }
    else if (self.empty_dispalyType == CTDispalyCustomViewAndImageType)
    {
        if (self.empty_customView) {
            [contentView addSubview:self.empty_customView];
        }
        if (self.empty_dispalyImage) {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero];
            CGPoint point = CGPointMake(EMPTY_MID_W(self.empty_customView), EMPTY_H(self.empty_customView)+EMPTY_MID_H(imv) + self.empty_verticalSpace);
            imv.center = point;
            [contentView addSubview:imv];
        }
    }
    else if (self.empty_dispalyType == CTDispalyImageAndTextType)
    {
        CGPoint point = CGPointZero;
        if (self.empty_dispalyImage) {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero];
            [contentView addSubview:imv];
            point = CGPointMake(EMPTY_MID_W(imv), EMPTY_H(imv));
        }
        if (self.empty_dispalyText) {
            UILabel * lab = [self detailLableWithPosition:CGPointZero];
            lab.center = CGPointMake(point.x, point.y+EMPTY_MID_H(lab)+self.empty_verticalSpace);
            [contentView addSubview:lab];
        }
    }
    else if (self.empty_dispalyType == CTDispalyImageAndCustomViewType)
    {
        CGPoint point = CGPointZero;
        if (self.empty_dispalyImage) {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero];
            [contentView addSubview:imv];
            point = CGPointMake(EMPTY_MID_W(imv), EMPTY_H(imv)+EMPTY_MID_H(self.empty_customView)+self.empty_verticalSpace);
        }
        if (self.empty_customView) {
            self.empty_customView.center = point;
            [contentView addSubview:self.empty_customView];
        }
    }
    else if (self.empty_dispalyType == CTDispalyTextAndCustomViewType)
    {
        CGPoint point = CGPointZero;
        if (self.empty_dispalyText) {
            UILabel * lab = [self detailLableWithPosition:CGPointZero];
            [contentView addSubview:lab];
            point = CGPointMake(EMPTY_MID_W(lab), EMPTY_H(lab)+EMPTY_MID_H(self.empty_customView)+self.empty_verticalSpace);
        }
        if (self.empty_customView) {
            self.empty_customView.center = point;
            [contentView addSubview:self.empty_customView];
        }
    }
    else if (self.empty_dispalyType == CTDispalyTextAndImageType)
    {
        CGPoint point = CGPointZero;
        if (self.empty_dispalyText) {
            UILabel * lab = [self detailLableWithPosition:CGPointZero];
            point = CGPointMake(EMPTY_MID_W(lab), EMPTY_H(lab));
            [contentView addSubview:lab];
        }
        if (self.empty_dispalyImage) {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero];
            imv.center = CGPointMake(point.x, point.y+EMPTY_MID_H(imv)+self.empty_verticalSpace);
            [contentView addSubview:imv];
        }
    }
    __block CGSize size;
    [contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        size.width = fmaxf(size.width, EMPTY_W(obj));
        size.height = fmaxf(size.height, EMPTY_B(obj));
    }];
    contentView.frame = CGRectMake(0, 0, size.width, size.height);
    contentView.center = center;
    return contentView;
}

- (UIView *)generateDisplayContentWithCenter:(CGPoint)center
{
    if (self.empty_customView)
    {
        self.empty_customView.center = center;
        return self.empty_customView;
    }
    else if (self.empty_dispalyImage)
    {
        UIImageView * emptyIM = [self imageViewWithPosition:center];
        return emptyIM;
    }
    else
    {
        UILabel * lab = [self detailLableWithPosition:center];
        return lab;
    }
}

- (UIView *)displayView
{
    UIView * emptyView = objc_getAssociatedObject(self, _cmd);
    if (emptyView == nil)
    {
        emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)+CGRectGetMinY(self.bounds))];
        
        emptyView.backgroundColor = self.backgroundColor;
        CGPoint center = CGPointMake(emptyView.center.x, emptyView.center.y+self.empty_offsetCenterY);
        UIView * contentView;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabBackAction)];
        [emptyView addGestureRecognizer:tap];
        
        if (self.empty_dispalyType != CTDispalyDefaultType)
        {
            contentView = [self specialDisplayContentWithCenter:center];
        }
        else
        {
            contentView = [self generateDisplayContentWithCenter:center];
        }
        [emptyView addSubview:contentView];
        
        objc_setAssociatedObject(self, @selector(displayView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return emptyView;
}

- (void)tabBackAction
{
    if (self.empty_tapBlock) {
        self.empty_tapBlock();
    }
}

- (BOOL)isEmptyOfDataSource
{
    BOOL isNoData = YES;
    if ([self isKindOfClass:[UICollectionView class]])
    {
        UICollectionView * collectionView = (UICollectionView *)self;
        NSInteger section = collectionView.numberOfSections;
        for (int i = 0; i < section; i++)
        {
            NSInteger rows = [collectionView numberOfItemsInSection:i];
            if (rows != 0)
            {
                isNoData = NO;
                break;
            }
        }
    }
    else if ([self isKindOfClass:[UITableView class]])
    {
        UITableView * tableView = (UITableView *)self;
        NSInteger section = tableView.numberOfSections;
        for (int i = 0; i < section; i++)
        {
            NSInteger rows = [tableView numberOfRowsInSection:i];
            if (rows != 0)
            {
                isNoData = NO;
                break;
            }
        }
    }
    return isNoData;
}

- (BOOL)isDisplay
{
    if ([self isKindOfClass:[UICollectionView class]] &&
        [[UICollectionView appearance] empty_enable])
    {
        return NO;
    }
    else if ([self isKindOfClass:[UITableView class]] &&
             [[UITableView appearance] empty_enable])
    {
        return NO;
    }
    return self.empty_enable;
}

- (void)autoDispayEmptyView
{
    if (![self isDisplay])
    {
        return;
    }
    if ([self isEmptyOfDataSource])
    {
        if (self.empty_scrollEnable)
        {
            if (![self.subviews containsObject:[self displayView]])
            {
                [self addSubview:[self displayView]];
            }
        }
        else
        {
            if (![self valueForKeyPath:@"backgroundView"])
            {
                [self setValue:[self displayView] forKeyPath:@"backgroundView"];
            }
        }
    }
    else
    {
        if (self.empty_scrollEnable)
        {
            [[self displayView] removeFromSuperview];
        }
        else
        {
            [self setValue:nil forKeyPath:@"backgroundView"];
            
        }
    }
}
@end
