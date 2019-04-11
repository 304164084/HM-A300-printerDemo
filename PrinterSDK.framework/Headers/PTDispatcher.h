/*!
 *  \~chinese
 *  @header     PTDispatcher.h
 *  @abstract   通讯协议
 *
 *  \~english
 *  @header     PTDispatcher.h
 *  @abstract   Protocol
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SDKDefine.h"
#import "PTPrinter.h"

/*!
 *  \~chinese
 *  连接模式
 *
 *  \~english
 *  Connect Mode
 */
typedef NS_ENUM(NSInteger, PTDispatchMode) {
    
    PTDispatchModeUnconnect  = 0,  /*! *\~chinese 未知类型 *\~english Unknown */
    PTDispatchModeBLE        = 1,  /*! *\~chinese 蓝牙 *\~english BLE */
    PTDispatchModeWiFi       = 2,  /*! *\~chinese 无线 *\~english WiFi */
};

/*!
 *  \~chinese
 *  打印完成后打印机返回的状态
 *
 *  \~english
 *  Printer Status
 */
typedef NS_ENUM(NSInteger, PTPrintState) {
    
    PTPrintStateSuccess             = 0xcc00,   /*! *\~chinese 打印成功 *\~english Print success */
    PTPrintStateFailurePaperEmpty   = 0xcc01,   /*! *\~chinese 打印失败（缺纸） *\~english Print failure (paper out) */
    PTPrintStateFailureLidOpen      = 0xcc02,   /*! *\~chinese 打印失败（开盖） *\~english Print failure (cover open) */
};

/*!
 *  \~chinese
 *  返回连接的错误类型
 *
 *  \~english
 *  Connect error
 */
typedef NS_ENUM(NSInteger, PTConnectError) {
    
    PTConnectErrorBleTimeout                  = 0,  /*! *\~chinese 连接超时 *\~english Connect timeout */
    PTConnectErrorBleDisvocerServiceTimeout   = 1,  /*! *\~chinese 获取服务超时 *\~english Disvocer Service timeout */
    PTConnectErrorBleValidateTimeout          = 2,  /*! *\~chinese 验证超时 *\~english Validation timeout */
    PTConnectErrorBleUnknownDevice            = 3,  /*! *\~chinese 未知设备 *\~english Unkown device */
    PTConnectErrorBleSystem                   = 4,  /*! *\~chinese 系统错误,由coreBluetooth框架返回 *\~english System error, returned by coreBluetooth */
    PTConnectErrorBleValidateFail             = 5,  /*! *\~chinese 验证失败 *\~english Validation failure */
    PTConnectErrorWifiTimeout                 = 6,  /*! *\~chinese 无线连接超时 *\~english Wifi connect time out */
    PTConnectErrorWifiSocketError             = 7,  /*! *\~chinese socket错误 *\~english Socket error */
};

@class PTPrinter;

/*!
 *  \~chinese
 *  蓝牙扫描时返回单个外设的block
 *
 *  \~english
 *  Return to a single peripheral when scanning by Bluetooth
 */
typedef void(^PTPrinterParameterBlock)(PTPrinter *printer);

/*!
 *  \~chinese
 *  返回的外设数组
 *
 *  \~english
 *  Return peripheral array
 */
typedef void(^PTPrinterMutableArrayBlock)(NSMutableArray<PTPrinter *> *printerArray);

/*!
 *  \~chinese
 *  返回无参数的Block
 *
 *  \~english
 *  Return a block with no parameters
 */
typedef void(^PTEmptyParameterBlock)();

/*!
 *  \~chinese
 *  连接错误的Block
 *
 *  \~english
 *  Return the wrong connection block
 */
typedef void(^PTBluetoothConnectFailBlock)(PTConnectError error);

/*!
 *  \~chinese
 *  返回NSNumber类型的Block
 *
 *  \~english
 *  Returns a block of type NSNumber
 */
typedef void(^PTNumberParameterBlock)(NSNumber *number);

/*!
 *  \~chinese
 *  接收外设数据的Block
 *
 *  \~english
 *  Block that receives peripheral data
 */
