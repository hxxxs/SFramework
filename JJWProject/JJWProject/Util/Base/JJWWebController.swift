//
//  JJWWebController.swift
//  JJWProject
//
//  Created by 123 on 2019/3/26.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit
import WebKit

class JJWWebController: JJWViewController {
    private var observation: NSKeyValueObservation!
    
    lazy var webView: WKWebView = {
        let v = WKWebView()
        v.navigationDelegate = self
        return v
    }()
    /// 加载条
    lazy var progressView: UIProgressView = {
        let v = UIProgressView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        v.progressTintColor = UIColor.blue
        self.webView.addSubview(v)
        return v
    }()
    /// 请求地址
    var urlString: String? {
        didSet {
            urlString = urlString?.replacingOccurrences(of: " ", with: "")
        }
    }
    /// 本地文件名称
    var fileName: String?
    /// 标题
    var viewTitle: String? {
        didSet {
            self.title = viewTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if title == nil {
            title = "加载中..."
        }
        
        configUI()
        loadRequest()
    }
    
    func configUI() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        observation = webView.observe(\.estimatedProgress, options: [.new], changeHandler: {[weak self] (_, change) in
            if let progress = change.newValue {
                self?.progressView.progress = Float(progress)
                self?.progressView.isHidden = progress >= 1
            }
        })
    }
    
    override func goBack() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            super.goBack()
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

extension JJWWebController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.mainDocumentURL?.absoluteString ?? ""
        debugPrint("webview load request url \(url)")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if viewTitle != nil {
            self.title = viewTitle
        } else {
            webView.evaluateJavaScript("document.title") { (title, _) in
                self.title = title as? String
            }
        }
    }
}
