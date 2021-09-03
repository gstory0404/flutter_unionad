//
//  UIView+Additions.h
//  BUAdSDK
//
//  Created by bytedance_yuanhuan on 2018/3/15.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BU_Additions)

- (UIImage *)bu_captureView;

@end

typedef enum {
    UIViewBorderOptionTop = 0,
    UIViewBorderOptionRight,
    UIViewBorderOptionBottom,
    UIViewBorderOptionLeft,
    UIViewBorderOptionAll
} UIViewBorderOption;


typedef struct {
  CGFloat topLeft;
  CGFloat topRight;
  CGFloat bottomLeft;
  CGFloat bottomRight;
} BUFCornerRadii;


@interface UIView (BU_Border)

- (void)bu_setBorder:(UIViewBorderOption)option width:(CGFloat)width color:(UIColor *)color;
- (void)bu_setDashBorder:(UIViewBorderOption)option width:(CGFloat)width color:(UIColor *)color;
- (void)bu_roundCornerWithDashBorder:(CGFloat)radius width:(CGFloat)widht color:(UIColor *)color;
- (void)bu_updateClippingForLayer:(CALayer *)layer cornerRadii:(BUFCornerRadii)cornerRadii maxRadius:(CGFloat)maxRadius;
@end


@interface UIView (BU_FrameAdditions)
@property (nonatomic) float bu_x;
@property (nonatomic) float bu_y;
@property (nonatomic) float bu_width;
@property (nonatomic) float bu_height;
@property (nonatomic, getter = bu_y,setter = setBu_y:) float bu_top;    // 增加bu前缀，防止与外部开发者的分类属性名冲突：https://jira.bytedance.com/browse/UNION-4447 fixed in 3300 by chaors
@property (nonatomic, getter = bu_x,setter = setBu_x:) float bu_left;
@property (nonatomic) float bu_bottom;
@property (nonatomic) float bu_right;
@property (nonatomic) CGSize bu_size;
@property (nonatomic) CGPoint bu_origin;
@property (nonatomic) CGFloat bu_centerX;
@property (nonatomic) CGFloat bu_centerY;

// 设置最大右边
- (void)bu_setMaxRight:(CGFloat)maxRight;
@end


@interface UIView (BU_TKCategory)

// DRAW GRADIENT
+ (void)bu_drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors;

// DRAW ROUNDED RECTANGLE
+ (void)bu_drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor*)color;

// DRAW LINE
+ (void)bu_drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (void)bu_drawLineInRect:(CGRect)rect colors:(CGFloat[_Nullable])colors;
+ (void)bu_drawLineInRect:(CGRect)rect colors:(CGFloat[_Nullable])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap;

@end


@interface UIView (BU_Gesture)

- (UILongPressGestureRecognizer *)bu_addLogPressGestureWithTarget:(id)target selecter:(SEL)aSelector;

@property (nonatomic, strong, nullable) UITapGestureRecognizer *bu_tgr;
// 会移除旧的手势
- (void)bu_addGestureRecognizerWithTarget:(id)target action:(SEL)action;
- (void)bu_removeGestureRecognizer;
@end

@interface UIView (BU_FindFirstResponder)
- (UIView *)bu_findViewThatIsFirstResponder;
@end

@interface UIView (BU_InScreen)
- (BOOL)bu_checkInCurrentScreenWithEdgeInsets:(UIEdgeInsets)edgeInsets;
- (BOOL)bu_checkInScreenYWithPaddingTop:(CGFloat)paddingTop paddingToBottom:(CGFloat)paddingToBottom;
- (BOOL)bu_checkInScreenXWithPaddingLeft:(CGFloat)paddingLeft paddingToRight:(CGFloat)paddingToRight;
@end

@interface UIView (BU_NearestController)
- (UIViewController *)bu_findNearestController;




@end

@interface UIView (BU_SafeArea)
- (UIEdgeInsets)bu_safeAreaInsets;

+ (UIEdgeInsets)bu_defaultAreaInsets;

@end
NS_ASSUME_NONNULL_END
