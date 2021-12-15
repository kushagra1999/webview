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
        let contentController = self.webView.configuration.userContentController
        contentController.add(self, name: "buttonMessage")
        let js = """
         function geocodeAddress() {
          
                 webkit.messageHandlers.buttonMessage.postMessage("Data sent");
                 
             
         }
        """

        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
        if let indexURL = Bundle.main.url(forResource: "index",
                                          withExtension: "html") {
            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL.deletingLastPathComponent())
        }
        
    }


}

extension ViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}
