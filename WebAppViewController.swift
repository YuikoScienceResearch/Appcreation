//
//  WebAppViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 8/4/21.
//

import UIKit
import WebKit

class WebAppViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
    var ActInd: UIActivityIndicatorView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url: URL!
        url = URL(string: "http://www.google.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
        func generateActivityIndicator() {
            webView.addSubview(ActInd)
            self.ActInd.startAnimating()
            self.ActInd.hidesWhenStopped = true
    }
    
    func back(_ sender: Any) {
        
        if webView.canGoBack {
            
            webView.goBack()
        }
    }
    
    func forward(_ sender: Any) {
        
        if webView.canGoForward {
            
            webView.goForward()
            
        }
    }
    
    func refresh(_ sender: Any) {
        
        webView.reload()
        
    }
    
    func stop(_ sender: Any) {
        
        webView.stopLoading()
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        ActInd.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        ActInd.stopAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        ActInd.stopAnimating()
        
    }
}

