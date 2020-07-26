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
    
    var fetcher: GMSAutocompleteFetcher?
    var addressArray : [String] = []
    
    @IBOutlet weak var addressTextField: TweeAttributedTextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var addressTableView: UITableView!
    
    var locationAddress : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setViewUI()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setViewUI() {
        
        addressTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
                                    for: .editingChanged)
        addressTextField.setTextFieldProperties(placeholderString: "Location", isSecureText: false)
        
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
        
        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        filter.country = "au"
        
        
        // Create a new session token.
        let token: GMSAutocompleteSessionToken = GMSAutocompleteSessionToken.init()
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(bounds: nil, filter: filter)
        fetcher?.delegate = self
        fetcher?.provide(token)
        
    }
    
    func showOrHideTableView() {
        self.addressTableView.isHidden = self.addressArray.count > 0 ? false : true
        
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
        fetcher?.sourceTextHasChanged(textField.text!)
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
    
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        LeadsManager.shared.postJobsParams?.service_location = self.locationAddress
        LeadsManager.shared.postJobsParams?.lattitude = -37.8320111
        LeadsManager.shared.postJobsParams?.longtitude = 144.9559391
        
        print(LeadsManager.shared.postJobsParams)
        if UserDetails.shared.isLoggedIn {
            
        }
        else {
            self.redirectToContactInfoScreen()
        }
    }
}

extension GetPlacesViewController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        let resultsStr = NSMutableString()
        self.addressArray.removeAll()
        for prediction in predictions {
            if !prediction.attributedPrimaryText.string.isEmpty {
                resultsStr.appendFormat("%@", prediction.attributedFullText.string)
            }
            //resultsStr.appendFormat("Place ID: %@\n", prediction.placeID)
            
        }
        
        self.addressArray.append(resultsStr as String)
        self.addressArray = self.addressArray.filter({ $0 != ""})
        print(self.addressArray)
        self.showOrHideTableView()
        self.addressTableView.reloadData()
        
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error)
        //resultText?.text = error.localizedDescription
    }
}

extension GetPlacesViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier) as? AddressTableViewCell else {
            return UITableViewCell()
        }
        
        cell.addresLabel.text = self.addressArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.locationAddress = self.addressArray[indexPath.row]
        self.addressTextField.text = self.locationAddress
        self.checkifLocationChoosen()
    }
}
