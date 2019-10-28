//
//  EventChannelViewController.swift
//  hybrid_ios
//
//  Created by 王浩 on 2019/10/27.
//  Copyright © 2019年 王浩. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

class EventChannelViewController: UIViewController, FlutterStreamHandler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "EventChannel"
        
        var createControllerBtn = UIButton(type:UIButton.ButtonType.custom)
        createControllerBtn.backgroundColor = UIColor.lightGray
        createControllerBtn.frame = CGRect(x:10, y:200, width:UIScreen.main.bounds.width - 20, height:40)
        createControllerBtn.setTitle("createControllerWithoutEngine", for: .normal)
        createControllerBtn.addTarget(self, action:#selector(createControllerWithoutEngine), for: .touchUpInside)
        self.view.addSubview(createControllerBtn)
    }
    
    @objc
    func createControllerWithoutEngine() {
        let routeDict = ["path":"event_channel_demo"]
        if let jsonData = try? JSONEncoder().encode(routeDict) {
            if let initialRoute = String(data: jsonData, encoding: .utf8) {
                let flutterViewController = FlutterViewController()
                flutterViewController.setInitialRoute(initialRoute)
                
                let evenChannal = FlutterEventChannel(name: "EventChannelPlugin", binaryMessenger: flutterViewController.binaryMessenger)
                evenChannal.setStreamHandler(self)
                
                self.present(flutterViewController, animated: false, completion: nil)
            }
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("iOS：onListen arguments：\(arguments ?? "")")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            events("iOS 发送 success")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            events(FlutterError(code: "我是错误码", message: "Android 发送 error", details: nil))
        }
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        print("iOS：onCancel arguments：\(arguments ?? "")")
        return nil
    }
}
