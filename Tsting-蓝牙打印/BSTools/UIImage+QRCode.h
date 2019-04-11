//
//  UIImage+QRCode.h
//  ModernAppliance
//
//  Created by Jim1024 on 16/7/8.
//  Copyright © 2016年 sunnsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

/// 根据内容生成二维码图片
+ (instancetype)qrCodeImageFromeContent:(NSString *)content;
 
@end
