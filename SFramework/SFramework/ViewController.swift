//
//  ViewController.swift
//  SFramework
//
//  Created by 123 on 2019/2/1.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit
import XSBase

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = XSWebViewController()
        vc.urlString = "https://www.baidu.com"
        present(vc, animated: true, completion: nil)
    }


}

