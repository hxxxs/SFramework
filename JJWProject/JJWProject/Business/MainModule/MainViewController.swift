//
//  MainViewController.swift
//  JJWProject
//
//  Created by 123 on 2019/3/19.
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
    
    // MARK: - Private - UI
    
    private func configUI() {
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        addChildViewControllers()
        
        let imgView = UIImageView(image: UIImage(imageLiteralResourceName: "tabbar_bg"))
        
        tabBar.insertSubview(imgView, at: 0)
        imgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(-21.5)
            make.bottom.equalTo(bottomLayoutGuide.snp.bottom)
        }
        delegate = self
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
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color_333333], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color_353D6C], for: .selected)
        return NavViewController(rootViewController: vc)
    }

}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        tabBar.clipsToBounds = !tabBar.clipsToBounds
        return true
    }
}