typedef void(^PTDataParameterBlock)(NSData *data);

/*!
 *  \~chinese
 *  打印完成状态的Block
 *
 *  \~english
 *  Returns the block with the print completion status
 */
typedef void(^PTPrintStateBlock)(PTPrintState state);

/*!
 *  \~chinese
 *  过滤外设的Block
 *
 *  \~english
 *  Filter the peripheral's block
 */
typedef BOOL(^PTPeripheralFilterBlock)(CBPeripheral *peripheral, NSDictionary<NSString *,id> *advertisementData, NSNumber *RSSI);

/*!
 *  \~chinese
 *  外设断开后返回带连接时间、是否主动断开参数的Block
 *
 *  \~english
 *  After the peripheral is disconnected, return the block with the connection time and whether to actively disconnect the parameter.
 */
typedef void(^PTUnconnectBlock)(NSNumber *number, BOOL isActive);


@interface PTDispatcher : NSObject

+ (instancetype)share;

/*!
 *  \~chinese
 *  连接成功后的打印机属性类
 *
 *  \~english
 *  Printer property after connect success
 */
@property (strong, nonatomic, readwrite) PTPrinter                    *printerConnected;

/*!
 *  \~chinese
 *  连接方式
 *
 *  \~english
 *  Connect style
 */
@property (assign, nonatomic) PTDispatchMode                         mode;

/*!
 *  \~chinese
 *  蓝牙中心
 *
 *  \~english
 *  Ble central
 */
@property (weak, nonatomic, readonly) CBCentralManager*             centralManager;

/*!
 *  \~chinese
 *  数据发送成功
 *
 *  \~english
 *  Send data success
 */
@property (copy, nonatomic, readwrite) PTNumberParameterBlock         sendSuccessBlock;

/*!
 *  \~chinese
 *  数据发送失败
 *
 *  \~english
 *  Send data fail
 */
@property (copy, nonatomic, readwrite) PTEmptyParameterBlock          sendFailureBlock;

/*!
 *  \~chinese
 *  发送数据的进度条
 *
 *  \~english
 *  Send progress
 */
@property (copy, nonatomic, readwrite) PTNumberParameterBlock         sendProgressBlock;

/*!
 *  \~chinese
 *  接收外设返回的数据
 *
 *  \~english
 *  ReceiveDara
 */
@property (copy, nonatomic, readwrite) PTDataParameterBlock           receiveDataBlock;

/*!
 *  \~chinese
 *  打印完成后返回的状态
 *
 *  \~english
 *  PrintStatus
 */
@property (copy, nonatomic, readwrite) PTPrintStateBlock              printStateBlock;

/*!
 *  \~chinese
 *  发现外设
 *
 *  \~english
 *  FindDevice
 */
@property (copy, nonatomic, readwrite) PTPrinterParameterBlock        findBluetoothBlock;

/*!
 *  \~chinese
 *  发现所有的外设
 *
 *  \~english
 *  FindAllDevice
 */
@property (copy, nonatomic, readwrite) PTPrinterMutableArrayBlock     findAllPeripheralBlock;

/*!
 *  \~chinese
 *  连接成功
 *
 *  \~english
 *  Connect success
 */
@property (copy, nonatomic, readwrite) PTEmptyParameterBlock          connectSuccessBlock;

/*!
 *  \~chinese
 *  连接失败
 *
 *  \~english
 *  Connect fail
 */
@property (copy, nonatomic, readwrite) PTBluetoothConnectFailBlock    connectFailBlock;

/*!
 *  \~chinese
 *  断开连接
 *
 *  \~english
 *  unconnect
 */
@property (copy, nonatomic, readwrite) PTUnconnectBlock               unconnectBlock;

/*!
 *  \~chinese
 *  外设的信号强度
 *
 *  \~english
 *  Rssi
 */
@property (copy, nonatomic, readwrite) PTNumberParameterBlock         readRSSIBlock;

/*!
 *  \~chinese
 *  外设过滤器
 *
 *  \~english
 *  Peripheral filter
 */
