//
//  BSPrinterManager.h
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/27.
//  Copyright © 2019 banglin. All rights reserved.
//

#import <Foundation/Foundation.h>
// 汉印打印机 HM-A300系列
#import <PrinterSDK/PrinterSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSPrinterManager : NSObject

/** 检测蓝牙是否开启 /bluetooth status */
@property (nonatomic, assign, readonly) BOOL isOpenBluetooth;

+ (instancetype)sharedManager;


/**
 检测蓝牙是否开启
 */
//- (BOOL)isOpenBluetooth;

/**
 获取打印机

 @param block 已发现的打印机数组
 */
+ (void)fetchPrinter:(void (^)(NSMutableArray<PTPrinter *> *printerArray))block;

/**
 连接打印机
 获取连接状态

 @param printer 打印机
 @param completion YES 连接成功; NO 连接失败 error 失败的状态
 */
+ (void)connectPrinter:(PTPrinter *)printer completion:(void (^)(BOOL success, PTConnectError error))completion;

/**
 断开连接
 */
+ (void)disconnectPrinter;


#pragma mark - 数据发送相关
/**
 发送数据

 @param data 二进制数据
 @param completion 完成回调. success YES 发送成功; NO 发送失败
 */
+ (void)sendData:(NSData *)data completion:(void (^)(BOOL success, NSNumber *_Nullable number))completion;

@end

NS_ASSUME_NONNULL_END
