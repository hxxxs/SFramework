//
//  JJWViewController.swift
//  JJWProject
//
//  Created by 123 on 2019/3/26.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit

class JJWViewController: UIViewController {

    //  MARK: - Properties
    
    /// 自定义导航条
    lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: hStatusBar, width: view.bounds.width, height: 44))
        navBar.isTranslucent = false
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        view.insertSubview(navBar, at: 0)
        
        navBar.items = [navItem]
        if tabBarController == nil {// modal
            navItem.leftBarButtonItem = closeItem
            
            if let count = navigationController?.viewControllers.count,
                count > 1 {
                navItem.leftBarButtonItems = [backItem, closeItem]
            }
        } else {// push
            if let count = navigationController?.viewControllers.count,
                count > 1 {
                navItem.leftBarButtonItem = backItem
            }
        }
        return navBar
    }()
    /// 自定义导航条目
    lazy var navItem = UINavigationItem()
    /// 返回控件
    private lazy var backItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
    /// 关闭控件
    private lazy var closeItem = UIBarButtonItem(title: " 关闭", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissToPresent))
    
    //  MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }
    
    deinit {
        print("\(classForCoder) 释放")
    }
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    //  MARK: - monitor
    
    /// 移除当前控制器
    @objc func dismissToPresent() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 返回上级控制器
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

}
