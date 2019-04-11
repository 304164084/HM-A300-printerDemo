//
//  BSPrintView.m
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/28.
//  Copyright © 2019 banglin. All rights reserved.
//

#import "BSPrintView.h"

@interface BSPrintView ()

/** name */
@property (nonatomic, strong) UILabel *nameLabel;
/** phone  */
@property (nonatomic, strong) UILabel *phoneLabel;
/** company */
@property (nonatomic, strong) UILabel *companyLabel;
/** qrcode */
@property (nonatomic, strong) UIImageView *qrCodeImageView;
/** title 订单号 */
@property (nonatomic, strong) UILabel *titleOrderLabel;
/** order number */
@property (nonatomic, strong) UILabel *orderLabel;
/** title 款号 */
@property (nonatomic, strong) UILabel *titleStyleLabel;
/** 款号 */
@property (nonatomic, strong) UILabel *styleLabel;
/** title 配送方式 */
@property (nonatomic, strong) UILabel *titleDeliveryLabel;
/** 配送 */
@property (nonatomic, strong) UILabel *deliveryLabel;
/** title 跟单备注 */
@property (nonatomic, strong) UILabel *titleDocumentaryLabel;
/** 跟单备注 */
@property (nonatomic, strong) UILabel *documentaryLabel;

@end

@implementation BSPrintView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    
}


@end
