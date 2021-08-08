//
//  WebAppViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 8/4/21.
//

import UIKit
import WebKit

class WebAppViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
        
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    func loadPage() {
        var url: URL!
        url = URL(string: "http://www.google.com")
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.addSubview(ActInd)
        self.ActInd.startAnimating()
        self.ActInd.hidesWhenStopped = true
        
        loadPage()
    }
    
    @IBAction func back(_ sender: Any) {
        
        if webView.canGoBack {
            
            webView.goBack()
        }
    }
    
    @IBAction func forward(_ sender: Any) {
        
        if webView.canGoForward {
            
            webView.goForward()
            
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        webView.reload()
        
    }
    
    @IBAction func stop(_ sender: Any) {
        
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
