/**
 说明：为避免与项目中其他地方引用原UICountingLabel库出现冲突，这里将原作者代码抄写了一遍，并在命名之前增加了CAM前缀
 
 UICountingLabel原项目地址：
 https://github.com/dataxpress/UICountingLabel
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CAMUILabelCountingMethod) {
    CAMUILabelCountingMethodEaseInOut,
    CAMUILabelCountingMethodEaseIn,
    CAMUILabelCountingMethodEaseOut,
    CAMUILabelCountingMethodLinear,
    CAMUILabelCountingMethodEaseInBounce,
    CAMUILabelCountingMethodEaseOutBounce
};

typedef NSString* (^CAMUICountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^CAMUICountingLabelAttributedFormatBlock)(CGFloat value);


@interface CAMUICountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) CAMUILabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) CAMUICountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) CAMUICountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void (^completionBlock)(void);

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (CGFloat)currentValue;

@end

