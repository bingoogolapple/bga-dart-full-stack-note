//
//  TwoModeViewController.swift
//  hybrid_ios
//
//  Created by 王浩 on 2019/10/27.
//  Copyright © 2019年 王浩. All rights reserved.
//

import UIKit
import Flutter

class TwoModeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "iOS 中接入 Flutter 的两种方式"
        
        var createControllerBtn = UIButton(type:UIButton.ButtonType.custom)
        createControllerBtn.backgroundColor = UIColor.lightGray
        createControllerBtn.frame = CGRect(x:10, y:200, width:UIScreen.main.bounds.width - 20, height:40)
        createControllerBtn.setTitle("createControllerWithoutEngine", for: .normal)
        createControllerBtn.addTarget(self, action:#selector(createControllerWithoutEngine), for: .touchUpInside)
        self.view.addSubview(createControllerBtn)
        
        createControllerBtn = UIButton(type:UIButton.ButtonType.custom)
        createControllerBtn.backgroundColor = UIColor.lightGray
        createControllerBtn.frame = CGRect(x:10, y:250, width:UIScreen.main.bounds.width - 20, height:40)
        createControllerBtn.setTitle("createControllerWithEngine", for: .normal)
        createControllerBtn.addTarget(self, action:#selector(createControllerWithEngine), for: .touchUpInside)
        self.view.addSubview(createControllerBtn)
    }
    
    @objc
    func createControllerWithoutEngine() {
        let routeDict = ["path":"flutter_create_controller_without_engine", "arguments":"iOS 不使用 FlutterEngine 的情况下创建 FlutterViewController 集成 Flutter"]
        if let jsonData = try? JSONEncoder().encode(routeDict) {
            if let initialRoute = String(data: jsonData, encoding: .utf8) {
                let flutterViewController = FlutterViewController()
                flutterViewController.setInitialRoute(initialRoute)
                self.present(flutterViewController, animated: false, completion: nil)
            }
        }
    }
    
    @objc
    func createControllerWithEngine() {
        let routeDict = ["path":"flutter_create_controller_with_engine", "arguments":"iOS 使用 FlutterEngine 的情况下创建 FlutterViewController 集成 Flutter"]
        if let jsonData = try? JSONEncoder().encode(routeDict) {
            if let initialRoute = String(data: jsonData, encoding: .utf8) {
                let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine;
                let flutterViewController = FlutterViewController(engine: flutterEngine!, nibName: nil, bundle: nil)
                // 使用 FlutterEngine 这种方式创建 FlutterViewController 时 setInitialRoute 无效
                flutterViewController.setInitialRoute(initialRoute)
                self.present(flutterViewController, animated: false, completion: nil)
            }
        }
    }
}
