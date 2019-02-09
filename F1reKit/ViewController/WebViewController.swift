//
//  ViewController.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import UIKit
import WebKit

public protocol WebViewProtocol {
    func configure(with url: URL)
}

public class WebViewController: UIViewController {
    var request: URLRequest? = nil

    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        guard let request = request else { return }
        webView.load(request)
    }
}

extension WebViewController: WebViewProtocol {
    public func configure(with url: URL) {
        self.request = URLRequest(url: url)
    }
}

extension WebViewController: WKNavigationDelegate {
    
    internal func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}

extension WebViewController: WKUIDelegate {
}
