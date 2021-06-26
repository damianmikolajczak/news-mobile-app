//
//  ArticleWebViewController.swift
//  news-mobile-app
//
//  Created by Damian Mikołajczak on 26/06/2021.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webWindow: WKWebView!
    var articleURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let articleRequest = URLRequest(url: URL(string: articleURL)!)
        webWindow.load(articleRequest)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
