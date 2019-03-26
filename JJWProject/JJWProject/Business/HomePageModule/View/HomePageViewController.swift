//
//  HomePageViewController.swift
//  JJWProject
//
//  Created by 123 on 2019/3/20.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit

class HomePageViewController: JJWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = JJWWebController()
        vc.urlString = "https://www.baidu.com"
        present(vc, animated: true, completion: nil)
    }
    
}
