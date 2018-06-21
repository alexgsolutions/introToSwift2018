//
//  MoreInfoViewController.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/28/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import UIKit
import WebKit


class MoreInfoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title  = AppConfig.ScreenTitlesNames.moreInfo
        self.webView.navigationDelegate = self
        loadContent()
         applyNavigationShadow()
    }
    
    private func loadContent() {
        let url = URL(string: APIResource.WebAddress)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    

}

extension MoreInfoViewController: WKNavigationDelegate {
    
}
