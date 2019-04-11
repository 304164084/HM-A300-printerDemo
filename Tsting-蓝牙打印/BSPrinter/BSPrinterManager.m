//
//  BSPrinterManager.m
//  Tsting-蓝牙打印
//
//  Created by banglin_sui on 2019/3/27.
//  Copyright © 2019 banglin. All rights reserved.
//

#import "BSPrinterManager.h"

#pragma mark - 全局静态变量
static PTDispatcher *_dispatcher = nil;
typedef void (^BSblueToothStatusBlock)(BOOL isOpening);

@interface BSPrinterManager ()<CBCentralManagerDelegate>

@property (nonatomic, assign) BOOL isOpenBluetooth;
/** 蓝牙设备数组 */
@property (nonatomic, strong) NSArray *bluetooths;
/** central manager */
@property (nonatomic, strong) CBCentralManager *centralManager;
/** 信号量 */
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
/** 蓝牙状态block */
@property (nonatomic, copy) BSblueToothStatusBlock blueToothBlock;

@end

@implementation BSPrinterManager

#pragma mark - 初始化
static BSPrinterManager *manager_ = nil;
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager_ = [[[self class] alloc] init];
    });
    return manager_;
}


// MARK: override init
- (instancetype)init
{
    if (self = [super init]) {
        _dispatcher = [PTDispatcher share];
        
        // 开启蓝牙中心
//        [_dispatcher centralManager];
//        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//        
//        _semaphore = dispatch_semaphore_create(0);
    }
    
    return self;
}
#pragma mark - 蓝牙外设连接相关
#pragma mark 查看是否开启蓝牙
//- (BOOL)isOpenBluetooth
//{
//    // FIXME: 调用'isOpenBluetooth' 时, 可能会获取不到正确的状态. sdk 的坑
//    BOOL result = [_dispatcher getBluetoothStatus];
//
//    return result;
//}

//- (BOOL)isOpenBluetooth
//{
////    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"isOpen current thread: %@", [NSThread currentThread]);
//
//    __block BOOL result = NO;
//    __weak typeof(self)weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        weakSelf.blueToothBlock = ^(BOOL isOpening) {
//            __strong typeof(weakSelf)strongSelf = weakSelf;
//            result = strongSelf->_isOpenBluetooth;
//
//            dispatch_semaphore_signal(self.semaphore);
//        };
//    });
//    dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, 1.f));
//    if ([self respondsToSelector:@selector(setIsOpenBluetooth:)]) {
//        result = _isOpenBluetooth;
//        dispatch_semaphore_signal(self.semaphore);
//    }
//    dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, 5.f));
//    return result;
//}

// 实时监测蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"central.state: %ld, currentThread: %@", central.state, [NSThread currentThread]);
    
    if (central.state == CBManagerStatePoweredOn) {
        self.isOpenBluetooth = YES;
    } else {
        self.isOpenBluetooth = NO;
    }
    
    //
//    if (self.blueToothBlock) {
//        self.blueToothBlock(self.isOpenBluetooth);
//    }
}

#pragma mark 搜索并发现蓝牙外设
+ (void)fetchPrinter:(void (^)(NSMutableArray<PTPrinter *> *printerArray))block
{
    // 扫描蓝牙
    [_dispatcher scanBluetooth];
    
//    __weak typeof(self)weakSelf = self;
    // 过滤
    [_dispatcher setupPeripheralFilter:^BOOL(CBPeripheral *peripheral, NSDictionary<NSString *,id> *advertisementData, NSNumber *RSSI) {
        // 过滤无名字(null) & 不含有'HM' 的外设
        if (!peripheral.name || ![peripheral.name containsString:@"HM"]) {
            return NO;
        }

        id connectable = advertisementData[@"kCBAdvDataIsConnectable"];
        // 过滤无法连接的外设(connectable == 0)
        if ([connectable isKindOfClass:[NSNumber class]] && [connectable boolValue] == 1) {
            return YES;
        }
        
        return YES;
    }];
    
    // 发现蓝牙设备
    [_dispatcher whenFindAllBluetooth:^(NSMutableArray<PTPrinter *> *printerArray) {
        manager_.bluetooths = printerArray;
        
        if (block) {
            block(printerArray);
        }
    }];
}

#pragma mark 停止搜索
+ (void)stopScanBluetooth
{
    [_dispatcher stopScanBluetooth];
}

#pragma mark 连接蓝牙打印机
+ (void)connectPrinter:(PTPrinter *)printer completion:(void (^)(BOOL success, PTConnectError error))completion
{
    // 连接外设
    [_dispatcher connectPrinter:printer];
    
    // 当断开蓝⽛时，下列列获取相关状态的⽅方法失效(Block 被置空)，下⼀一次连接时，必须重新执⾏行下列列⽅方法
    if (![manager_ isOpenBluetooth]) {
        return;
    }
    // 检测连接状态
    [_dispatcher whenConnectSuccess:^{ // success
        if (completion) {
            // error == -1 意为：正常无错误
            completion(YES, -1);
        }
    }];
    
    [_dispatcher whenConnectFailureWithErrorBlock:^(PTConnectError error) {
        if (completion) {
            completion(NO, error);
        }
    }];
}

#pragma mark 断开连接
+ (void)disconnectPrinter
{
    [_dispatcher unconnectPrinter:_dispatcher.printerConnected];
}

#pragma mark - 打印相关
#pragma mark 发送数据
+ (void)sendData:(NSData *)data completion:(void (^)(BOOL success, NSNumber *_Nullable number))completion
{
    // 发送
    [_dispatcher sendData:data];
    
    // 成功
    [_dispatcher whenSendSuccess:^(NSNumber *number) {
        if (completion) {
            completion(YES, number);
        }
    }];
    
    // 失败
    [_dispatcher whenSendFailure:^{
        if (completion) {
            completion(NO, nil);
        }
    }];
    
    // 打印状态改变
    [_dispatcher whenUpdatePrintState:^(PTPrintState state) {
        NSLog(@"打印状态改变: %ld", state);
    }];
}

#pragma mark - lazy load (setter)
- (NSArray *)bluetooths
{
    if (!_bluetooths) {
        _bluetooths = [NSArray array];
    }
    return _bluetooths;
}

@end
