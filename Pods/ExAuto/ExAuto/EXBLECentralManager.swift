//
//  EXBLECentralManager.swift
//  ExRemote
//
//  Created by wendy on 16/5/5.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit
import CoreBluetooth

public protocol BLECentralDelegate: NSObjectProtocol{
    //    func didDiscoverConnection(connection: BLEConnection)
    //    func didConnectConnection(connection: BLEConnection)
    //Mark:CC中实现
    func didUpdataValue(Central:EXBLECentralManager,value:NSString)
    func getConnetStateString(errorString:connectState) -> connectState
}

public class EXBLECentralManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    let characteristicUUIDString = "DABCAF22-9D34-4C8C-9EC6-D7DB80E89788"
    let seviceUUID = "3E4EA42A-AF5D-4D6A-8ABE-A29935B5EA8C"
    
    var manager:CBCentralManager!
    var serviceUUIDs : CBUUID!
    var characteristicsUUIDs : CBUUID!
    var data:NSMutableData!
    var peripheral : CBPeripheral!
    var errorString:connectState!
    weak var delegate: BLECentralDelegate?
    
    init(delegate:BLECentralDelegate?) {
        super.init()
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //MARK:扫描
    func startScan() {
        if manager.state.rawValue == CBCentralManagerState.poweredOn.rawValue {
            manager.scanForPeripherals(withServices: [serviceUUIDs], options: nil)
        }
    }
    func stopScan() {
        manager.stopScan()
    }
    
    // MARK: CBCentralManagerDelegate
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state{
        case .poweredOn:
            characteristicsUUIDs = CBUUID(string:characteristicUUIDString)
            serviceUUIDs = CBUUID(string: seviceUUID)
            manager.scanForPeripherals(withServices: [serviceUUIDs], options: nil)
            errorString = connectState.poweredOn
            print("Bluetooth is currently powered on and available to use.")
        case .poweredOff:
            errorString = connectState.poweredOff
            print("Bluetooth is currently powered off.")
        case .unauthorized:
            errorString = connectState.unauthorized
            print("The app is not authorized to use Bluetooth low energy.")
        default:
            errorString = connectState.unknown
            print("centralManagerDidUpdateState: \(central.state)")
        }
        delegate?.getConnetStateString(errorString: errorString)
    }
    
    private func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("didDiscoverPeripheral");
        errorString = connectState.connecting
        delegate?.getConnetStateString(errorString: errorString)
        self.peripheral = peripheral
        self.peripheral.delegate = self;
        manager.connect(peripheral, options: nil)
        manager.stopScan()
    }
    
    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        errorString = connectState.connected
        delegate?.getConnetStateString(errorString: errorString)
        peripheral.discoverServices([serviceUUIDs])
    }
    
    // MARK: CBPeripheralDelegate
    public func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if error != nil {
            return
        }
        let services : Array = peripheral.services!
        for service in services as! [CBService] {
            if service.uuid.isEqual(serviceUUIDs) {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    @nonobjc public func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if error != nil {
            return
        }
        let characteristics : Array = service.characteristics!
        for c in characteristics {
            if c.uuid.isEqual(characteristicsUUIDs) {
                peripheral.setNotifyValue(true, for: c);
            }
        }
    }
    
    public func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if error != nil {
            return
        }
        let data = NSString(data: characteristic.value!, encoding: String.Encoding.utf8.rawValue)
        print("data is \(data)");
        delegate?.didUpdataValue(Central: self, value: data!)
    }
    
    //MARK:连接  后期实现，找到多个设备以后选择连接
    func connect() {
        
    }
    
    func disconnect() {
        
    }
}

public protocol CBPeripheralServerDelegate:NSObjectProtocol{
    
    //Mark:暂时用不到 用于中心给外设传值
    func peripheralServer(peripheral:EXBLEPeripheralManager, centralDidSubscribe central:CBCentral)
    func peripheralServer(peripheral:EXBLEPeripheralManager, centralDidUnsubscribe central:CBCentral)
    
}

public class EXBLEPeripheralManager: NSObject,CBPeripheralManagerDelegate {
    
    let characteristicUUIDString = "DABCAF22-9D34-4C8C-9EC6-D7DB80E89788"
    let seviceUUID = "3E4EA42A-AF5D-4D6A-8ABE-A29935B5EA8C"
    var errorString:String!
    var connection:NSString!
    var serviceName:NSString!
    var pendingData:NSData!
    
    var serviceUUID : CBUUID!
    var characteristicUUID : CBUUID!
    
    var manager : CBPeripheralManager!
    var service : CBMutableService!
    var characteristic : CBMutableCharacteristic!
    var data : NSData!
    
    weak var delegate:CBPeripheralServerDelegate?
    
    //super override
    override init() {
        super.init()
        manager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
//    init(delegate: CBPeripheralManagerDelegate?,queue:dispatch_queue_t?,options:[String : AnyObject]?) {
//        super.init()
//        manager = CBPeripheralManager(delegate: delegate, queue: queue, options: options)
//    }
    init(delegate: CBPeripheralManagerDelegate?, queue: DispatchQueue?, options: [String : Any]? = nil){
        super.init()
        self.manager = CBPeripheralManager(delegate: delegate, queue: queue, options: options)
    }
    func sendToSubcribers(data:NSData){
        if manager.state.rawValue == CBPeripheralManagerState.poweredOn.rawValue{
            let isSuccess = manager.updateValue(data as Data, for: characteristic, onSubscribedCentrals: nil)
            if !isSuccess {
                pendingData = data;
            }
        }
    }
    
    //  MARK:广播
    func startAdvertisingING(){
        if manager.isAdvertising {
            manager.stopAdvertising()
        }
        manager.startAdvertising([CBAdvertisementDataServiceUUIDsKey : [service.uuid]])
    }
    
    func stopAdvertising() {
        manager.stopAdvertising()
    }
    
    func isAdvertising() -> Bool {
        return manager.isAdvertising
    }
    
    
    //  MARK:peripheralManageDelegate
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state.rawValue != CBPeripheralManagerState.poweredOn.rawValue {
            return
        }
        characteristicUUID = CBUUID(string:characteristicUUIDString)
        serviceUUID = CBUUID(string: seviceUUID)
        
        characteristic = CBMutableCharacteristic(type: characteristicUUID, properties: CBCharacteristicProperties.notify, value: nil, permissions: CBAttributePermissions.readable)
        service = CBMutableService(type: serviceUUID, primary:true)
        service.characteristics = [characteristic!]
        
        manager.add(service)
    }
    
    public func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        if (error != nil) {
            errorString = error?.localizedDescription
        }
        startAdvertisingING()
    }
    
    @nonobjc public func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if (error != nil) {
            errorString = error?.localizedDescription
            print("startAdvertising \(errorString)")
        }
    }
    public func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {        
        delegate?.peripheralServer(peripheral: self, centralDidSubscribe: central)
    }
    
    public func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        delegate?.peripheralServer(peripheral: self, centralDidUnsubscribe: central)
    }
    
    public func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        if (pendingData != nil) {
            let data = pendingData.copy();
            pendingData = nil
            sendToSubcribers(data: data as! NSData)
        }
    }
    
    //MARK:后期实现
    public func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        
    }
    public func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        
    }
    
}

public enum RemoteEnum:NSInteger {
    case up = 200//上
    case left//左
    case down//下
    case right//右
    case enter//确认
    case plus//音量增大
    case dec//音量减小
    case voice//语音
    case menu//菜单
    case back//返回
}

public enum connectState:String{
    case scan
    case connecting
    case connected
    case poweredOn
    case poweredOff
    case unauthorized
    case unknown
}






























