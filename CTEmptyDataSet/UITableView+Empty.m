//
//  UITableView+Empty.m
//  CTTableViewEmpty
//
//  Created by Admin on 2017/1/20.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "UITableView+Empty.h"
#import <objc/runtime.h>

@implementation UITableView (Empty)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [[self class] swizzledSelector:@selector(reloadData)
                            toSelector:@selector(empty_reloadData)
                               inClass:[UITableView class]];
        
        [[self class] swizzledSelector:@selector(reloadSections:withRowAnimation:)
                            toSelector:@selector(empty_reloadSections:withRowAnimation:)
                               inClass:[UITableView class]];

        [[self class] swizzledSelector:@selector(reloadRowsAtIndexPaths:withRowAnimation:)
                            toSelector:@selector(empty_reloadRowsAtIndexPaths:withRowAnimation:)
                               inClass:[UITableView class]];
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

- (NSInteger)emptyViewEnableType
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (BOOL)emptyViewEnable
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEmptyViewEnable:(BOOL)emptyViewEnable
{
    if (emptyViewEnable)
    {
        objc_setAssociatedObject(self, @selector(emptyViewEnableType), @(2), OBJC_ASSOCIATION_ASSIGN);
    }
    else
    {
        objc_setAssociatedObject(self, @selector(emptyViewEnableType), @(1), OBJC_ASSOCIATION_ASSIGN);
    }
    objc_setAssociatedObject(self, @selector(emptyViewEnable), @(emptyViewEnable), OBJC_ASSOCIATION_ASSIGN);
}

- (UIImage *)emptyImage
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmptyImage:(UIImage *)emptyImage
{
    objc_setAssociatedObject(self, @selector(emptyImage), emptyImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)customEmptyView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCustomEmptyView:(UIView *)customEmptyView
{
    objc_setAssociatedObject(self, @selector(customEmptyView), customEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat )offsetCenterY
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setOffsetCenterY:(CGFloat)offsetCenterY
{
    objc_setAssociatedObject(self, @selector(offsetCenterY), @(offsetCenterY), OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)displayView
{
    UIView * emptyView = objc_getAssociatedObject(self, _cmd);
    if (emptyView == nil)
    {
        emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)+CGRectGetMinY(self.bounds))];
        emptyView.backgroundColor = self.backgroundColor;
        CGPoint center = CGPointMake(emptyView.center.x, emptyView.center.y+self.offsetCenterY);
        if (self.customEmptyView)
        {
            self.customEmptyView.center = center;
            [emptyView addSubview:self.customEmptyView];
        }
        else
        {
            if (self.emptyImage)
            {
                CGSize size = self.emptyImage.size;
                CGFloat scale = self.emptyImage.scale;
                UIImageView * emptyIM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width/scale, size.height/scale)];
                emptyIM.backgroundColor = [UIColor clearColor];
                emptyIM.contentMode = UIViewContentModeScaleAspectFill;
                emptyIM.image = self.emptyImage;
                emptyIM.center = center;
                [emptyView addSubview:emptyIM];
            }
            else
            {
                UILabel * lab = [[UILabel alloc] init];
                lab.text = @"~ 暂无内容 ~";
                lab.textColor = [UIColor lightGrayColor];
                [lab sizeToFit];
                lab.center = center;
                [emptyView addSubview:lab];
            }
        }
        objc_setAssociatedObject(self, @selector(displayView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return emptyView;
}

- (void)empty_reloadData
{
    [self empty_reloadData];
 
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

- (void)autoDispayEmptyView
{
    if ([self emptyViewEnableType] == 1)
    {
        return;
    }
    else if ([self emptyViewEnableType] == 0)
    {
        if (![[UITableView appearance] emptyViewEnable])
        {
            return;
        }
    }
    BOOL isNoData = YES;
    NSInteger section = self.numberOfSections;
    for (int i = 0; i < section; i++)
    {
        NSInteger rows = [self numberOfRowsInSection:i];
        if (rows != 0)
        {
            isNoData = NO;
            break;
        }
    }
    if (isNoData)
    {
        if (![self.subviews containsObject:[self displayView]])
        {
            [self addSubview:[self displayView]];
        }
    }
    else
    {
        [[self displayView] removeFromSuperview];
    }
}

@end
