//
//  UIViewController+BSTools.m
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/27.
//  Copyright © 2019 banglin. All rights reserved.
//

#import "UIViewController+BSTools.h"

@implementation UIViewController (BSTools)

#pragma mark - 获取当前显示的VC
+ (UIViewController *)bs_fetchCurrentViewController
{
    UIResponder *next = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            break;
        }
        next = next.nextResponder;
    }
    
    return (UIViewController *)next;
}

@end
