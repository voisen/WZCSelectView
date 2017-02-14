//
//  WZCSelectView.h
//  WZCSelectView
//
//  Created by 邬志成 on 2016/12/7.
//  Copyright © 2016年 邬志成. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WZCSelectViewShowPositionStyle) {
    WZCSelectViewShowPositionStyleCenter = 0, //显示在中间
    WZCSelectViewShowPositionStyleTop,        //显示在顶端
    WZCSelectViewShowPositionStyleBottom      //显示在底部
};


@interface WZCSelectView : UIView

/**
 设置动画的时长

 @param duration 默认为0.15s
 */
+ (void)setDefaultAnimationDuration:(NSTimeInterval)duration;

/**
 点击弹出视图以外的地方 dismiss 视图

 @param canDismiss  YES 为启用, NO 为禁用, 默认为 YES
 */
+ (void)setDismissOnTouchOther:(BOOL)canDismiss;


/**
 在指定的位置,弹出一个视图,可以在弹出的对象中设置弹出视图的大小(必须设置大小)

 @param showVC 要显示的视图控制器
 @param positionStyle 显示的位置
 */
+ (void)showViewController:(UIViewController *)showVC position:(WZCSelectViewShowPositionStyle)positionStyle;


+ (void)showView:(UIView *)showView position:(WZCSelectViewShowPositionStyle)positionStyle;

/**
  dismiss 当前弹出的视图
 */
+ (void)dismiss;


@end
