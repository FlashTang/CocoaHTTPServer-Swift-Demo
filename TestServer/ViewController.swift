//
//  ViewController.swift
//  TestServer
//
//  Created by Tang on 2024/12/11.
//

import UIKit
import WebKit
import CocoaHTTPServer
//import CocoaAsyncSocket
//import CocoaLumberjack
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createWebView()
        startServerAndThenLoadHtml()
    }
    
    lazy var localHttpServer:HTTPServer = HTTPServer()
    func startServerAndThenLoadHtml(){
        //注意事项：新版Xcode 编译target 必须ios12+
        //Build Settings - User Script Sandbox : NO
        //修复CocoaHTTPServer因新版CocoaLumberjack API报错 : https://www.jianshu.com/p/b693d660acc1
        
        localHttpServer.setType("_http.tcp")
        localHttpServer.setPort(8080)
        localHttpServer.setDocumentRoot("\(Bundle.main.bundlePath)/web/flutter")
        
        do {
            try localHttpServer.start()
            print("Started HTTP Server on port \(localHttpServer.listeningPort())")
            
            let url = URL(string:"http://127.0.0.1:\(localHttpServer.listeningPort())/index.html")!
          
            let request = URLRequest(url: url)
            webView.load(request)
        }
        catch let err{
            print("Error starting HTTP Server: \(err)")
        }
    }
    
    var webView:WKWebView!
    func createWebView(){
        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView = WKWebView(frame: .zero, configuration: configuration)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
 
