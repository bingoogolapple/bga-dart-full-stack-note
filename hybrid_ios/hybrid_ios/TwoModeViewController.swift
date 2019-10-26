//
//  TwoModeViewController.swift
//  hybrid_ios
//
//  Created by 王浩 on 2019/10/27.
//  Copyright © 2019年 王浩. All rights reserved.
//

import UIKit

import UIKit

class TwoModeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let createControllerBtn = UIButton.init(type: UIButton.ButtonType.system)
        createControllerBtn.frame = CGRect(x:10, y:200, width:UIScreen.main.bounds.width - 10, height:30)
        createControllerBtn.setTitle("createController", for: .normal)
        createControllerBtn.addTarget(self, action:#selector(createController), for: .touchUpInside)
        self.view.addSubview(createControllerBtn)
    }
    
    @objc
    func createController() {
    }
    
    
}
