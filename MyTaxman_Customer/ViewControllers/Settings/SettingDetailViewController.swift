//
//  SettingDetailViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import WebKit

class SettingDetailViewController: UIViewController {
    
    var pageType : settingPageType = .none
    var webView: WKWebView!
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var copyrightsLbael: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.setHeaderTitle(titleText: "Version \(Bundle.main.versionNumber)")
        copyrightsLbael.setHeaderTitle(titleText: "© 2020 MyTaxman Pvt Ltd")
        self.setDataBasedOnSelected()
        
        // Do any additional setup after loading the view.
    }
    func setDataBasedOnSelected() {
        switch pageType {
        case .about:
            self.aboutView.isHidden = false
            self.configureAboutView()
        default:
            self.aboutView.isHidden = true
            self.configureWebView()
        }
    }
    func configureWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        //webView.uiDelegate = self
        view = webView
        let myURL = URL(string:urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func configureAboutView() {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
