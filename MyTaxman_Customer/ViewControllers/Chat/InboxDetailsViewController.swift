//
//  InboxDetailsViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import BetterSegmentedControl
class InboxDetailsViewController: UIViewController {

    @IBOutlet var segmentControl: BetterSegmentedControl!
    @IBOutlet var containerView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    private lazy var viewControllers: [UIViewController] = {
         return self.preparedViewControllers()
     }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        self.setUpSegmentViewControl(segmentControl: segmentControl, bgColor: .white, titles: ["Quote Details","Chat", "Business Profile"])
        // Do any additional setup after loading the view.
    }
    
    private func preparedViewControllers() -> [UIViewController] {
        let quoteDetailsVC = QuoteDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        let chatVC = ChatViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        let businessVC = BusinessProfileViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        return [
            quoteDetailsVC,chatVC,businessVC
        ]
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
                height: view.frame.height
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
