//
//  XSWebViewController.swift
//  XSBase
//
//  Created by 123 on 2019/2/1.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit
import WebKit

open class XSWebViewController: UIViewController {
    
    open lazy var webView: WKWebView = {
        let v = WKWebView(frame: view.bounds)
        v.navigationDelegate = self
        return v
    }()
    /// 加载条
    open lazy var progressView: UIProgressView = {
        let v = UIProgressView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        v.progressTintColor = UIColor.blue
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

// MARK: - kvo
extension XSWebViewController {
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //  进度条
        if keyPath == "estimatedProgress",
            let progress = change?[NSKeyValueChangeKey.newKey] as? Float {
            progressView.progress = progress
            progressView.isHidden = progress >= 1
        }
    }
}

// MARK: - UI
extension XSWebViewController {
    
    func configUI() {
        
        view.addSubview(webView)
        webView.addSubview(progressView)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
}
