//
//  GetPlacesViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMapsBase
import TweeTextField

class GetPlacesViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressTextField: TweeAttributedTextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var addressTableView: UITableView!
    
    var locationAddress : String = ""
    var autocompleteResults :[GApiResponse.Autocomplete] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setViewUI()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setViewUI() {
        
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText: "Where do you want it?")
        
        addressTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
                                    for: .editingChanged)
        addressTextField.setTextFieldProperties(placeholderString: "Choose Location", isSecureText: false)
        
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkifLocationChoosen()
        showOrHideTableView()
        
        self.addressTableView.delegate = self
        self.addressTableView.dataSource = self
        self.addressTableView.register(AddressTableViewCell.nib, forCellReuseIdentifier: AddressTableViewCell.identifier)
        
        self.addressTableView.separatorStyle = .none
        self.addressTableView.backgroundColor = .clear
        self.addressTableView.estimatedRowHeight = 200
        self.addressTableView.rowHeight = UITableView.automaticDimension
        
        
        
    }
    
    func showOrHideTableView() {
        self.addressTableView.isHidden = self.autocompleteResults.count > 0 ? false : true
        
    }
    
    func checkifLocationChoosen() {
        
        if self.locationAddress.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        //  fetcher?.sourceTextHasChanged(textField.text!)
        if let text = textField.text {
            self.showResults(string:text)
        }
    }
    
    func showResults(string:String){
        var input = GInput()
        input.keyword = string
        GoogleApi.shared.callApi(input: input) { (response) in
            if response.isValidFor(.autocomplete) {
                DispatchQueue.main.async {
                    
                    self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                    self.showOrHideTableView()
                    self.addressTableView.reloadData()
                    
                }
            } else { print(response.error ?? "ERROR") }
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
    
    func redirectToContactInfoScreen() {
        let contactInfoVC = ContactInfoViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        contactInfoVC.getPageType = .contact
        self.navigationController?.pushViewController(contactInfoVC, animated: true)
    }
    func redirectToUserLoggedInScreen() {
        let loggedIn = LoggedInInfoViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(loggedIn, animated: true)
    }
    
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        LeadsManager.shared.postJobsParams?.service_location = self.locationAddress
        LeadsManager.shared.postJobsParams?.lattitude = -37.8320111
        LeadsManager.shared.postJobsParams?.longtitude = 144.9559391
        
        print(LeadsManager.shared.postJobsParams)
        if UserDetails.shared.isLoggedIn {
            self.redirectToUserLoggedInScreen()
        }
        else {
            self.redirectToContactInfoScreen()
        }
    }
}


extension GetPlacesViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.autocompleteResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier) as? AddressTableViewCell else {
            return UITableViewCell()
        }
        
        cell.addresLabel.text =    self.autocompleteResults[indexPath.row].formattedAddress
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.locationAddress = self.autocompleteResults[indexPath.row].formattedAddress
        self.addressTextField.text = self.locationAddress
        self.checkifLocationChoosen()
    }
}
