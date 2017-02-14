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
    CTDispalyDefaultType,  // 按照默人的优先级顺序展示 (1.customView -> 2.image -> 3.text -> 4. customView (UI_APPEARANCE_SELECTOR) -> 5. image (UI_APPEARANCE_SELECTOR) -> 6.text (UI_APPEARANCE_SELECTOR))
    CTDispalyCustomViewAndTextType, // CustomView和Text一起优先显示,且 CustomView在上, text在下, 若均为nil , 则按照默认顺序显示
    CTDispalyTextAndCustomViewType,// CustomView和Text一起优先显示,且 text在上, CustomView在下, 若均为nil , 则按照默认顺序显示
    CTDispalyCustomViewAndImageType,// CustomView和Image一起优先显示,且 CustomView在上, Image在下, 若均为nil , 则按照默认顺序显示
    CTDispalyImageAndCustomViewType,// CustomView和Image一起优先显示,且 Image在上, CustomView在下, 若均为nil , 则按照默认顺序显示
    CTDispalyImageAndTextType,// Image 和 Text一起优先显示,且 Image在上, Text在下, 若均为nil , 则按照默认顺序显示
    CTDispalyTextAndImageType,// Image 和 Text一起优先显示,且 Text在上, Image在下, 若均为nil , 则按照默认顺序显示
};


@interface UIScrollView (Empty)

/*
 *  控制空白页是否能用 (默认: YES)
 */
@property (nonatomic, assign) BOOL empty_enable  UI_APPEARANCE_SELECTOR;

/*
 *  控制显示的空白页是否能上下滚动 (默认: YES)
 */
@property (nonatomic, assign) BOOL empty_scrollEnable;

/*
 *  无数据时,空页面展示类型
 */
@property (nonatomic, assign) CTEmptyDispalyType empty_dispalyType;

/*
 *  点击空白页面时回调Block
 */
@property (nonatomic,   copy) dispatch_block_t empty_tapBlock;
/*
 *  无数据时,需要展示的图片
 */
@property (nonatomic, strong) UIImage * empty_dispalyImage  UI_APPEARANCE_SELECTOR;

/*
 * 无数据时, 需要展示的自定义View
 */
@property (nonatomic, strong) UIView * empty_customView  UI_APPEARANCE_SELECTOR;

/*
 * 无数据时, 需要展示的文本 (默认的是 "~ 暂无内容 ~" )
 */
@property (nonatomic,   copy) NSAttributedString * empty_dispalyText  UI_APPEARANCE_SELECTOR;

/*
 *  图片 或者 自定义View 据tableView 或 collectionView 中心的偏移量
 */
@property (nonatomic, assign) CGFloat empty_offsetCenterY  UI_APPEARANCE_SELECTOR;

/*
 *  两个View 之间的 纵向间距 (只有在 empty_dispalyType 不是CTDispalyDefaultType 类型时有效)
 */
@property (nonatomic, assign) CGFloat empty_verticalSpace;

@end
