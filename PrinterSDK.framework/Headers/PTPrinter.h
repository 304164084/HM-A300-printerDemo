/*!
 *  \~chinese
 *  @header     PTPrinter.h
 *  @abstract   打印机属性
 *
 *  \~english
 *  @header     PTPrinter.h
 *  @abstract   Printer properties
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PTRouter.h"

/*!
 *  \~chinese
 *  打印机配备哪些模块
 *
 *  \~english
 *  Which modules that the current printer equipped
 */
typedef NS_ENUM(NSInteger, PTPrinterModule) {
    
    PTPrinterModuleUnknown    = 0,  /*! *\~chinese 未知类型 *\~english Unknown */
    PTPrinterModuleBLE        = 1,  /*! *\~chinese 蓝牙 *\~english BLE */
    PTPrinterModuleWiFi       = 2,  /*! *\~chinese 无线 *\~english WiFi */
    PTPrinterModuleBoth       = 3,  /*! *\~chinese 蓝牙和无线 *\~english Ble and wifi */
};

/*!
 *  \~chinese
 *  打印机支持的指令
 *
 *  \~english
 *  Printer supported commands
 */
typedef NS_ENUM(NSInteger, PTCommandMode) {
    
    PTCommandModeUnselected = -1,   /*! *\~chinese 未知类型 *\~english Unknown */
    PTCommandModeESC        = 0,    /*! *\~chinese ESC指令 *\~english ESC command */
    PTCommandModeTSPL       = 1,    /*! *\~chinese TSPL指令 *\~english TSPL command */
    PTCommandModeCPCL       = 2,    /*! *\~chinese CPCL指令 *\~english CPCL command */
    PTCommandModeDPL        = 3,    /*! *\~chinese DPL指令 *\~english DPL command */
    PTCommandModeEPL        = 4,    /*! *\~chinese CPL指令 *\~english EPL command */
    PTCommandModeZPL        = 5,    /*! *\~chinese ZPL指令 *\~english ZPL command */
    PTCommandModeSTAR       = 6,    /*! *\~chinese STAR指令 *\~english STAR command */
};

/*!
 *  \~chinese
 *  打印机厂商
 *
 *  \~english
 *  Printer supplier
 */
typedef NS_ENUM(NSInteger, PTPrinterVender) {
    PTPrinterVenderUnknown = -1,    /*! *\~chinese 未知类型 *\~english Unknown */
    PTPrinterVenderHY = 0,          /*! *\~chinese HY *\~english HY */
    PTPrinterVenderSTAR = 1,        /*! *\~chinese STAR *\~english STAR */
};

/*!
 *  \~chinese
 *  打印机蓝牙模块
 *
 *  \~english
 *  Printer Bluetooth module
 */
typedef NS_ENUM(NSInteger, PTBluetoothVender) {
    PTBluetoothVenderUnknown = -1,  /*! *\~chinese 未知类型 *\~english Unknown */
    PTBluetoothVenderISSC = 0,      /*! *\~chinese ISSC *\~english ISSC */
    PTBluetoothVenderIVT = 1,       /*! *\~chinese IVT *\~english IVT */
    PTBluetoothVenderMB = 2,        /*! *\~chinese 喵宝 *\~english MB */
};

@interface PTPrinter : NSObject<NSCoding>

/*!
 *  \~chinese
 *  打印机名称
 *
 *  \~english
 *  Printer name
 */
@property(strong,nonatomic,readwrite) NSString *name;

/*!
 *  \~chinese
 *  打印机mac地址
 *
 *  \~english
 *  Printer mac address
 */
@property(strong,nonatomic,readwrite) NSString *mac;

/*!
 *  \~chinese
 *  打印机Mac地址字符串前6位
 *
 *  \~english
 *  Former 6 numbers of printer Mac address character string
 */
@property(strong,nonatomic,readwrite) NSString *macKey;

/*!
 *  \~chinese
 *  打印机蓝牙模块
 *
 *  \~english
 *  Printer Bluetooth module
 */
@property(assign,nonatomic,readwrite) PTPrinterModule module;

/*!
 *  \~chinese
 *  打印机支持的指令类型
 *
 *  \~english
 *  Command type supported by the printer
 */
@property(assign,nonatomic,readwrite) PTCommandMode commandMode;

/*!
 *  \~chinese
 *  打印机厂商
 *
 *  \~english
 *  Printer supplier
 */
@property(assign,nonatomic,readwrite) PTPrinterVender vender;

/*!
 *  \~chinese
 *  蓝牙供应商,由macKey决定
 *
 *  \~english
 *  Bluetooth supplier, decided by macKey
 */
@property(assign,nonatomic,readwrite) PTBluetoothVender bluetoothVender;

/*!
 *  \~chinese
 *  发现蓝牙时获取到的广播信息
 *
 *  \~english
 *  The broadcast information obtained when Bluetooth is found
 */
@property(strong,nonatomic,readwrite) NSDictionary *advertisement;

/*!
 *  \~chinese
 *  蓝牙外设UUID
 *
 *  \~english
 *  Bluetooth peripherals UUID
 */
@property(strong,nonatomic,readwrite) NSString *uuid;

/*!
 *  \~chinese
 *  发现外设时获取到的信号强度值，单位分贝
 *
 *  \~english
 *  The signal strength value obtained when peripherals are found, unit is db
 */
@property(strong,nonatomic,readwrite) NSNumber *rssi;

/*!
 *  \~chinese
 *  信号强度等级分0-5级
 *
 *  \~english
 *  Signal strength level is from 0 to 5
 */
@property(strong,nonatomic,readwrite) NSNumber *strength;

/*!
 *  \~chinese
 *  由信号强度计算的距离
 *
 *  \~english
 *  The distance calculated by signal strength
 */
@property(strong,nonatomic,readwrite) NSNumber *distance;

/*!
 *  \~chinese
 *  蓝牙外设
 *
 *  \~english
 *  Bluetooth peripherals
 */
@property(strong,nonatomic,readwrite) CBPeripheral *peripheral;

/*!
 *  \~chinese
 *  外设的ip地址
 *
 *  \~english
 *  IP
 */
@property(strong,nonatomic,readwrite) NSString *ip;

/*!
 *  \~chinese
 *  端口
 *
 *  \~english
 *  port
 */
@property(strong,nonatomic,readwrite) NSString *port;

/*!
 *  \~chinese
 *  下列方法无需调用
 *
 *  \~english
 *  The following methods do not need to be called
 */

+ (NSString *)nameWithPeripheral:(CBPeripheral *)peripheral adv:(NSDictionary *)adv;
+ (PTPrinterVender)venderWith:(NSDictionary *)adv;
+ (PTBluetoothVender)bluetoothVenderWith:(NSString *)macKey;
+ (NSString *)macWith:(NSDictionary *)adv vender:(PTPrinterVender)vender;
+ (NSString *)macKeyWith:(NSString *)mac;
+ (PTCommandMode)commandModeWith:(NSDictionary *)adv;
+ (NSNumber *)distanceWithRSSI:(NSNumber *)RSSI;
+ (NSNumber *)strengthWithRSSI:(NSNumber *)RSSI;
+ (NSString *)hexStringWithData:(NSData *)data;
- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI;

@end
