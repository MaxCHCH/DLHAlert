//
//  DLHAlert.h
//  EakayDriver
//
//  Created by DuanLihang on 2018/3/19.
//  Copyright © 2018年 Duan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DLHAlert;
/*
 block 回调 alert本身 index 左0  右1
 
 */
typedef void (^DLHAlertBlock)(DLHAlert *alert,NSInteger index);


@interface DLHAlert : UIView


/**
 * 创建DLHAlert对象
 *
 * @param title                  标题
 * @param leftBtnString          左边按钮文本
 * @param contentString          提示文本
 * @param rightBtnString         右边按钮文本
 * @param alertBlock             block回调
 *
 * @return LPActionSheet对象
 */


- (instancetype)initWithTitle:(NSString *)title
            leftBtnString:(NSString *)leftBtnString
            contentString:(NSString *)contentString
            rightBtnString:(NSString *)rightBtnString
            handler:(DLHAlertBlock)alertBlock NS_DESIGNATED_INITIALIZER;
- (void)show;
/**
 * 收起视图
 */
- (void)dismiss;
@end
