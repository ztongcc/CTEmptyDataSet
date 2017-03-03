//
//  UIScrollView+Empty.h
//  Pods
//
//  Created by Admin on 2017/1/23.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, CTEmptyDispalyType)
{
    CTEmptyDefaultType,  // 按照默人的优先级顺序展示 (1.customView -> 2.image -> 3.text -> 4. customView (UI_APPEARANCE_SELECTOR) -> 5. image (UI_APPEARANCE_SELECTOR) -> 6.text (UI_APPEARANCE_SELECTOR))
    CTEmptyCustomViewAndTextType, // CustomView和Text一起优先显示,且 CustomView在上, text在下, 若均为nil , 则按照默认顺序显示
    CTEmptyTextAndCustomViewType,// CustomView和Text一起优先显示,且 text在上, CustomView在下, 若均为nil , 则按照默认顺序显示
    CTEmptyCustomViewAndImageType,// CustomView和Image一起优先显示,且 CustomView在上, Image在下, 若均为nil , 则按照默认顺序显示
    CTEmptyImageAndCustomViewType,// CustomView和Image一起优先显示,且 Image在上, CustomView在下, 若均为nil , 则按照默认顺序显示
    CTEmptyImageAndTextType,// Image 和 Text一起优先显示,且 Image在上, Text在下, 若均为nil , 则按照默认顺序显示
    CTEmptyTextAndImageType,// Image 和 Text一起优先显示,且 Text在上, Image在下, 若均为nil , 则按照默认顺序显示
};

typedef NS_ENUM(NSInteger, CTDispalyStatus)
{
    CTDispalyNormalStatus,        // 显示正常状态的空白页面
    CTDispalyLoadingStatus,       // 显示正在加载时的页面
    CTDispalyNetErrorStatus,      // 显示网络异常时的空白页面
};


typedef void (^emptyDispalyBlock)(UIView * emptyView, CTDispalyStatus status);


@interface UIScrollView (Empty)

/*
 *  控制空白页是否能用 (默认: YES)
 */
@property (nonatomic, assign) BOOL empty_enable  UI_APPEARANCE_SELECTOR;

/*
 *  控制显示的空白页是否能上下滚动 (默认: YES)
 */
@property (nonatomic, assign) BOOL empty_scrollEnable UI_APPEARANCE_SELECTOR;

/*
 *  点击空白页面时回调Block
 */
@property (nonatomic,   copy) dispatch_block_t  empty_tapBlock;


@property (nonatomic,   copy) emptyDispalyBlock empty_willDispalyStatusBlock UI_APPEARANCE_SELECTOR;


@property (nonatomic,   copy) emptyDispalyBlock empty_endDispalyStatusBlock  UI_APPEARANCE_SELECTOR;

// 刷新展示的空白页面
- (void)reloadEmptyDispalyStatus:(CTDispalyStatus)status;


- (void)setEmptyDispalyImage:(UIImage *)emptyImage
                      status:(CTDispalyStatus)status  UI_APPEARANCE_SELECTOR;

- (void)setEmptyCustomView:(UIView *)customView
                    status:(CTDispalyStatus)status    UI_APPEARANCE_SELECTOR;

- (void)setEmptyDispalyText:(NSAttributedString *)text
                     status:(CTDispalyStatus)status   UI_APPEARANCE_SELECTOR;

- (void)setEmptyDispalyType:(CTEmptyDispalyType)type
                     status:(CTDispalyStatus)status   UI_APPEARANCE_SELECTOR;

- (void)setEmptyOffsetCenterY:(CGFloat)offCenterY
                       status:(CTDispalyStatus)status UI_APPEARANCE_SELECTOR;

- (void)setEmptyVerticalSpace:(CGFloat)space
                       status:(CTDispalyStatus)status UI_APPEARANCE_SELECTOR;

@end
