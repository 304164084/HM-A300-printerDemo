//
//  BSSecondViewController.m
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/28.
//  Copyright © 2019 banglin. All rights reserved.
//

#import "BSSecondViewController.h"
#import "BSPrintView.h"

#import "BSPrinter/BSPrinterManager.h"


@interface BSSecondViewController ()

/** view */
@property (nonatomic, weak) UIView *drawView;
/** img View */
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation BSSecondViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setupViews
{
    UINib *nib = [UINib nibWithNibName:@"BSPrintView" bundle:[NSBundle mainBundle]];
    UIView *view = [[nib instantiateWithOwner:nil options:nil] firstObject];
    
    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
    view.frame = CGRectMake(0, 100, kScreenWidth, 300);
    
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    self.drawView = view;
    
    self.imgView = [UIImageView new];
    self.imgView.frame = CGRectMake(0, 400, kScreenWidth, 300);
//    self.imgView.contentMode = UIViewContentModeScaleToFill;
    self.imgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.imgView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // CGSizeMake(80, 100)
    // CGSizeMake(self.drawView.bounds.size.width * 0.5, self.drawView.bounds.size.height * 0.5)
    UIImage *logo = [self makeImageWithView:self.drawView withSize:self.drawView.bounds.size];
    

    self.imgView.image = logo;
    
    PTCommandCPCL *cmd = [[PTCommandCPCL alloc] init];
    [cmd cpclLabelWithOffset:0 hRes:PTCPCLLabelResolution200 vRes:PTCPCLLabelResolution200 height:logo.size.height quantity:1];
    [cmd cpclPrintBitmapWithXPos:0 YPos:0 image:logo.CGImage bitmapMode:PTBitmapModeBinary compress:PTBitmapCompressModeNone];
    [cmd cpclPrint];
    
    [BSPrinterManager sendData:cmd.cmdData completion:^(BOOL success, NSNumber * _Nullable number) {
        
    }];
    
}


#pragma mark - 将View 绘制为图片
#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}






@end
