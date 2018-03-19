//
//  DLHAlert.m
//  EakayDriver
//
//  Created by DuanLihang on 2018/3/19.
//  Copyright © 2018年 Duan. All rights reserved.
//

#import "DLHAlert.h"

#define AlertWidth 275

@interface DLHAlert()
/** block回调 */
@property (copy, nonatomic) DLHAlertBlock alertBlock;
/** 背景图片 */
@property (strong, nonatomic) UIView *backgroundView;
/** 弹出视图 */
@property (strong, nonatomic) UIView *alertView;



@end


@implementation DLHAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithTitle:nil leftBtnString:nil contentString:nil rightBtnString:nil handler:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithTitle:nil leftBtnString:nil contentString:nil rightBtnString:nil handler:nil];
}

-(instancetype)initWithTitle:(NSString *)title leftBtnString:(NSString *)leftBtnString contentString:(NSString *)contentString rightBtnString:(NSString *)rightBtnString handler:(DLHAlertBlock)alertBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _alertBlock = alertBlock;
        // 默认高度
        CGFloat alertHeight = 20;
        
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        [self addSubview:_backgroundView];
        
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(AlertWidth / 2, 0, AlertWidth, 0)];
        _alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 4.0f;
        _alertView.layer.masksToBounds = YES;
        [self addSubview:_alertView];
        
        // 标题
        if (title.length > 0 && title != nil) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, alertHeight, AlertWidth, 20)];
            titleLabel.text = title;
            titleLabel.textColor = [self colorFromHexRGB:@"333333"];
            titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [_alertView addSubview:titleLabel];
            
            alertHeight = CGRectGetMaxY(titleLabel.frame) + 10;
            
        }
        // 内容
        if (contentString.length > 0 && contentString != nil) {
            
            
            CGSize size = [contentString boundingRectWithSize:CGSizeMake(AlertWidth - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, alertHeight, AlertWidth - 50, ceil(size.height))];
            
            contentLabel.text = contentString;
            contentLabel.textColor = [self colorFromHexRGB:@"515151"];
            contentLabel.font = [UIFont systemFontOfSize:18.0f];
            contentLabel.numberOfLines = 0;
            contentLabel.textAlignment = NSTextAlignmentCenter;
            [_alertView addSubview:contentLabel];
            
            alertHeight = CGRectGetMaxY(contentLabel.frame) + 10;
            
            
        }
        
        // 按钮上面的线条
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, alertHeight, AlertWidth, 0.5)];
        line.backgroundColor = [self colorFromHexRGB:@"EEEEEE"];
        [_alertView addSubview:line];
        // 左按钮
        if (leftBtnString.length > 0 && leftBtnString != nil) {
            // 有 右侧按钮 即两个按钮的情况
            if (rightBtnString.length > 0 && rightBtnString != nil) {
                // 左侧按钮
                UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, alertHeight, AlertWidth/2, 50)];
                [leftBtn setTitle:leftBtnString forState:UIControlStateNormal];
                [leftBtn setTitleColor:[self colorFromHexRGB:@"4DA1FF"] forState:UIControlStateNormal];
                leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
                leftBtn.tag = 0;
                [leftBtn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_alertView addSubview:leftBtn];
                
                // 按钮上面的线条
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame), alertHeight + 0.5, 0.5, leftBtn.frame.size.height - 0.5)];
                line.backgroundColor = [self colorFromHexRGB:@"EEEEEE"];
                [_alertView addSubview:line];
                
                
                // 右侧按钮
                UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(AlertWidth/2, alertHeight, AlertWidth/2, 50)];
                [rightBtn setTitle:rightBtnString forState:UIControlStateNormal];
                [rightBtn setTitleColor:[self colorFromHexRGB:@"4DA1FF"] forState:UIControlStateNormal];
                rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
                rightBtn.tag = 1;
                [rightBtn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_alertView addSubview:rightBtn];
                
            }else{
                // 一个按钮的情况
                UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, alertHeight, AlertWidth, 50)];
                [leftBtn setTitle:leftBtnString forState:UIControlStateNormal];
                [leftBtn setTitleColor:[self colorFromHexRGB:@"4DA1FF"] forState:UIControlStateNormal];
                leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
                leftBtn.tag = 0;
                [leftBtn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_alertView addSubview:leftBtn];
                
            }
            
            alertHeight += 50;
        }
        _alertView.frame = CGRectMake(AlertWidth/2, 0, AlertWidth, alertHeight);
        _alertView.center = self.center;
        }
    
    return self;
}

- (void)alertBtnClicked:(UIButton *)btn
{
    if (self.alertBlock) {
        self.alertBlock(self, btn.tag);
    }
    [self dismiss];
}

- (void)show
{
    // 在主线程中处理,否则在viewDidLoad方法中直接调用,会先加本视图,后加控制器的视图到UIWindow上,导致本视图无法显示出来,这样处理后便会优先加控制器的视图到UIWindow上
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
        if (_alertView) {
            _alertView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            _alertView.alpha = 0.0f;
            [UIView animateWithDuration:0.6
                                  delay:0
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:0.3
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                _alertView.transform = CGAffineTransformMakeScale(1, 1);
                                _alertView.alpha = 1.0f;
                             }
                             completion:nil
             ];
        }
        
    }];
}

- (void)dismiss
{
//    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.backgroundView.alpha = 0.0f;
//        self.alertView.frame = CGRectMake(CGRectGetMinX(self.alertView.frame), self.frame.size.height, _alertView.frame.size.width,_alertView.frame.size.height);
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    [self removeFromSuperview];

}
- (void)dealloc
{
    NSLog(@"DLHAlert dealloc");
}

#pragma mark - 字体颜色
/*!
 * @method 通过16进制计算颜色
 * @result 颜色对象
 */
- (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    
    NSString *cString = [[inColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if (cString.length < 6)
    {
        return [UIColor blackColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length != 6)
    {
        return [UIColor blackColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //   OutLog(@"r=%f,g=%f,b=%f",(float)r,(float)g,(float)b);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
