//
//  MethodChannelViewController.swift
//  hybrid_ios
//
//  Created by 王浩 on 2019/10/27.
//  Copyright © 2019年 王浩. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

class MethodChannelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "MethodChannel"
        
        var createControllerBtn = UIButton(type:UIButton.ButtonType.custom)
        createControllerBtn.backgroundColor = UIColor.lightGray
        createControllerBtn.frame = CGRect(x:10, y:200, width:UIScreen.main.bounds.width - 20, height:40)
        createControllerBtn.setTitle("createControllerWithoutEngine", for: .normal)
        createControllerBtn.addTarget(self, action:#selector(createControllerWithoutEngine), for: .touchUpInside)
        self.view.addSubview(createControllerBtn)
    }
    
    @objc
    func createControllerWithoutEngine() {
        let routeDict = ["path":"method_channel_demo"]
        if let jsonData = try? JSONEncoder().encode(routeDict) {
            if let initialRoute = String(data: jsonData, encoding: .utf8) {
                let flutterViewController = FlutterViewController()
                flutterViewController.setInitialRoute(initialRoute)
                
                let methodChannel = FlutterMethodChannel(name: "MethodChannelPlugin", binaryMessenger: flutterViewController.binaryMessenger)
                methodChannel.setMethodCallHandler({[weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
                    if call.method == "flutterInvokeNativeWithoutResult" {
                        print("iOS 收到 flutterInvokeNativeWithoutResult")
                    } else if call.method == "flutterInvokeNativeWithResult" {
                        print("iOS 收到 flutterInvokeNativeWithResult")
                        if (arc4random() % 2 == 0) {
                            result("iOS 收到 flutterInvokeNativeWithResult")
                        } else {
                            result(FlutterError(code: "我是错误码", message: "iOS 返回错误消息", details: nil))
                        }
                    } else {
                        result(FlutterMethodNotImplemented)
                    }
                  }
                )
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    methodChannel.invokeMethod("nativeInvokeFlutterWithoutResult", arguments: "red")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    methodChannel.invokeMethod("nativeInvokeFlutterWithResult", arguments: 100) { result in
                        if let realResult = result, realResult is FlutterError {
                            let error:FlutterError = realResult as! FlutterError
                            print("iOS 收到执行失败结果：\(error.code) | \(error.message ?? "")")
                        } else {
                            print("iOS 收到执行成功结果：\(result ?? "")")
                        }
                    }
                }
                
                self.present(flutterViewController, animated: false, completion: nil)
            }
        }
    }
}