@property (copy, nonatomic, readwrite) PTPeripheralFilterBlock        peripheralFilterBlock;


/*!
 *  \~chinese
 *  发送数据
 *
 *  @param data  发送的数据
 *
 *  \~english
 *  Send data
 *
 *  @param data Send data
 */
- (void)sendData:(NSData *)data;

/*!
 *  \~chinese
 *  开始扫描蓝牙
 *
 *  \~english
 *  Start scanning Bluetooth
 */
- (void)scanBluetooth;

/*!
 *  \~chinese
 *  停止扫描蓝牙，连接成功后SDK会自动停止扫描
 *
 *  \~english
 *  Stop scanning Bluetooth，The SDK will automatically stop scanning after the connection is successful.
 */
- (void)stopScanBluetooth;

/*!
 *  \~chinese
 *  扫描Wi-Fi
 *
 *  @param wifiAllBlock  扫描到的外设数组
 *
 *  \~english
 *  Scan Wi-Fi
 *
 *  @param wifiAllBlock  Scanned peripheral array
 */
- (void)scanWiFi:(PTPrinterMutableArrayBlock)wifiAllBlock;

/*!
 *  \~chinese
 *  获取已发现的所有打印机，每新发现新的打印机或隔三秒调用一次
 *
 *  @param bluetoothBlock  外设数组
 *
 *  \~english
 *  Get all the printers found, trigger once when finding new printer or trigger once every 3 seconds
 *
 *  @param bluetoothBlock  Scanned peripheral array
 */
- (void)whenFindAllBluetooth:(PTPrinterMutableArrayBlock)bluetoothBlock;

/*!
 *  \~chinese
 *  发现蓝牙回调，coreBlueTooth框架每发现一台打印机就会调用
 *
 *  @param bluetoothBlock  参数为发现的打印机对象
 *
 *  \~english
 *  Trigger this method when finding Bluetooth, coreBlueTooth will trigger it when finding one printer
 *
 *  @param bluetoothBlock  The parameter is the discovered printer object
 */
- (void)whenFindBluetooth:(PTPrinterParameterBlock)bluetoothBlock;

/*!
 *  \~chinese
 *  连接设备更新RSSI回调
 *
 *  @param readRSSIBlock  参数是型号强度
 *
 *  \~english
 *  Trigger this method when connecting new device to update RSSI
 *
 *  @param readRSSIBlock  Trigger block, parameter is the signal strength of connecting printer
 */
- (void)whenReadRSSI:(PTNumberParameterBlock)readRSSIBlock;

/*!
 *  \~chinese
 *  连接打印机
 *
 *  @param printer      要连接的打印机
 *
 *  \~english
 *  Connect printer
 *
 *  @param printer      Connected printer
 */
- (void)connectPrinter:(PTPrinter *)printer;

/*!
 *  \~chinese
 *  断开打印机连接
 *
 *  @param printer  要断开的打印机
 *
 *  \~english
 *  Disconnect printer
 *
 *  @param printer  Unconnect printer
 */
- (void)unconnectPrinter:(PTPrinter *)printer;

/*!
 *  \~chinese
 *  连接成功回调
 *
 *  @param connectSuccessBlock  连接成功的回调
 *
 *  \~english
 *  Trigger this method when connecting successfully
 *
 *  @param connectSuccessBlock  Trigger block
 */
- (void)whenConnectSuccess:(PTEmptyParameterBlock)connectSuccessBlock;

/*!
 *  \~chinese
 *  连接失败的回调
 *
 *  @param connectFailBlock  连接失败返回的错误类型
 *
 *  \~english
 *  When connect error is occurred
 *
 *  @param connectFailBlock  block block with connect error parameter
 */
- (void)whenConnectFailureWithErrorBlock:(PTBluetoothConnectFailBlock)connectFailBlock;

/*!
 *  \~chinese
 *  断开连接的回调
 *
 *  @param unconnectBlock  回调的Block
 *
 *  \~english
 *  Trigger this method when disconnecting
 *
 *  @param unconnectBlock  Trigger block
 */
