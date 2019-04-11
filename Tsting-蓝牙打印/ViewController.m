//
//  ViewController.m
//  Tsting-蓝牙打印
//
//  Created by temp on 2019/3/27.
//  Copyright © 2019 banglin. All rights reserved.
//

#import "ViewController.h"
#import "BSSecondViewController.h"

#import "BSPrinter/BSPrinterManager.h"
//#import "PTTestCPCLSlim.h"
#import "BSPrinter/BSPrinterModelCPCL.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** data sourece */
@property (nonatomic, strong) NSArray<PTPrinter *> *dataSource;

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupViews];
    [self rightButton];
    [self leftButton];
}

- (void)leftButton
{
    // 1
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setTitle:@"PushToNext" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionPush) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:btn]];
}

- (void)rightButton
{
    // 1
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setTitle:@"断开连接" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionUnconnect:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 sizeToFit];
    [btn2 setTitle:@"发送数据" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(actionSendData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:btn], [[UIBarButtonItem alloc] initWithCustomView:btn2]];
}

- (void)actionUnconnect:(UIButton *)button
{
    [BSPrinterManager disconnectPrinter];
}

- (void)actionSendData:(UIButton *)button
{
    [BSPrinterManager sendData:[BSPrinterModelCPCL printModel80_100WithParameters:@{
                                                                                @"name" : @"胡汉三",
                                                                                @"phone" : @"18512341234",
                                                                                @"qr_code" : @"123123123",
                                                                                @"company" : @"广州市采购商有限公司",
                                                                                @"order_id" : @"id2019302910001",
                                                                                @"style_number" : @"510",
                                                                                @"delivery_type" : @"1",
                                                                                @"remark" : @"测试是否可以换行 换了吗，嗯嗯嗯嗯！换了吗？下班了吗 下班了？"
                                                                                } copies:1] completion:^(BOOL success, NSNumber * _Nullable number) {
        NSLog(@"数据是否发送成功: %d %@", success, number);
    }];
}

- (void)actionPush
{
    BSSecondViewController *vc = [[BSSecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setup views
- (void)setupViews
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    BSPrinterManager *manager = [BSPrinterManager sharedManager];
    
    BOOL result = manager.isOpenBluetooth;
    if (!result) {
        NSLog(@"未开启蓝牙");
//        return;
    };
    
    [BSPrinterManager fetchPrinter:^(NSMutableArray<PTPrinter *> * _Nonnull printerArray) {
        self.dataSource = printerArray;
        [self.tableView reloadData];
    }];
    
}

#pragma mark - dataSource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    PTPrinter *printer = self.dataSource[indexPath.row];
    cell.textLabel.text = printer.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PTPrinter *printer = self.dataSource[indexPath.row];
    
    [BSPrinterManager connectPrinter:printer completion:^(BOOL success, PTConnectError error) {
        NSLog(@"result: %ld     error: %ld", success, error);
    }];
}


@end
