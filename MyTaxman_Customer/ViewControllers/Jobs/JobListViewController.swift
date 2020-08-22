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

class JobListViewController: BaseViewController {
    
    @IBOutlet weak var videoCallBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var segmentView: BetterSegmentedControl!
    
    @IBOutlet weak var jobsListTableView: UITableView!
    private var leadViewModel = LeadViewModel()
    
    var activeList : [Quotes] = []
    var completedList : [Ilist] = []
    var closedList : [ClosedJobListDesc] = []
    var no_of_vendor_count : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewUI()
        NotificationCenter.default.post(name: NSNotification.Name("UserDidLoginNotification"), object: nil, userInfo: ["userId": "suyambu"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCustomerTaskListForActiveView()
        self.getCustomerTaskListForCompletedView()
        self.getCustomerTaskListForClosedView()
    }
    
    func setupViewUI() {
        
        isTransparent = true
        self.nameTitleLabel.setHeaderTitle(titleText: "")
        self.nameTitleLabel.textColor = ColorManager.textDarkGreenColor.color
        self.descriptionLabel.textColor = ColorManager.textDarkGreenColor.color
        self.descriptionLabel.setLabelCustomProperties(titleText: "Let's Get Started", textColor: ColorManager.textDarkGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 1, alignment: .left)
        
        if let name = UserDetails.shared.userLoginData?.customername, !name.isEmpty {
            if name.count >= 10 {
                self.nameTitleLabel.text = "Hello" + " " + name.prefix(10) + "..."
            }
            else {
                self.nameTitleLabel.text = "Hello" + " " + name + "..."
            }
        }
        
        self.videoCallBtn.isHidden = true
        self.callBtn.isHidden = true
        
        let image = UIImage(named: "add")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image:image, style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        self.setUpSegmentViewControl(segmentControl: segmentView, bgColor: .white, titles: ["Active","Completed", "Closed"])
        jobsListTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.identifier)
        jobsListTableView.register(CompletedJobTableViewCell.nib, forCellReuseIdentifier: CompletedJobTableViewCell.identifier)
        jobsListTableView.register(ClosedJobTableViewCell.nib, forCellReuseIdentifier: ClosedJobTableViewCell.identifier)
        jobsListTableView.tableFooterView = UIView()
        jobsListTableView.backgroundColor = ColorManager.white.color
        jobsListTableView.separatorStyle = .none
        jobsListTableView.estimatedRowHeight = 500
        jobsListTableView.rowHeight = UITableView.automaticDimension
        jobsListTableView.delegate = self
        jobsListTableView.dataSource = self
    }
    
