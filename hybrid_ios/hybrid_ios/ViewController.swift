//
//  ViewController.swift
//  hybrid_ios
//
//  Created by 王浩 on 2019/10/27.
//  Copyright © 2019年 王浩. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HybridDemo"
    
        addTwoModeBtn()
        addEventChannelDemoBtn()
        addMethodChannelDemoBtn()
        addBasicMessageChannelDemoBtn()
    }
    
    func addTwoModeBtn() {
        let twoModeBtn = UIButton(type:UIButton.ButtonType.custom)
        twoModeBtn.backgroundColor = UIColor.lightGray
        twoModeBtn.frame = CGRect(x:10, y:100, width:UIScreen.main.bounds.width - 20, height:40)
        twoModeBtn.setTitle("iOS 中接入 Flutter 的两种方式", for: .normal)
        twoModeBtn.addTarget(self, action:#selector(openTwoModeViewController), for: .touchUpInside)
        self.view.addSubview(twoModeBtn)
    }
    
    func addEventChannelDemoBtn() {
        let twoModeBtn = UIButton(type:UIButton.ButtonType.custom)
        twoModeBtn.backgroundColor = UIColor.lightGray
        twoModeBtn.frame = CGRect(x:10, y:150, width:UIScreen.main.bounds.width - 20, height:40)
        twoModeBtn.setTitle("event_channel_demo", for: .normal)
        twoModeBtn.addTarget(self, action:#selector(openEventChannelViewController), for: .touchUpInside)
        self.view.addSubview(twoModeBtn)
    }
    
    func addMethodChannelDemoBtn() {
        let twoModeBtn = UIButton(type:UIButton.ButtonType.custom)
        twoModeBtn.backgroundColor = UIColor.lightGray
        twoModeBtn.frame = CGRect(x:10, y:200, width:UIScreen.main.bounds.width - 20, height:40)
        twoModeBtn.setTitle("method_channel_demo", for: .normal)
        twoModeBtn.addTarget(self, action:#selector(openMethodChannelViewController), for: .touchUpInside)
        self.view.addSubview(twoModeBtn)
    }
    
    func addBasicMessageChannelDemoBtn() {
        let twoModeBtn = UIButton(type:UIButton.ButtonType.custom)
        twoModeBtn.backgroundColor = UIColor.lightGray
        twoModeBtn.frame = CGRect(x:10, y:250, width:UIScreen.main.bounds.width - 20, height:40)
        twoModeBtn.setTitle("basic_message_channel_demo", for: .normal)
        twoModeBtn.addTarget(self, action:#selector(openBasicMessageChannelViewController), for: .touchUpInside)
        self.view.addSubview(twoModeBtn)
    }
    
    @objc
    func openTwoModeViewController() {
        self.navigationController?.pushViewController(TwoModeViewController(), animated: true)
    }
    
    @objc
    func openEventChannelViewController() {
        self.navigationController?.pushViewController(EventChannelViewController(), animated: true)
    }
    
    @objc
    func openMethodChannelViewController() {
        self.navigationController?.pushViewController(MethodChannelViewController(), animated: true)
    }
    
    @objc
    func openBasicMessageChannelViewController() {
        self.navigationController?.pushViewController(BasicMessageChannelViewController(), animated: true)
    }
}
