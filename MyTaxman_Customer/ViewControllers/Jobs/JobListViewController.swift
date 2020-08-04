//
//  JobListViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import BetterSegmentedControl
import Sinch


class JobListViewController: UIViewController {
    
    @IBOutlet weak var videoCallBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var segmentView: BetterSegmentedControl!
    
    @IBOutlet weak var jobsListTableView: UITableView!
    private var leadViewModel = LeadViewModel()
    
    var activeList : [Quotes] = []
    var completedList : [Ilist] = []
    var closedList : [Quotes] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        NotificationCenter.default.post(name: NSNotification.Name("UserDidLoginNotification"), object: nil, userInfo: ["userId": "suyambu"])
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCustomerTaskListForActiveView()
        //self.getCustomerTaskListForCompletedView()
    }
    
    func setupViewUI() {
        
        self.nameTitleLabel.setHeaderTitle(titleText: "")
        self.nameTitleLabel.textColor = ColorManager.textLiteGreenColor.color
        self.descriptionLabel.textColor = ColorManager.textLiteGreenColor.color
        self.descriptionLabel.setLabelCustomProperties(titleText: "Let's Get Started", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 1, alignment: .left)
        if let name = UserDetails.shared.userLoginData?.customername, !name.isEmpty {
            if name.count >= 10 {
                self.nameTitleLabel.text = "Hello" + " " + name.prefix(10) + "..."
            }
            else {
                self.nameTitleLabel.text = "Hello" + " " + name + "..."
            }
        }
        
        self.setUpSegmentViewControl(segmentControl: segmentView, bgColor: .white, titles: ["Active","Completed", "Closed"])
        
        
        jobsListTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.identifier)
        jobsListTableView.tableFooterView = UIView()
        jobsListTableView.backgroundColor = ColorManager.white.color
        jobsListTableView.separatorStyle = .none
        jobsListTableView.estimatedRowHeight = 500
        jobsListTableView.rowHeight = UITableView.automaticDimension
        jobsListTableView.delegate = self
        jobsListTableView.dataSource = self
        
        
        
        
        
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
        segmentControl.addTarget(self, action: #selector(navigationSegmentedControlValueChanged(_:)), for: .valueChanged)
        
        
    }
    
    
    func getCustomerTaskListForActiveView() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
        ]
        leadViewModel.getCustomerTaskListForActiveTab(input: params) { (result: CustTaskListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if result.code == "1" {
                    self.activeList =  result.desc?.quotes ?? []
                    self.closedList =  self.activeList.filter { $0.task_cancel_status == "1"}
                }
                else {
                    
                }
                doOnMain {
                    self.jobsListTableView.reloadData()
                }
                
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    func getCustomerTaskListForCompletedView() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
        ]
        
        leadViewModel.getCustomerTaskListForCompletedTab(input: params) { (result: CompletedTaskListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if result.code == "1"{
                    self.completedList = result.desc?.ilist ?? []
                }
                
                doOnMain {
                    self.jobsListTableView.reloadData()
                }
                
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
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
    
    @IBAction func onTapVideoCallBtn(_ sender: UIButton) {
    }
    @IBAction func onTapCallBtn(_ sender: UIButton) {
        var client: SINClient {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.client!
        }
        
        
        client.call().delegate = self
        
        if client.isStarted() {
            weak var call: SINCall? = client.call().callUser(withId: "Vanithasree_163")
            self.redirectToCallVC(call: call)
            
        }
    }
    
    func redirectToCallVC(call : SINCall?) {
        let callVC = CallViewController.instantiateFromAppStoryboard(appStoryboard: .Jobs)
        callVC.call = call
        callVC.modalPresentationStyle = .fullScreen
        self.present(callVC, animated: true, completion: nil)
    }
    
    // MARK: - Action handlers
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        self.jobsListTableView.reloadData()
        
        /*  if sender.index == 0 {
         print("Turning lights on.")
         
         } else {
         print("Turning lights off.")
         
         }*/
    }
}

extension JobListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.segmentView.index {
        case 0:
            return  self.activeList.count
        case 1:
            return self.completedList.count
        case 2:
            return self.closedList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.segmentView.index {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.identifier) as? JobsTableViewCell else {
                return UITableViewCell()
            }
            
            
            
            cell.backgroundColor = .yellow
            cell.actionBtn.tag = indexPath.row
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.identifier) as? JobsTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .cyan
            cell.actionBtn.tag = indexPath.row
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.identifier) as? JobsTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .orange
            cell.actionBtn.tag = indexPath.row
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
            
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension JobListViewController : JobDetailsActionButtonDelegate {
    func onTappedButton(_ tag: Int) {
        print("Selected Button== \(tag)")
    }
    func showActionSheetBasedOnMenuSelection() {
        
    }
    
}
extension JobListViewController : SINCallClientDelegate, SINCallDelegate {
    func client(_ client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        self.redirectToCallVC(call: call)
    }
    
    /*func client(_ client: SINCallClient!, localNotificationForIncomingCall call: SINCall!) -> SINLocalNotification! {
     let notification = SINLocalNotification()
     notification.alertAction = "Answer"
     notification.alertBody = String(format: "Incoming call from %@", arguments: [call.remoteUserId])
     return notification
     }*/
    
    
    func clientDidFail(_ client: SINClient!, error: Error!) {
        print("Sinch client error: \(String(describing: error?.localizedDescription))")
    }
    
    func client(_ client: SINClient, logMessage message: String, area: String, severity: SINLogSeverity, timestamp: Date) {
        print("\(message)")
    }
    
}
