//
//  ViewController.swift
//  webview
//
//  Created by Kushagra Mishra on 15/12/21.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate{
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let indexURL = Bundle.main.url(forResource: "index",
                                          withExtension: "html") {
            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL.deletingLastPathComponent())
        }
    }


}

