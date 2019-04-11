//
//  UIViewController+BSTools.h
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/27.
//  Copyright © 2019 banglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BSTools)

/**
 返回当前显示的VC
 */
+ (UIViewController *)bs_fetchCurrentViewController;

@end

NS_ASSUME_NONNULL_END
