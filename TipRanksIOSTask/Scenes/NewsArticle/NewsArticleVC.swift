//
//  NewsArticleVC.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 09/08/2021.
//

import WebKit

class NewsArticleVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var viewModel: NewsArticleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let link = viewModel?.link {
            webView.load(URLRequest(url: link))
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true)
    }
}