- (void)whenUnconnect:(PTUnconnectBlock)unconnectBlock;

/*!
 *  \~chinese
 *  数据发送成功的回调
 *
 *  @param sendSuccessBlock  回调block
 *
 *  \~english
 *  Callback for successful data transmission
 *
 *  @param sendSuccessBlock  Trigger block
 */
- (void)whenSendSuccess:(PTNumberParameterBlock)sendSuccessBlock;

/*!
 *  \~chinese
 *  数据发送失败的回调
 *
 *  @param sendFailureBlock  回调block
 *
 *  \~english
 *  Data send failure
 *
 *  @param sendFailureBlock  Trigger block
 */
- (void)whenSendFailure:(PTEmptyParameterBlock)sendFailureBlock;

/*!
 *  \~chinese
 *  数据发送进度的回调
 *
 *  @param sendProgressBlock  回调block
 *
 *  \~english
 *  Callback of data transmission progress
 *
 *  @param sendProgressBlock  Trigger block
 */
- (void)whenSendProgressUpdate:(PTNumberParameterBlock)sendProgressBlock;

/*!
 *  \~chinese
 *  接收到数据回调
 *
 *  @param receiveDataBlock  回调block
 *
 *  \~english
 *  Received data callback
 *
 *  @param receiveDataBlock  Trigger block
 */
- (void)whenReceiveData:(PTDataParameterBlock)receiveDataBlock;

/*!
 *  \~chinese
 *  接收到打印机打印状态回调, 针对CPCL ESC指令
 *
 *  @param printStateBlock  回调block
 *
 *  \~english
 *  Trigger this method when receiving print state ,For CPCL and ESC instructions
 *
 *  @param printStateBlock  Trigger block
 */
- (void)whenUpdatePrintState:(PTPrintStateBlock)printStateBlock;

/*!
 *  \~chinese
 *  手机的蓝牙是否打开，需要先初始化蓝牙中心实例,YES:打开，NO:关闭
 *
 *  @return 状态
 *
 *  \~english
 *  Whether the Bluetooth of the mobile phone is turned on, you need to initialize the Bluetooth center instance first.,YES:open  NO:close
 *
 *  @return status
 */
- (BOOL)getBluetoothStatus;

/*!
 *  \~chinese
 *  设置蓝牙连接超时时间
 *
 *  @param timeout  超时时间，单位秒
 *
 *  \~english
 *  Set the time of Bluetooth timeout
 *
 *  @param timeout  timeout,unit is second
 */
- (void)setupBleConnectTimeout:(double)timeout;

/*!
 *  \~chinese
 *  设置外设过滤block
 *
 *  @param block  回调block
 *
 *  \~english
 *  Set peripheral filter block
 *
 *  @param block  Trigger block
 */
- (void)setupPeripheralFilter:(PTPeripheralFilterBlock)block;

/*!
 *  \~chinese
 *  设置SDK中心
 *
 *
 *  @param manager         中心
 *  @param delegate        接收中心代理消息的对象
 *
 *  \~english
 *  Set the SDK Center
 *
 *  @param manager         Center
 *  @param delegate        The object that receives the central proxy message
 *
 */
- (void)registerCentralManager:(CBCentralManager *)manager delegate:(id<CBCentralManagerDelegate>)delegate;

/*!
 *  \~chinese
 *  注销代理
 *
 *  \~english
 *  unregister Delegate
 *
 */
- (void)unregisterDelegate;

/*!
 *  \~chinese
 *  SDK版本
 *
 *  @return SDK版本
 *
 *  \~english
 *  SDK version
 *
 *  @return SDK version
 */
- (NSString *)SDKVersion;

/*!
 *  \~chinese
 *  SDK打包时间
 *
 *  @return SDK打包时间
 *
 *  \~english
 *  SDK build time
 *
 *  @return SDK build time
 */
- (NSString *)SDKBuildTime;

/*!
 *  \~chinese
 *  SDK描述
 *
 *  @return SDK描述
 *
 *  \~english
 *  SDK description
 *
 *  @return SDK description
 */
- (NSString *)SDKDescription;

@end
