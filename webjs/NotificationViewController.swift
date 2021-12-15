//
//  NotificationViewController.swift
//  webjs
//
//  Created by Kushagra Mishra on 15/12/21.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import WebKit
class NotificationViewController: UIViewController, UNNotificationContentExtension,WKNavigationDelegate{

    @IBOutlet var label: UILabel?
    var webView: WKWebView!
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
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
    
    func didReceive(_ notification: UNNotification) {
            self.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 1000)
            self.view.setNeedsUpdateConstraints()
            self.view.setNeedsLayout()
    }

}
extension NotificationViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}
