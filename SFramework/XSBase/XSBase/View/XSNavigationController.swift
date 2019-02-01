//
//  XSNavigationController.swift
//  XSBase
//
//  Created by 123 on 2019/2/1.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit

open class XSNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = viewControllers.count > 0
        super.pushViewController(viewController, animated: animated)
    }
}
