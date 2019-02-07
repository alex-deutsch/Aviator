//
//  ViewController.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewProtocol {
    func load(url: URL)
}

class WebViewController: UIViewController {
    var request: URLRequest? = nil

    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension WebViewController: WebViewProtocol {
    func load(url: URL) {
        let request = URLRequest(url: url)
        guard webView != nil else { return }
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}

extension WebViewController: WKUIDelegate {
}
