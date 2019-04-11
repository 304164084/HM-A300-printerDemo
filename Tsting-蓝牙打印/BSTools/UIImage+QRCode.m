//
//  UIImage+QRCode.m
//  ModernAppliance
//
//  Created by Jim1024 on 16/7/8.
//  Copyright © 2016年 sunnsoft. All rights reserved.
//

#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

/// 根据内容生成二维码图片
+ (instancetype)qrCodeImageFromeContent:(NSString *)content {
    // 创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *input = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:input forKey:@"inputMessage"];
    // 获取滤镜输出的图片
    CIImage *ciImage = filter.outputImage;
    // 对图片进行形变放大
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    return image;
}

@end
