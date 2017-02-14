//
//  WZCSelectView.m
//  WZCSelectView
//
//  Created by 邬志成 on 2016/12/7.
//  Copyright © 2016年 邬志成. All rights reserved.
//

#import "WZCSelectView.h"

#define MainScreen [UIScreen mainScreen].bounds

@interface WZCSelectView()<CAAnimationDelegate>

/** 动画时间 */
@property (nonatomic,assign)  NSTimeInterval duration;

/** 显示方式 */
@property (nonatomic,assign)  WZCSelectViewShowPositionStyle positionStyle;

/** 控制器 */
@property (nonatomic,strong)  UIViewController *showVC;

@property (nonatomic,weak) UIView *showView;

/** 是否启用点击空白 dimiss 视图 */
@property (nonatomic,assign)  BOOL touchOtherDimiss;

@end

@implementation WZCSelectView

+ (instancetype)shareSelectView{
    
    static WZCSelectView *shareView;
    if (shareView) {
        return shareView;
    }
    shareView = [[WZCSelectView alloc] init];
    shareView.frame = MainScreen;
    shareView.duration = 0.15;
    shareView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.56];//遮罩颜色
    shareView.touchOtherDimiss = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(tapDismiss:)];
    [shareView addGestureRecognizer:tap];
    return shareView;
}


+ (void)showViewController:(UIViewController *)showVC position:(WZCSelectViewShowPositionStyle)positionStyle{
    [[self shareSelectView] showWithViewController:showVC position:positionStyle];
    
}

+ (void)showView:(UIView *)showView position:(WZCSelectViewShowPositionStyle)positionStyle{
    [[self shareSelectView] showView:showView position:positionStyle];
    
    
}

+ (void)dismiss{
    
    [[self shareSelectView] dismiss];
    
}


- (void)showWithViewController:(UIViewController *)showVC position:(WZCSelectViewShowPositionStyle)positionStyle{
    _showVC = showVC;
    [[[self class] shareSelectView] showView:showVC.view position:positionStyle];
}

- (void)showView:(UIView *)showView position:(WZCSelectViewShowPositionStyle)positionStyle{
    _showView = showView;
    _positionStyle = positionStyle;
    [self addSubview:showView];
    if (self.positionStyle == WZCSelectViewShowPositionStyleCenter) {
        
        
        self.alpha = 0.0f;
        [UIView animateWithDuration:0.4 animations:^{
            self.alpha = 1.0f;
        }];
        
        CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        keyFrameAnimation.values = @[
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 1.0)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.03, 1.03, 1.0)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.97, 0.97, 1.0)],
                                     [NSValue valueWithCATransform3D:CATransform3DIdentity]
                                     ];
        keyFrameAnimation.keyTimes = @[@(0.2f),@(0.5f),@(0.75f),@(1.0f)];
        keyFrameAnimation.timingFunctions = @[
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
                                              ];
        keyFrameAnimation.duration = 0.4f;
        [self.showView.layer addAnimation:keyFrameAnimation forKey:nil];
        self.showView.center = self.center;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        return;
    }
    
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:self.duration animations:^{
        self.alpha = 1.0f;
    }];
    
    if (self.positionStyle == WZCSelectViewShowPositionStyleTop) {
        
        CGRect realFrame = CGRectMake(0, 0, MainScreen.size.width, showView.frame.size.height);
        
        showView.frame = CGRectMake(0, - showView.frame.size.height, MainScreen.size.width, showView.frame.size.height);
        
        [UIView animateWithDuration:self.duration animations:^{
            showView.frame = realFrame;
        }];
    }
    
    if (self.positionStyle == WZCSelectViewShowPositionStyleBottom) {
        
        CGRect realFrame = CGRectMake(0, MainScreen.size.height - showView.frame.size.height, MainScreen.size.width, showView.frame.size.height);
        
        showView.frame = CGRectMake(0, MainScreen.size.height + showView.frame.size.height, MainScreen.size.width, showView.frame.size.height);
        
        [UIView animateWithDuration:self.duration animations:^{
            showView.frame = realFrame;
        }];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss{
    
    if (self.positionStyle == WZCSelectViewShowPositionStyleCenter) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.alpha = 0.0f;
        }];
        CAKeyframeAnimation *outAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        outAnimation.values = @[
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.03f, 1.03f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 1.0f)]
                                ];
        outAnimation.keyTimes = @[@(0.15f),@(0.35f),@(0.65f)];
        outAnimation.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
                                         ];
        outAnimation.delegate = self;
        
        outAnimation.duration = 0.4;
        
        [self.showView.layer addAnimation:outAnimation forKey:nil];
        return;
    }
    
    [UIView animateWithDuration:self.duration * 1.3f animations:^{
        self.alpha = 0.0f;
    }];
    
    if (self.positionStyle == WZCSelectViewShowPositionStyleTop) {
        CGRect lastFrame = CGRectMake(0, - _showView.frame.size.height, MainScreen.size.width, _showView.frame.size.height);
        
        [UIView animateWithDuration:self.duration animations:^{
            self.showView.frame = lastFrame;
        } completion:^(BOOL finished) {
            [self removeAllView];
        }];
    }
    
    if (self.positionStyle == WZCSelectViewShowPositionStyleBottom) {
        CGRect lastFrame = CGRectMake(0, MainScreen.size.height + _showView.frame.size.height, MainScreen.size.width, _showView.frame.size.height);
        [UIView animateWithDuration:self.duration animations:^{
            _showView.frame = lastFrame;
        } completion:^(BOOL finished) {
            [self removeAllView];
        }];
    }
    
}


+ (void)setDefaultAnimationDuration:(NSTimeInterval)duration{
    
    [[self shareSelectView] setDuration:duration];
    
}

+ (void)setDismissOnTouchOther:(BOOL)canDismiss{

    [[self shareSelectView] setTouchOtherDimiss:canDismiss];

}


/**
 点击弹出视图以外的部分 dimiss

 @param tap  手势
 */
- (void)tapDismiss:(UIGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self];
    [self endEditing:YES];
    if (CGRectContainsPoint(self.showView.frame, point) || !_touchOtherDimiss) {
        return;
    }
    
    [self dismiss];
    
}


/**
 移除所有视图
 */
- (void)removeAllView{
    
    [self.showView removeFromSuperview];
    self.showVC = nil;
    [[[self class] shareSelectView] removeFromSuperview];
    self.alpha = 1.0f;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self removeAllView];
}

@end
