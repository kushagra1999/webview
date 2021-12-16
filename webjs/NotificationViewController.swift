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
    var myhtml = ""
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        print("Entered view didload")
        let contentController = self.webView.configuration.userContentController
        contentController.add(self, name: "buttonMessage")
        let js = """
         function geocodeAddress() {
          
                                webkit.messageHandlers.buttonMessage.postMessage("Data sent2");
              
             
         }
        """

        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
        
//        if let indexURL = Bundle.main.url(forResource: "index",
//                                          withExtension: "html") {
//            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL.deletingLastPathComponent())
//        }
    }
    func getCustomdata(_ notification: UNNotification){
        if let dict = notification.request.content.userInfo as? [String:Any] {
                  if let dataDict = dict["Timer_Customdata"] as? [String:Any],let type = dataDict["myhtml"] as? String{
                      self.myhtml = type
                  }
              }
    }
    func didReceive(_ notification: UNNotification) {
        getCustomdata(notification)
        webView.loadHTMLString(myhtml, baseURL: nil)
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
