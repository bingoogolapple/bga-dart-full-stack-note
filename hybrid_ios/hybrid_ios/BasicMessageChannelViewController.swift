//
//  BasicMessageChannelViewController.swift
//  hybrid_ios
//
//  Created by 王浩 on 2019/10/27.
//  Copyright © 2019年 王浩. All rights reserved.
//

import UIKit
import Flutter

class BasicMessageChannelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "BasicMessageChannel"
        
        var createControllerBtn = UIButton(type:UIButton.ButtonType.custom)
        createControllerBtn.backgroundColor = UIColor.lightGray
        createControllerBtn.frame = CGRect(x:10, y:200, width:UIScreen.main.bounds.width - 20, height:40)
        createControllerBtn.setTitle("createControllerWithoutEngine", for: .normal)
        createControllerBtn.addTarget(self, action:#selector(createControllerWithoutEngine), for: .touchUpInside)
        self.view.addSubview(createControllerBtn)
    }
    
    @objc
    func createControllerWithoutEngine() {
        let routeDict = ["path":"basic_message_channel_demo"]
        if let jsonData = try? JSONEncoder().encode(routeDict) {
            if let initialRoute = String(data: jsonData, encoding: .utf8) {
                let flutterViewController = FlutterViewController()
                flutterViewController.setInitialRoute(initialRoute)
                
                let basicMessageChannel = FlutterBasicMessageChannel(name: "BasicMessageChannelPlugin", binaryMessenger: flutterViewController.binaryMessenger, codec: FlutterStringCodec.sharedInstance())
                
                basicMessageChannel.setMessageHandler { (message: Any?, reply: FlutterReply) in
                    print("iOS 收到消息\(message ?? "")")
                    if let msg = message, msg is String, (msg as! String).contains("with result") {
                        reply("iOS 收到消息 \(msg) 后回复")
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    basicMessageChannel.sendMessage("iOS 发送消息，without result")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    basicMessageChannel.sendMessage("iOS 发送消息，with result") {(result) in
                        print("iOS 收到结果：\(result ?? "")")
                    }
                }
                
                self.present(flutterViewController, animated: false, completion: nil)
            }
        }
    }
}
