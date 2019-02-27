//
//  XSViewController.swift
//  XSBase
//
//  Created by 123 on 2019/2/27.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit
import XSExtension

open class XSViewController: UIViewController {
    
    //  MARK: - Properties
    
    /// 内容试图
    open lazy var contentView = UIView(frame: view.bounds)
    /// 自定义导航条
    open lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: hStatusBar, width: view.width, height: 44))
    /// 自定义导航条目
    open lazy var navItem = UINavigationItem()
    /// 返回控件
    open lazy var backItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
    /// 关闭控件
    open lazy var closeItem = UIBarButtonItem(title: " 关闭", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissToPresent))
    
    //  MARK: - Life cycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(contentView)
        
        configUI()
    }
    
    deinit {
        print("\(classForCoder) 释放")
    }

    override open var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    //  MARK: - UI
    
    /// 重写此方法不调用super则不会配置导航条
    open func configUI() {
        configNav()
    }
    
    private func configNav() {
        navBar.isTranslucent = false
        navBar.tintColor = UIColor.darkGray
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)]
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
        view.addSubview(navBar)
        
        let y = navBar.height + navBar.y
        contentView.frame = CGRect(x: 0,
                                   y: y,
                                   width: view.width,
                                   height: view.height - y)
    }
    
    //  MARK: - monitor
    
    /// 移除当前控制器
    @objc open func dismissToPresent() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 返回上级控制器
    @objc open func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
