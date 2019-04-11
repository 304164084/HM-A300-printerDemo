//
//  BSPrinterModelCPCL.m
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/29.
//  Copyright © 2019 banglin. All rights reserved.
//

#import "BSPrinterModelCPCL.h"
#import <PrinterSDK/PrinterSDK.h>

@implementation BSPrinterModelCPCL

// 1mm = 8 dots  if 80 * 60 则 640 * 480;
+ (NSData *)printModel80_60WithParameters:(NSDictionary *)param
                                   copies:(NSInteger)copies
{
    PTCommandCPCL *cmd = [[PTCommandCPCL alloc] init];

    // 开启上下文
    if (!(copies > 0)) {
        copies = 1;
    }
    [cmd cpclLabelWithOffset:0 hRes:PTCPCLLabelResolution200 vRes:PTCPCLLabelResolution200 height:480 quantity:copies];
    
    NSInteger space = 10;
    
    NSInteger startX = 40;
    NSInteger startY = 40;
    
    // title后的描述(description) x值
    NSInteger descriptionX = 260;
    
    // name 姓名
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont4 fontSize:0 x:startX y:startY text:param[@"name"]];
    // phone 电话号
    NSInteger y = startY + space; // 50
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont8 fontSize:0 x:180 y:y text:param[@"phone"]];
    
    // qr code 二维码
    [cmd cpclBarcodeQRcodeWithXPos:420 yPos:20 model:PTCPCLQRCodeModel1 unitWidth:PTCPCLQRCodeUnitWidth_6];
    [cmd cpclBarcodeQRCodeCorrectionLecel:(PTCPCLQRCodeCorrectionLevelH) characterMode:(PTCPCLQRCodeDataInputModeA) context:param[@"qr_code"]];
    [cmd cpclBarcodeQRcodeEnd];
    
    // company 公司
    y += 60; // 110
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont5 fontSize:0 x:startX y:y text:param[@"company"]];
    
    // horizonal line 水平线
    // line 1
    NSInteger line_StartX_Horizonal = 0;
    NSInteger line_EndX_Horizonal = 560;
    
    y += 120; // 230
    NSInteger line_StartY_Vertical = y; // 存储竖线起始点
    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:y xEnd:line_EndX_Horizonal yEnd:y thickness:2];
    
    // title 订单号
    y += space; // 240
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:startX y:y text:@"订单号"];
    // 订单号
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:descriptionX y:y text:param[@"order_id"]];
    
    // line 2
    y += 40; // 280
    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:y xEnd:line_EndX_Horizonal yEnd:y thickness:2];
    
    // title 款号
    y += space; // 290
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:startX y:y text:@"款号"];
    // 款号
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:descriptionX y:y text:param[@"style_number"]];
    
    // line 3
    y += 40; // 330
    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:y xEnd:line_EndX_Horizonal yEnd:y thickness:2];
    
    // title 配送方式
    y += space; // 340
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:startX y:y text:@"配送方式"];
    // 配送方式
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:descriptionX y:y text:param[@"delivery_type"]];
    
    // line 4
    y += 40; // 380
    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:y xEnd:line_EndX_Horizonal yEnd:y thickness:2];
    
    // title 跟单备注
    y += space; // 390
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:startX y:y text:@"跟单备注"];
    // 跟单备注
    [cmd cpclTextWithRotate:PTCPCLStyleRotation0 font:PTCPCLTextFont7 fontSize:0 x:descriptionX y:y text:param[@"remark"]];
    
    // line 5
    y += 40;
    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:y xEnd:line_EndX_Horizonal yEnd:y thickness:2];
    
    
    // vertical line 竖线
    NSInteger line_StartX_Vertical = 220;
    
    // line 1
    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:line_StartY_Vertical xEnd:line_StartX_Horizonal yEnd:y thickness:2];
    
    // line 2
    [cmd cpclLineWithXPos:line_StartX_Vertical yPos:line_StartY_Vertical xEnd:line_StartX_Vertical yEnd:y thickness:2];
    
    // line 3
    [cmd cpclLineWithXPos:line_EndX_Horizonal yPos:line_StartY_Vertical xEnd:line_EndX_Horizonal yEnd:y thickness:2];
    
    [cmd cpclPrint];
    
    return cmd.cmdData;
}

