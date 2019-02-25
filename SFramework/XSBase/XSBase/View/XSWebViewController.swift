//
//  XSWebViewController.swift
//  XSBase
//
//  Created by 123 on 2019/2/1.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit
import WebKit
import XSExtension

open class XSWebViewController: UIViewController {
    
    private var observation: NSKeyValueObservation!
    
    open lazy var webView: WKWebView = {
        let v = WKWebView(frame: view.bounds)
        v.navigationDelegate = self
        return v
    }()
    /// 加载条
    open lazy var progressView: UIProgressView = {
        let v = UIProgressView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        v.progressTintColor = UIColor.blue
        self.webView.addSubview(v)
        return v
    }()
    /// 请求地址
    open var urlString: String? {
        didSet {
            urlString = urlString?.replacingOccurrences(of: " ", with: "")
        }
    }
    /// 本地文件名称
    open var fileName: String?
    /// 标题
    open var viewTitle: String? {
        didSet {
            self.title = viewTitle
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if title == nil {
            title = "加载中..."
        }

        configUI()
        
        loadRequest()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //  判断是否包含导航控制器
        if navigationController != nil {
            webView.y = hStatusBar + 44
            webView.height -= webView.y
        }
    }
    
    /// 加载请求
    private func loadRequest() {
        
        if let urlString = urlString,
            let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
        if let fileName = fileName,
            let url = Bundle.main.url(forResource: fileName, withExtension: "html") {
            webView.load(URLRequest(url: url))
        }
    }
    
}

// MARK: - WKNavigationDelegate
extension XSWebViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        debugPrint(navigationAction.request.mainDocumentURL ?? "请求地址不合法")
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if viewTitle != nil {
            self.title = viewTitle
        } else {
            webView.evaluateJavaScript("document.title") { (title, _) in
                self.title = title as? String
            }
        }
    }
}

// MARK: - UI
extension XSWebViewController {
    
    func configUI() {
        
        view.addSubview(webView)
        
        observation = webView.observe(\.estimatedProgress, options: [.new], changeHandler: { (_, change) in
            if let progress = change.newValue {
                self.progressView.progress = Float(progress)
                self.progressView.isHidden = progress >= 1
            }
        })
    }
}
