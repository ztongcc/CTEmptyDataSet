//
//  UIScrollView+Empty.h
//  Pods
//
//  Created by Admin on 2017/2/9.
//
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Empty)

@property (nonatomic, assign) BOOL      emptyViewEnable UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIImage * emptyImage      UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat   offsetCenterY   UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIView *  customEmptyView UI_APPEARANCE_SELECTOR;

@end
