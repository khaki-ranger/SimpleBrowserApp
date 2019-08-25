//
//  ViewController.swift
//  SimpleBrowserApp
//
//  Created by 寺島 洋平 on 2019/08/23.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var browserWebView: WKWebView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlString = "http://dotinstall.com"
        loadUrl(urlString: urlString)
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
        return URL(string: urlString)
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
    }
    
    @IBAction func goForward(_ sender: Any) {
    }
    
    @IBAction func reload(_ sender: Any) {
    }
}

