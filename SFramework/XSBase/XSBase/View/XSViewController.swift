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
    public lazy var contentView = UIView()
    /// 自定义导航条
    public lazy var navBar = UINavigationBar()
    /// 自定义导航条目
    public lazy var navItem = UINavigationItem()
    /// 返回控件
    public lazy var backItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
    /// 关闭控件
    public lazy var closeItem = UIBarButtonItem(title: " 关闭", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissToPresent))
    
    //  MARK: - Life cycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(contentView)
        
        configUI()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.subviews.contains(navBar) {
            navBar.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.height.equalTo(44)
            }
            
            contentView.snp.makeConstraints { (make) in
                make.top.equalTo(navBar.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        } else {
            contentView.snp.makeConstraints { (make) in
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
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
