//
//  ViewController.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

public protocol WebViewProtocol {
    init(url URL: URL)
}

public class WebViewController: SFSafariViewController, WebViewProtocol {
}