// MARK: 纸张 80 * 100 的打印模板
+ (NSData *)printModel80_100WithParameters:(NSDictionary *)param
                                    copies:(NSInteger)copies
{
    PTCommandCPCL *cmd = [[PTCommandCPCL alloc] init];
    // 开启上下文
    if (!(copies > 0)) {
        copies = 1;
    }
    [cmd cpclLabelWithOffset:0 hRes:PTCPCLLabelResolution200 vRes:PTCPCLLabelResolution200 height:800 quantity:copies];
    
    NSInteger space = 15;
    /** startX endX 是根据姓名文本的位置来确定的. ps: 可以理解为与打印机x轴方向相反 */
    NSInteger startX = 60;
    NSInteger endX = 80;
    /** y轴方向与打印机y轴相同 */
    NSInteger startY = 720;
    NSInteger endY = 20;
    
    // title后的描述(description) y值
    NSInteger descriptionY = 520;
    PTCPCLStyleRotation rotationStyle = PTCPCLStyleRotation90;
    // name 姓名
    [cmd cpclSetBold:1];
    [cmd cpclSetMagWithWidth:2 height:2];
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont4 fontSize:0 x:startX y:startY text:param[@"name"]];
    [cmd cpclSetMagWithWidth:1 height:1];
    [cmd cpclSetBold:0];
    // phone 电话号
    CGFloat x = startX + space * 2; // 80
    CGFloat y = startY - 220; // 540
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont8 fontSize:0 x:x y:y text:param[@"phone"]];
    // qr code 二维码
    [cmd cpclBarcodeVerticalQRcodeWithXPos:40 yPos:200 model:(PTCPCLQRCodeModel1) unitWidth:(PTCPCLQRCodeUnitWidth_7)];
    [cmd cpclBarcodeQRCodeCorrectionLecel:(PTCPCLQRCodeCorrectionLevelH) characterMode:(PTCPCLQRCodeDataInputModeA) context:param[@"qr_code"]];
    [cmd cpclBarcodeQRcodeEnd];
    // company 公司
    x += 60; // 140
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont5 fontSize:0 x:x y:startY text:param[@"company"]];
    
    /** 横线竖线概念与打印机横线竖线概念相反 */
    NSInteger line_StartX_Horizonal = x + 120; // 260
    NSInteger line_StartY_Vertical = 740; // 700
    
    // 横线 1
    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:line_StartY_Vertical xEnd:line_StartX_Horizonal yEnd:endY thickness:2];
    // title 订单号
    x = line_StartX_Horizonal + space; // 270
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"订单号"];
    // 订单号
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:param[@"order_id"]];
    
    // 横线 2
    x = x + 40; // 230
    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
    // title 款号
    x = x + space; // 220
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"款号"];
    // 款号
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:param[@"style_number"]];
    
    // 横线 3
    x = x + 40; // 180
    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
    // title 配送方式
    x = x + space; // 170
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"配送方式"];
    // 配送方式
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:param[@"delivery_type"]];
    
    // 横线 4
    x = x + 40; // 130
    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
    // title 跟单备注
    x = x + space; // 120
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"跟单备注"];
    // 跟单备注
    // 多行字符串截取, 截取最多 2 行
    NSString *remarkString = param[@"remark"];
    NSString *str1 = remarkString;
    NSString *str2 = nil;
    if (remarkString.length > 20) {
        str1 = [remarkString substringWithRange:NSMakeRange(0, 20)];
        str2 = [remarkString substringWithRange:NSMakeRange(20, remarkString.length -20)];
    }
    
    [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:str1];
    if (str2) {
        [cmd cpclTextWithRotate:rotationStyle font:PTCPCLTextFont7 fontSize:0 x:x + 40 y:descriptionY text:str2];
    }
    
    
 
    // 横线 5
    x = x + 40;
    if (str2) {
        x += 60;
    }
    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
    
    
    // 打印
    [cmd cpclPrint];
    
    return cmd.cmdData;
}

