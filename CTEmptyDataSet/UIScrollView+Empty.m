
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


@interface UIScrollView ()

@property (nonatomic, strong)NSMutableDictionary * ct_Image_Dict    UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong)NSMutableDictionary * ct_View_Dict     UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong)NSMutableDictionary * ct_Text_Dict     UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong)NSMutableDictionary * ct_OffsetY_Dict  UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong)NSMutableDictionary * ct_Space_V_Dict  UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong)NSMutableDictionary * ct_Type_Dict     UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign)CTDispalyStatus  dispalyStatus;

@end


@implementation UIScrollView (Empty)

+ (void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // tableView
        [[self class] swizzledSelector:@selector(reloadData)
                            toSelector:@selector(empty_reloadTableData)
                               inClass:[UITableView class]];
        
        NSArray * orgTableSelAry = @[@"endUpdates",
                                    @"reloadSections:withRowAnimation:",
                                    @"reloadRowsAtIndexPaths:withRowAnimation:",
                                    @"deleteSections:withRowAnimation:",
                                    @"deleteRowsAtIndexPaths:withRowAnimation:",
                                    @"insertRowsAtIndexPaths:withRowAnimation:",
                                    @"insertSections:withRowAnimation:"];

        for (NSString * selName in orgTableSelAry)
        {
            NSString * newSelName = [NSString stringWithFormat:@"empty_%@", selName];
            [[self class] swizzledSelector:NSSelectorFromString(selName)
                                toSelector:NSSelectorFromString(newSelName)
                                   inClass:[UITableView class]];
        }
        
        // collectionView
        [[self class] swizzledSelector:@selector(reloadData)
                            toSelector:@selector(empty_reloadCollectionData)
                               inClass:[UICollectionView class]];
        
        NSArray * orgCollSelAry = @[@"reloadSections",
                                    @"reloadItemsAtIndexPaths:",
                                    @"insertSections:",
                                    @"deleteSections:",
                                    @"insertItemsAtIndexPaths:",
                                    @"deleteItemsAtIndexPaths:"];
        
        for (NSString * selName in orgCollSelAry)
        {
            NSString * newSelName = [NSString stringWithFormat:@"empty_%@", selName];
            [[self class] swizzledSelector:NSSelectorFromString(selName)
                                toSelector:NSSelectorFromString(newSelName)
                                   inClass:[UICollectionView class]];
        }
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

- (NSMutableDictionary *)ct_Image_Dict
{
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [@{} mutableCopy];
        self.ct_Image_Dict = dict;
    }
    return dict;
}

