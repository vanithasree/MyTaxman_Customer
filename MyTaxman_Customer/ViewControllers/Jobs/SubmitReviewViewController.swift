//
//  SubmitReviewViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FloatRatingView
class SubmitReviewViewController: BaseViewController {
    var getData: Quotes?
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var ratingView: FloatRatingView!
    @IBOutlet var commentsTextView: UITextView!
    @IBOutlet var informationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        titleLabel.setHeaderTitle(titleText: "Leave a review")
        
        subTitleLabel.setFooterTitle(titleText: "How was your experience with")
        subTitleLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))
        
        informationLabel.setFooterTitle(titleText: "By selecting publish you are agreeing to our review guidlines.")
        informationLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))
        
        ratingView.backgroundColor = UIColor.clear
        ratingView.tintColor = .yellow
        ratingView.type = .wholeRatings
        
        submitButton.setButtonProperties(title: "Publish", font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), titleColor: ColorManager.white.color)
        submitButton.backgroundColor = ColorManager.darkTheme.color
        
        commentsTextView.placeholder = "Review"
        commentsTextView.text = ""
        commentsTextView.layer.cornerRadius = 5
        commentsTextView.layer.borderWidth = 1
        commentsTextView.layer.borderColor = ColorManager.darkGrey.color.cgColor
        
        doOnMain {
            self.profileImageView.cornerRadius = self.profileImageView.frame.size.width / 2
        }
    }
    
    @IBAction func didTapSubmitAction(_ sender: Any) {
        if ratingView.rating == 0 {
            self.presentAlert(withTitle: "", message: "Please give rating") {
            }
        }else {
            
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

