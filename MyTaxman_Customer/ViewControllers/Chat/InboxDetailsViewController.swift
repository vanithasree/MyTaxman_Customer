//
//  InboxDetailsViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import BetterSegmentedControl
class InboxDetailsViewController: BaseViewController {
    
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatHeaderView: UIView!
   @IBOutlet weak var voiceCallBtn: UIButton!
    @IBOutlet weak var videoCallBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var segmentControl: BetterSegmentedControl!
    @IBOutlet var containerView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    private lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    var inbox: Inboxlist?
    var quoteDetailList : [DetailsData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        isTransparent = true
        doOnMain {
            self.setupScrollView()
        }
        
        nameLabel.setLabelCustomProperties(titleText: inbox?.vendorname ?? "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16)), numberOfLines: 0, alignment: .left)
        valueLabel.setLabelCustomProperties(titleText: inbox?.customername ?? "", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14)), numberOfLines: 0, alignment: .left)
        
        
        self.setUpSegmentViewControl(segmentControl: segmentControl, bgColor: .white, titles: ["Quote Details","Chat", "Business Profile"])
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isHideNavigationBar = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.isHideNavigationBar = false
    }
    
    private func preparedViewControllers() -> [UIViewController] {
        let quoteDetailsVC = QuoteDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        quoteDetailsVC.inbox = inbox
        
        let chatVC = ChatViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        chatVC.inbox = inbox
        
        let businessVC = BusinessProfileViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        businessVC.inbox = inbox
        
        return [
            quoteDetailsVC,chatVC,businessVC
        ]
    }
    
    @IBAction func onTappedBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func setUpSegmentViewControl(segmentControl : BetterSegmentedControl, bgColor:UIColor, titles:[String]) {
        
        let normaFont = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(15.0))
        let selectedFont = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0))
        
        segmentControl.layer.cornerRadius = 10.0
        segmentControl.clipsToBounds = true
        
        segmentControl.segments = LabelSegment.segments(withTitles: titles,
                                                        normalBackgroundColor: .clear,
                                                        normalFont: normaFont,
                                                        normalTextColor: ColorManager.textLiteGreenColor.color,
                                                        selectedBackgroundColor: UIColor(red:0.24, green:0.47, blue:0.68, alpha:1.0),
                                                        selectedFont: selectedFont,
                                                        selectedTextColor: UIColor.white)
        segmentControl.options = [.backgroundColor(UIColor.white.withAlphaComponent(0.4)),
                                  .indicatorViewBackgroundColor(UIColor.clear),
                                  .cornerRadius(10)]
        segmentControl.addTarget(self, action: #selector(self.controlValueChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func controlValueChanged(_ sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index)")
        let width = self.view.frame.size.width
        scrollView.scrollRectToVisible(CGRect(x: (width * CGFloat(sender.index)), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height), animated: true)
    }
    // MARK: - Setup container view
    
    private func setupScrollView() {
        scrollView.isScrollEnabled = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: containerView.frame.height
        )
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: containerView.frame.height
            )
            addChild(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
            viewController.didMove(toParent: self)
        }
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

extension InboxDetailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentControl.setIndex(Int(currentPage), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}
