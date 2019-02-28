//
//  MainViewController.swift
//  SFramework
//
//  Created by 123 on 2019/2/27.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    /// 设置设备方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}

// MARK: - Private - UI

extension MainViewController {
    
    private func configUI() {
        tabBar.tintColor = UIColor.blue
        addChildViewControllers()
    }
    
    private func addChildViewControllers() {
        if let path = Bundle.main.url(forResource: "main.json", withExtension: nil),
            let data = try? Data(contentsOf: path),
            let arrays = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
            
            var vcArray = [UIViewController]()
            for dict in arrays! {
                vcArray.append(controller(with: dict))
            }
            viewControllers = vcArray
        }
    }
    
    private func controller(with dict: [String: String]) -> UIViewController {
        
        guard let clsName = dict["className"],
            let imageName = dict["imageName"],
            let title = dict["title"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type else {
                return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabBar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabBar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        return NavViewController(rootViewController: vc)
    }
}