    @objc func addTapped(){
        self.redirectToSubmitTaskVC()
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
                    self.no_of_vendor_count = result.no_of_vendor_count ?? "0"
                    self.activeList = result.desc?.quotes ?? []
                    doOnMain {
                        self.jobsListTableView.reloadData()
                    }
                }else {
                    self.presentAlert(withTitle: "", message: "")
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
                    doOnMain {
                        self.jobsListTableView.reloadData()
                    }
                }else {
                    self.presentAlert(withTitle: "", message: "Try again")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    func getCustomerTaskListForClosedView() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
        ]
        leadViewModel.getCustomerTaskListForClosedTab(input: params) { (result: ClosedJobListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if result.code == "1"{
                    self.closedList = result.desc ?? []
                    doOnMain {
                        self.jobsListTableView.reloadData()
                    }
                }else {
                    self.presentAlert(withTitle: "", message: "Try again")
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
        var client: SINClient {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.client!
        }
        client.call().delegate = self
        if client.isStarted() {
            weak var call: SINCall? = client.call()?.callUserVideo(withId: "Vanithasree_163")
            self.redirectToVideoCallVC(call: call)
        }
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
        let callVC = CallViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        callVC.call = call
        callVC.modalPresentationStyle = .fullScreen
        self.present(callVC, animated: true, completion: nil)
    }
    func redirectToVideoCallVC(call : SINCall?) {
        let callVC = VideoCallViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
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
    
    func menuAction(data : Quotes?, complete: Ilist?, closed: ClosedJobListDesc?) {
        let menuOptionVC = JobMenuOptionViewController.instantiateFromAppStoryboard(appStoryboard: .Jobs)
        menuOptionVC.modalPresentationStyle = .fullScreen
        
        var choosenJobType : JobChoosenType = .activeJob
        
        switch self.segmentView.index {
        case 0:
            let result = data?.vendor?.filter({ (obj) -> Bool in
                return obj.quote_status == "1"
            })
            if result?.count != 0 {
                menuOptionVC.optionList = ["View Job Details"]
            }else {
                menuOptionVC.optionList = ["Hire Business", "View Job Details", "Cancel Job"]
            }
            choosenJobType = .activeJob
            
        case 1:
            menuOptionVC.optionList = ["View Job Details"]
            choosenJobType = .completedJob
        case 2:
            menuOptionVC.optionList =  ["View Job Details"]
            choosenJobType = .closedJob
        default: break
            
        }
        menuOptionVC.hireBusinessAction = {[weak self] in
            self?.redirectHirePage()
        }
        menuOptionVC.viewJobAction = {[weak self] in
            
            self?.redirectViewJobPage(isFrom: choosenJobType, data: data, complete: complete, closed: closed)
        }
        menuOptionVC.cancelJobAction = {[weak self] in
            self?.redirectCancelJobPage()
        }
        let navigationController = UINavigationController(rootViewController: menuOptionVC)
        navigationController.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(navigationController, animated: true, completion: {})
    }
    
    func redirectToSubmitTaskVC() {
        let submitANewJobVC = LeadsDashboardViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(submitANewJobVC, animated: true)
    }
}

extension JobListViewController{
    func redirectHirePage(){
        let hireVC = HireViewController.instantiateFromAppStoryboard(appStoryboard: .Jobs)
        hireVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(hireVC, animated: true)
    }
    func redirectCancelJobPage(){
        let cancelVC = CancelJobsListViewController.instantiateFromAppStoryboard(appStoryboard: .Jobs)
        cancelVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cancelVC, animated: true)
    }
    
    func redirectViewJobPage(isFrom jobChoosenType:JobChoosenType,data : Quotes?, complete: Ilist?, closed: ClosedJobListDesc?) {
        let jobDetail = JobDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .Jobs)
        jobDetail.hidesBottomBarWhenPushed = true
        jobDetail.jobType = jobChoosenType
        jobDetail.activeJobDetails = data
        jobDetail.completedJobDetails = complete
        jobDetail.closedJobDetails = closed
        self.navigationController?.pushViewController(jobDetail, animated: true)
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
            guard let cell : JobsTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.identifier) as? JobsTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.vendorList = []
            cell.no_of_vendor_count = no_of_vendor_count
            cell.menuAction = {[weak self] in
                self?.menuAction(data: self?.activeList[indexPath.row], complete: nil, closed: nil)
            }
            cell.setValue(data : activeList[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        case 1:
            guard let cell : CompletedJobTableViewCell = tableView.dequeueReusableCell(withIdentifier: CompletedJobTableViewCell.identifier) as? CompletedJobTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            cell.menuAction = {[weak self] in
                self?.menuAction(data: nil, complete: self?.completedList[indexPath.row], closed: nil)
            }
            cell.setValue(data : completedList[indexPath.row])
            return cell
        case 2:
            guard let cell : ClosedJobTableViewCell = tableView.dequeueReusableCell(withIdentifier: ClosedJobTableViewCell.identifier) as? ClosedJobTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            cell.menuAction = {[weak self] in
                self?.menuAction(data: nil, complete: nil, closed: self?.closedList[indexPath.row])
            }
            cell.setValue(data : closedList[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.segmentView.index {
        case 0:
            var height = 0
            if ((activeList[indexPath.row].task_status == "0") && (activeList[indexPath.row].received_quotes == "4")) {
                height = 44
            }
            let completeResult = activeList[indexPath.row].vendor?.filter({ (obj) -> Bool in
                return obj.quote_status == "4"
            })
            if (completeResult?.count ?? 0 != 0) {
                height = height + 50
            }
            if activeList[indexPath.row].vendor?.count == 0 {
                return CGFloat(210 + height)
            }
            let count = activeList[indexPath.row].vendor?.count ?? 0
            return CGFloat(210 + (count * 120) + height)
        case 1:
            let count = completedList[indexPath.row].rmsg?.count ?? 0
            return CGFloat(100 + (count * 100))
        case 2:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}

extension JobListViewController : SINCallClientDelegate, SINCallDelegate {
    func client(_ client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        if call.details.isVideoOffered {
            self.redirectToVideoCallVC(call: call)
        }
        else {
            self.redirectToCallVC(call: call)
        }
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
