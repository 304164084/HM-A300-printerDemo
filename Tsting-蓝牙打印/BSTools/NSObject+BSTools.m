//
//  NSObject+BSTools.m
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/27.
//  Copyright © 2019 banglin. All rights reserved.
//

#import "NSObject+BSTools.h"
#import "AppDelegate.h"

@implementation NSObject (BSTools)

#pragma mark - 跳转至蓝牙
+ (void)bs_pushToOpenBluetooth
{
    NSURL *ur = [NSURL URLWithString:@"App-Prefs:root=Bluetooth"];
    if ([[UIApplication sharedApplication]canOpenURL:ur]) {
        [[UIApplication sharedApplication] openURL:ur];
    }
}




@end
