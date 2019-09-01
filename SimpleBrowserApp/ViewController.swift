//
//  ViewController.swift
//  SimpleBrowserApp
//
//  Created by 寺島 洋平 on 2019/08/23.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var browserWebView: WKWebView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    @IBOutlet weak var browserActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        browserWebView.navigationDelegate = self
        urlTextField.delegate = self
        browserActivityIndicatorView.hidesWhenStopped = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField != urlTextField {
            return true
        }
        if let urlString = textField.text {
            loadUrl(urlString: urlString)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField != urlTextField {
            return
        }
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlString = "http://dotinstall.com"
        loadUrl(urlString: urlString)
        addBorder()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        browserActivityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let urlString = self.browserWebView.url?.absoluteString {
            urlTextField.text = urlString
        }
        browserActivityIndicatorView.stopAnimating()
        backButton.isEnabled = browserWebView.canGoBack
        forwardButton.isEnabled = browserWebView.canGoForward
    }
    
    func addBorder() {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.browserWebView.frame.size.width, height: 1.0)
        topBorder.backgroundColor = UIColor.lightGray.cgColor
        self.browserWebView.layer.addSublayer(topBorder)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getValidatedUrl(urlString: String) -> URL? {
        if URL(string: urlString) == nil {
            showAlert("Invalid URL")
            return nil
        }
        return URL(string: appendScheme(urlString))
    }
    
    func appendScheme(_ urlString: String) -> String {
        if URL(string: urlString)?.scheme == nil {
            return "http://" + urlString
        }
        return urlString
    }
    
    func loadUrl(urlString: String) {
        if let url = getValidatedUrl(urlString: urlString) {
            let request = URLRequest(url: url)
            browserWebView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: Any) {
        browserWebView.goBack()
    }
    
    @IBAction func goForward(_ sender: Any) {
        browserWebView.goForward()
    }
    
    @IBAction func reload(_ sender: Any) {
        browserWebView.reload()
    }
    
}