// MARK: 纸张 80 * 100 的打印模板
//+ (NSData *)printModel80_100WithParameters:(NSDictionary *)param
//                                    copies:(NSInteger)copies
//{
//    PTCommandCPCL *cmd = [[PTCommandCPCL alloc] init];
//
//    // 开启上下文
//    if (!(copies > 0)) {
//        copies = 1;
//    }
//    [cmd cpclLabelWithOffset:0 hRes:PTCPCLLabelResolution200 vRes:PTCPCLLabelResolution200 height:800 quantity:copies];
//
//    NSInteger space = 10;
//    /** startX endX 是根据姓名文本的位置来确定的. ps: 可以理解为与打印机x轴方向相反 */
//    NSInteger startX = 500;
//    NSInteger endX = 80;
//    /** y轴方向与打印机y轴相同 */
//    NSInteger startY = 40;
//    NSInteger endY = 740;
//
//    // title后的描述(description) y值
//    NSInteger descriptionY = 260;
//
//    // name 姓名
//    [cmd cpclSetBold:1];
//    [cmd cpclSetMagWithWidth:2 height:2];
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont4 fontSize:0 x:startX y:startY text:param[@"name"]];
//    [cmd cpclSetMagWithWidth:1 height:1];
//    [cmd cpclSetBold:0];
//    // phone 电话号
//    CGFloat x = startX - space; // 490
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont8 fontSize:0 x:x y:180 text:param[@"phone"]];
//    // qr code 二维码
//    [cmd cpclBarcodeVerticalQRcodeWithXPos:360 yPos:endY model:(PTCPCLQRCodeModel1) unitWidth:(PTCPCLQRCodeUnitWidth_7)];
//    [cmd cpclBarcodeQRCodeCorrectionLecel:(PTCPCLQRCodeCorrectionLevelH) characterMode:(PTCPCLQRCodeDataInputModeA) context:param[@"qr_code"]];
//    [cmd cpclBarcodeQRcodeEnd];
//    // company 公司
//    x = x - 60; // 430
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont5 fontSize:0 x:x y:startY text:param[@"company"]];
//
//    /** 横线竖线概念与打印机横线竖线概念相反 */
//    NSInteger line_StartX_Horizonal = x - 150; // 280
//    NSInteger line_StartY_Vertical = startY - 20; // 20
//    // 竖线 1
//    [cmd cpclLineWithXPos:endX yPos:line_StartY_Vertical xEnd:line_StartX_Horizonal yEnd:line_StartY_Vertical thickness:2];
//    // 竖线 2
//    [cmd cpclLineWithXPos:endX yPos:(line_StartY_Vertical + 200) xEnd:line_StartX_Horizonal yEnd:(line_StartY_Vertical + 200) thickness:2];
//    // 竖线 3
//    [cmd cpclLineWithXPos:endX yPos:endY xEnd:line_StartX_Horizonal yEnd:endY thickness:2];
//
//    // 横线 1
//    [cmd cpclLineWithXPos:line_StartX_Horizonal yPos:line_StartY_Vertical xEnd:line_StartX_Horizonal yEnd:endY thickness:2];
//    // title 订单号
//    x = line_StartX_Horizonal - space; // 270
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"订单号"];
//    // 订单号
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:param[@"order_id"]];
//
//    // 横线 2
//    x = x - 40; // 230
//    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
//    // title 款号
//    x = x - space; // 220
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"款号"];
//    // 款号
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:param[@"style_number"]];
//
//    // 横线 3
//    x = x - 40; // 180
//    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
//    // title 配送方式
//    x = x - space; // 170
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"配送方式"];
//    // 配送方式
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:param[@"delivery_type"]];
//
//    // 横线 4
//    x = x - 40; // 130
//    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
//    // title 跟单备注
//    x = x - space; // 120
//    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:startY text:@"跟单备注"];
//    // 跟单备注
//    // 多行字符串截取, 截取最多 2 行
//    NSString *remarkString = param[@"remark"];
//    NSString *str1 = remarkString;
//    NSString *str2 = nil;
//    if (remarkString.length > 20) {
//        str1 = [remarkString substringWithRange:NSMakeRange(0, 20)];
//        str2 = [remarkString substringWithRange:NSMakeRange(20, remarkString.length -20)];
//    }
//
//    //    [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY text:str1];
//    //    if (str2) {
//    //        [cmd cpclTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x - 40 y:descriptionY text:str2];
//    //    }
//    // 换行
//    [cmd cpclAutoTextWithRotate:PTCPCLStyleRotation270 font:PTCPCLTextFont7 fontSize:0 x:x y:descriptionY safeHeight:100 width:500 lineSpacing:8 text:@"测试代码测试代码测试代码测试代码测试代码测试代码测试代码测试代码测试代码测试代码测试代码测试代码"];
//
//    // 横线 5
//    x = x - 40;
//    [cmd cpclLineWithXPos:x yPos:line_StartY_Vertical xEnd:x yEnd:endY thickness:2];
//
//
//    // 打印
//    [cmd cpclPrint];
//
//    return cmd.cmdData;
//}

@end
