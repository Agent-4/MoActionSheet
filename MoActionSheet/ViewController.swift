//
//  ViewController.swift
//  MoActionSheet
//
//  Created by moxiaohao on 2017/7/9.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func click1(_ sender: Any) {
        MoActionSheet.show(withTitle: nil, destructiveTitle: nil, otherTitles: ["拍照","从相册选择"]) { (index) in
            print("点击了：\(index)")
        }
    }
    
    @IBAction func click2(_ sender: Any) {
        MoActionSheet.show(withTitle: "更换头像", destructiveTitle: nil, otherTitles: ["拍照","从相册选择"]) { (index) in
            print("点击了：\(index)")
        }
    }
    
    @IBAction func click3(_ sender: Any) {
        MoActionSheet.show(withTitle: "确定要退出登录？", destructiveTitle: "退出登录", otherTitles: nil) { (index) in
            print("点击了：\(index)")
        }
    }
    
    @IBAction func click4(_ sender: Any) {
        MoActionSheet.show(withTitle: nil, destructiveTitle: "退出登录", otherTitles: nil) { (index) in
            print("点击了：\(index)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