- (void)setCt_Image_Dict:(NSMutableDictionary *)ct_Image_Dict
{
    objc_setAssociatedObject(self, @selector(ct_Image_Dict), ct_Image_Dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ct_Type_Dict
{
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [@{} mutableCopy];
        self.ct_Type_Dict = dict;
    }
    return dict;
}

- (void)setCt_Type_Dict:(NSMutableDictionary *)ct_Type_Dict
{
    objc_setAssociatedObject(self, @selector(ct_Type_Dict), ct_Type_Dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ct_View_Dict
{
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [@{} mutableCopy];
        self.ct_View_Dict = dict;
    }
    return dict;
}

- (void)setCt_View_Dict:(NSMutableDictionary *)ct_View_Dict
{
    objc_setAssociatedObject(self, @selector(ct_View_Dict), ct_View_Dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ct_Text_Dict
{
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [@{} mutableCopy];
        self.ct_Text_Dict = dict;
    }
    return dict;
}

- (void)setCt_Text_Dict:(NSMutableDictionary *)ct_Text_Dict
{
    objc_setAssociatedObject(self, @selector(ct_Text_Dict), ct_Text_Dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ct_OffsetY_Dict
{
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [@{} mutableCopy];
        self.ct_OffsetY_Dict = dict;
    }
    return dict;
}

- (void)setCt_OffsetY_Dict:(NSMutableDictionary *)ct_OffsetY_Dict
{
    objc_setAssociatedObject(self, @selector(ct_OffsetY_Dict), ct_OffsetY_Dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ct_Space_V_Dict
{
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [@{} mutableCopy];
        self.ct_Space_V_Dict = dict;
    }
    return dict;
}

- (void)setCt_Space_V_Dict:(NSMutableDictionary *)ct_Space_V_Dict
{
    objc_setAssociatedObject(self, @selector(ct_Space_V_Dict), ct_Space_V_Dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CTDispalyStatus)dispalyStatus
{
    return [objc_getAssociatedObject(self, _cmd) integerValue] - 1;
}

- (void)setDispalyStatus:(CTDispalyStatus)dispalyStatus
{
    objc_setAssociatedObject(self, @selector(dispalyStatus), @(dispalyStatus+1), OBJC_ASSOCIATION_ASSIGN);
}

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

- (dispatch_block_t)empty_tapBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmpty_tapBlock:(dispatch_block_t)tapBlock
{
    objc_setAssociatedObject(self, @selector(empty_tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (emptyDispalyBlock)empty_willDispalyStatusBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmpty_willDispalyStatusBlock:(emptyDispalyBlock)empty_willDispalyStatusBlock
{
    objc_setAssociatedObject(self, @selector(empty_willDispalyStatusBlock), empty_willDispalyStatusBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (emptyDispalyBlock)empty_endDispalyStatusBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmpty_endDispalyStatusBlock:(emptyDispalyBlock)empty_endDispalyStatusBlock
{
    objc_setAssociatedObject(self, @selector(empty_endDispalyStatusBlock), empty_endDispalyStatusBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
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

#pragma mark - public method -
- (void)reloadEmptyDispalyStatus:(CTDispalyStatus)status
{
    if (status != self.dispalyStatus)
    {
        UIView * spuView = [self displayView];
        if (self.empty_endDispalyStatusBlock) {
            self.empty_endDispalyStatusBlock(spuView,self.dispalyStatus);
        }
        self.dispalyStatus = status;
        [spuView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        CGFloat offsetY = [ct_valueForStatus(self.ct_OffsetY_Dict, status) floatValue];
        CGPoint center = CGPointMake(spuView.center.x,spuView.center.y+offsetY);
        UIView * contentView;
        
        CGFloat type = [ct_valueForStatus(self.ct_Type_Dict, status) integerValue];
        if (type != CTEmptyDefaultType)
        {
            contentView = [self specialDisplayContentWithCenter:center status:status];
        }
        else
        {
            contentView = [self generateDisplayContentWithCenter:center status:status];
        }
        [spuView addSubview:contentView];
        if (self.empty_willDispalyStatusBlock) {
            self.empty_willDispalyStatusBlock(spuView,status);
        }
    }
}

- (void)setEmptyDispalyImage:(UIImage *)emptyImage status:(CTDispalyStatus)status
{
    [self.ct_Image_Dict setObject:emptyImage forKey:@(status)];
}

- (void)setEmptyCustomView:(UIView *)customView status:(CTDispalyStatus)status
{
    [self.ct_View_Dict setObject:customView forKey:@(status)];
}

- (void)setEmptyDispalyText:(NSAttributedString *)text status:(CTDispalyStatus)status
{
    [self.ct_Text_Dict setObject:text forKey:@(status)];
}

- (void)setEmptyOffsetCenterY:(CGFloat)offCenterY status:(CTDispalyStatus)status
{
    [self.ct_OffsetY_Dict setObject:@(offCenterY) forKey:@(status)];
}

- (void)setEmptyVerticalSpace:(CGFloat)space status:(CTDispalyStatus)status
{
    [self.ct_Space_V_Dict setObject:@(space) forKey:@(status)];
}

- (void)setEmptyDispalyType:(CTEmptyDispalyType)type status:(CTDispalyStatus)status
{
    [self.ct_Type_Dict setObject:@(type) forKey:@(status)];
}
#pragma mark - commom method -

id ct_valueForStatus(NSMutableDictionary * dict, CTDispalyStatus status)
{
    if (dict)
    {
        if ([[dict allKeys] containsObject:@(status)])
        {
            return dict[@(status)];
        }
        else if ([[dict allKeys] containsObject:@(CTDispalyNormalStatus)])
        {
            return dict[@(CTDispalyNormalStatus)];
        }
    }
    return nil;
}

- (UILabel *)detailLableWithPosition:(CGPoint)position status:(CTDispalyStatus)status
{
    UILabel * lab = [[UILabel alloc] init];
    lab.attributedText = ct_valueForStatus(self.ct_Text_Dict, status);
    [lab sizeToFit];
    lab.center = position;
    return lab;
}

- (UIImageView *)imageViewWithPosition:(CGPoint)position status:(CTDispalyStatus)status
{
    UIImage * img = ct_valueForStatus(self.ct_Image_Dict, status);
    CGSize size = img.size;
    CGFloat scale = img.scale;
    UIImageView * emptyIM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width/scale, size.height/scale)];
    emptyIM.backgroundColor = [UIColor clearColor];
    emptyIM.contentMode = UIViewContentModeScaleAspectFill;
    emptyIM.image = img;
    emptyIM.center = position;
    return emptyIM;
}

- (UIView *)specialDisplayContentWithCenter:(CGPoint)center status:(CTDispalyStatus)status
{
    UIView * contentView = [[UIView alloc] init];
    CGFloat space = [ct_valueForStatus(self.ct_Space_V_Dict, status) floatValue];
    CGFloat type = [ct_valueForStatus(self.ct_Type_Dict, status) integerValue];
    
    
    UIView * view = ct_valueForStatus(self.ct_View_Dict, status);
    
    if (type == CTEmptyCustomViewAndTextType)
    {
        if (view) {
            [contentView addSubview:view];
        }
        if (ct_valueForStatus(self.ct_Text_Dict, status))
        {
            UILabel * lab = [self detailLableWithPosition:CGPointZero status:status];
            CGPoint point = CGPointMake(EMPTY_MID_W(view), EMPTY_H(view)+EMPTY_MID_H(lab) + space);
            lab.center = point;
            [contentView addSubview:lab];
        }
    }
    else if (type == CTEmptyCustomViewAndImageType)
    {
        if (view) {
            [contentView addSubview:view];
        }

        if (ct_valueForStatus(self.ct_Image_Dict, status))
        {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero status:status];
            CGPoint point = CGPointMake(EMPTY_MID_W(view), EMPTY_H(view)+EMPTY_MID_H(imv) + space);
            imv.center = point;
            [contentView addSubview:imv];
        }
    }
    else if (type == CTEmptyImageAndTextType)
    {
        CGPoint point = CGPointZero;
        if (ct_valueForStatus(self.ct_Image_Dict, status))
        {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero status:status];
            [contentView addSubview:imv];
            point = CGPointMake(EMPTY_MID_W(imv), EMPTY_H(imv));
        }
        if (ct_valueForStatus(self.ct_Text_Dict, status))
        {
            UILabel * lab = [self detailLableWithPosition:CGPointZero status:status];
            lab.center = CGPointMake(point.x, point.y+EMPTY_MID_H(lab)+space);
            [contentView addSubview:lab];
        }
    }
    else if (type == CTEmptyImageAndCustomViewType)
    {
        CGPoint point = CGPointZero;
        if (ct_valueForStatus(self.ct_Image_Dict, status)) {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero status:status];
            [contentView addSubview:imv];
            point = CGPointMake(EMPTY_MID_W(imv), EMPTY_H(imv)+EMPTY_MID_H(view)+space);
        }
        if (view) {
            view.center = point;
            [contentView addSubview:view];
        }
    }
    else if (type == CTEmptyTextAndCustomViewType)
    {
        CGPoint point = CGPointZero;
        if (ct_valueForStatus(self.ct_Text_Dict, status))
        {
            UILabel * lab = [self detailLableWithPosition:CGPointZero status:status];
            [contentView addSubview:lab];
            point = CGPointMake(EMPTY_MID_W(lab), EMPTY_H(lab)+EMPTY_MID_H(view)+space);
        }
        if (view) {
            view.center = point;
            [contentView addSubview:view];
        }
    }
    else if (type == CTEmptyTextAndImageType)
    {
        CGPoint point = CGPointZero;
        if (ct_valueForStatus(self.ct_Text_Dict, status))
        {
            UILabel * lab = [self detailLableWithPosition:CGPointZero status:status];
            point = CGPointMake(EMPTY_MID_W(lab), EMPTY_H(lab));
            [contentView addSubview:lab];
        }
        if (ct_valueForStatus(self.ct_Image_Dict, status))
        {
            UIImageView * imv = [self imageViewWithPosition:CGPointZero status:status];
            imv.center = CGPointMake(point.x, point.y+EMPTY_MID_H(imv)+space);
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

- (UIView *)generateDisplayContentWithCenter:(CGPoint)center status:(CTDispalyStatus)status
{
    if (ct_valueForStatus(self.ct_View_Dict,status))
    {
        UIView * view = ct_valueForStatus(self.ct_View_Dict,status);
        view.center = center;
        return view;
    }
    else if (ct_valueForStatus(self.ct_Image_Dict,status))
    {
        UIImageView * emptyIM = [self imageViewWithPosition:center status:status];
        return emptyIM;
    }
    else
    {
        UILabel * lab = [self detailLableWithPosition:center status:status];
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
        [self reloadEmptyDispalyStatus:CTDispalyNormalStatus];
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
