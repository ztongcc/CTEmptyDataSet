//
//  UITableView+Empty.h
//  CTTableViewEmpty
//
//  Created by Admin on 2017/1/20.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Empty)

@property (nonatomic, assign) BOOL      emptyViewEnable UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIImage * emptyImage      UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat   offsetCenterY   UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIView *  customEmptyView UI_APPEARANCE_SELECTOR;

@end
