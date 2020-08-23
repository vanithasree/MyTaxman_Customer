//
//  NotificationsViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    @IBOutlet weak var newMessageLabel: UILabel!
    @IBOutlet weak var zoneTimeBtn: UIButton!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var receiveSMSLabel: UILabel!
    @IBOutlet weak var messageSwitch: UISwitch!
    @IBOutlet weak var messageEmailLabel: UILabel!
    @IBOutlet weak var newsLetterSwitch: UISwitch!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var newsLetterLabel: UILabel!
    
    var profileDetail : CustomerProfileDesc?
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setViewUI() {
        
        newsLetterLabel.setLabelCustomProperties(titleText: "Newsletter", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .left)
        newMessageLabel.setLabelCustomProperties(titleText: "New Message", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .left)
        receiveSMSLabel.setLabelCustomProperties(titleText: "When would you like to receive SMS?", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .left)
        timeZoneLabel.setLabelCustomProperties(titleText: "Timezone", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .left)
        
        
        
        emailLabel.setLabelCustomProperties(titleText: "Email", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        messageEmailLabel.setLabelCustomProperties(titleText: "Email", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        fromLabel.setLabelCustomProperties(titleText: "From", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        toLabel.setLabelCustomProperties(titleText: "To", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        fromBtn.layer.cornerRadius = 5.0
        fromBtn.layer.borderWidth = 1.0
        fromBtn.layer.borderColor = UIColor.black.cgColor
        fromBtn.setTitleColor(ColorManager.textLiteGreenColor.color, for: .normal)
        fromBtn.setTitle("", for: .normal)
        fromBtn.backgroundColor = .clear
        
        toBtn.layer.cornerRadius = 5.0
        toBtn.layer.borderWidth = 1.0
        toBtn.layer.borderColor = UIColor.black.cgColor
        toBtn.setTitleColor(ColorManager.textLiteGreenColor.color, for: .normal)
        toBtn.setTitle("", for: .normal)
        toBtn.backgroundColor = .clear
        
        
        zoneTimeBtn.backgroundColor = .clear
        zoneTimeBtn.setTitleColor(.darkGray, for: .normal)
        zoneTimeBtn.setTitle("", for: .normal)
        
        
        
        let rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveTheChanges))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        setData()
    }
    
    @objc func saveTheChanges() {
        
    }
    func setData() {
        if let detail = profileDetail {
            if detail.newsletter_notification?.lowercased() == "true" {
                self.newsLetterSwitch.setOn(true, animated: true)
            }
            else {
                self.newsLetterSwitch.setOn(false, animated: true)
            }
            
            if detail.newmessage_notification?.lowercased() == "true" {
                self.messageSwitch.setOn(true, animated: true)
            }
            else {
                self.messageSwitch.setOn(false, animated: true)
            }
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
