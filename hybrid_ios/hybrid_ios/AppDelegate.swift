//
//  AppDelegate.swift
//  hybrid_ios
//
//  Created by 王浩 on 2019/10/27.
//  Copyright © 2019年 王浩. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant // Only if you have Flutter Plugins.

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
  var flutterEngine : FlutterEngine?

  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.flutterEngine = FlutterEngine(name: "io.flutter", project: nil)
    self.flutterEngine?.run(withEntrypoint: nil)
    GeneratedPluginRegistrant.register(with: self.flutterEngine!)
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.backgroundColor = UIColor.white
    self.window!.makeKeyAndVisible()
    
    let rvc = ViewController()
    let nc = UINavigationController(rootViewController: rvc)
    self.window!.rootViewController = nc
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
