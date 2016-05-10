//
//  ViewController.swift
//  HeatMapDemo
//
//  Created by Xuzixiang on 16/5/10.
//  Copyright © 2016年 TouchSpring. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let bundle = NSBundle.mainBundle()
        let urlStr = bundle.pathForResource("echarts", ofType: "html")
        let url = NSURL(string: urlStr!)
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
    }
    
    @IBAction func reloadCharts(sender: AnyObject) {
        webView.reload()
    }

}

extension ViewController: UIWebViewDelegate {

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
    
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    
    }

}