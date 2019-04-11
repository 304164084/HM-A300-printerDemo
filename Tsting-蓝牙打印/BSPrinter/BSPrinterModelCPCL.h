//
//  BSPrinterModelCPCL.h
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/29.
//  Copyright © 2019 banglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSPrinterModelCPCL : NSObject

/**
 打印 80 * 100 的模板
 
 @param param \ use map temp, after can use model.
 e.g.
 @{
 @"name"            : @"胡汉三",
 @"phone"           : @"18512341234",
 @"qr_code"         : @"123123123",
 @"company"         : @"广州市采购商有限公司",
 @"order_id"        : @"id2019302910001",
 @"style_number"    : @"510",
 @"delivery_type"   : @"1",
 @"remark"          : @"description"
 }
 
 @param copies 份数 > 0 default 1.
 
 @return data
 */
+ (NSData *)printModel80_100WithParameters:(NSDictionary *)param
                                    copies:(NSInteger)copies;
+ (NSData *)printModel80_60WithParameters:(NSDictionary *)param

                                   copies:(NSInteger)copies;

@end

NS_ASSUME_NONNULL_END
