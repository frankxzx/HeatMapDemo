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
        let js = "myChart.refresh()"
        webView.stringByEvaluatingJavaScriptFromString(js)
    }
    
}

extension ViewController: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let js = NSString(format: "alterTest(%@)","23333")
        webView.stringByEvaluatingJavaScriptFromString(js as String)
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        /* Create session, and optionally set a NSURLSessionDelegate. */
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = NSURL(string: "http://localhost:3000/HeatMap") else {return}
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
//                let jsonStr = JSON(data!)
               let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)!
//                let js = "loadEcharts"+"(\(jsonStr))"
                let js = NSString(format: "%@(%@)","alterTest", jsonStr)
                
                dispatch_sync(dispatch_get_main_queue()) {
                  webView.stringByEvaluatingJavaScriptFromString("loadChart()")
                }
                
//                webView.stringByEvaluatingJavaScriptFromString(js as String)
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    
}

