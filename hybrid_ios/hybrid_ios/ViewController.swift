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
        self.view.backgroundColor = UIColor.white
        let ios_use_flutter_two_mode = UIButton.init(type: UIButton.ButtonType.system)
        ios_use_flutter_two_mode.frame = CGRect(x:10, y:100, width:UIScreen.main.bounds.width - 10, height:30)
        ios_use_flutter_two_mode.setTitle("iOS 中调用 Flutter 的两种模式", for: .normal)
        ios_use_flutter_two_mode.addTarget(self, action:#selector(openTwoModeViewController), for: .touchUpInside)
        self.view.addSubview(ios_use_flutter_two_mode)
    }
    
    @objc
    func openTwoModeViewController() {
        present(TwoModeViewController(), animated: true, completion: nil)
    }


}

