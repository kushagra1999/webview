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
//        if let indexURL = Bundle.main.url(forResource: "index",
//                                          withExtension: "html") {
//            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL.deletingLastPathComponent())
//        }
        let htmlString = """
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title>ExploreWKWebViewJavascript</title>
    </head>
    <body>
        Type something:
    <input type = "text"> <br>
        <input type="submit" value="Geocode Address" onclick="geocodeAddress();">
            
<!--            <form action="https://ptsv2.com/t/xzmpy-1639581165/post">-->
<form>
              <label for="fname">First name:</label>
              <input type="text" id="fname" name="fname"><br><br>
              <label for="lname">Last name:</label>
              <input type="text" id="lname" name="lname"><br><br>
              <input type="submit" value="Submit">
            </form>
    </body>
    </html>

"""
        webView.loadHTMLString(htmlString, baseURL: nil)
        
    }


}

extension ViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}
