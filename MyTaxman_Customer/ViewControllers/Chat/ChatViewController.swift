//
//  ChatViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

class ChatViewController: UIViewController {
    @IBOutlet var chatTableView: UITableView!
    var inbox: Inboxlist?
    var chatList : [Chat] = []
    private var inboxViewModel = InboxViewModel()
    @IBOutlet var chatTextView: ChatTextInputView!
    @IBOutlet var InputView: UIView!
    @IBOutlet var mediaButton: UIButton!
    @IBOutlet var sentButton: UIButton!
    @IBOutlet var chatViewHeightConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        requestChat()
    }
    
    func setupViews(){
        InputView.backgroundColor = ColorManager.backgroundGrey.color
        chatTextView.backgroundColor = ColorManager.white.color
        chatTextView.text = ""
        chatTextView.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(17.0))
        chatTextView.placeholder = "Write a message"
        chatTextView.delegate = self
        doOnMain {
            self.chatTextView.cornerRadius = self.chatTextView.frame.height / 2
        }
        chatTableView.register(LeftViewCell.nib, forCellReuseIdentifier: LeftViewCell.identifier)
        chatTableView.register(RightViewCell.nib, forCellReuseIdentifier: RightViewCell.identifier)
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.tableFooterView = UIView()
        chatTableView.separatorStyle = .none
        chatTableView.backgroundColor = UIColor(hexString: "E4DDD6")
        chatTableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func didTapMediaAction(_ sender: Any) {
        
    }
    
    @IBAction func didTapSendAction(_ sender: Any) {
        self.view.endEditing(true)
        let verifyMessage : ValidationMessage = inboxViewModel.validateMessage(text: chatTextView.text)
        if verifyMessage.status {
            requestSendChat()
        }else {
            self.presentAlert(withTitle: "", message: verifyMessage.errorMessage ?? "") {}
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if (chatList.count > 0){
            tableView.backgroundView = nil
            return 1
        }
        let noDataView : NoDataView = UIView.fromNib()
        noDataView.frame = tableView.bounds
        tableView.backgroundView = noDataView
        noDataView.setData(information: "You can start messaging with a business once they have sent you a quote")
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message: Chat = chatList[indexPath.row]
        if message.sent_by ?? "" == "Vendor" {
            guard let cell : LeftViewCell = tableView.dequeueReusableCell(withIdentifier: LeftViewCell.identifier) as? LeftViewCell else { return UITableViewCell() }
            cell.configureCell(data: message)
            return cell
        } else {
            guard let cell : RightViewCell = tableView.dequeueReusableCell(withIdentifier: RightViewCell.identifier) as? RightViewCell else { return UITableViewCell() }
            cell.configureCell(data: message)
            return cell
        }
    }
}

extension ChatViewController {
    @objc func requestChat() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
            "vendorid" : inbox?.vendorid ?? "",
            "taskid" : inbox?.taskid ?? "",
        ]
        inboxViewModel.requestChat(input: params) { (result: ChatBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.chatList = result.desc ?? []
                    doOnMain {
                        self.chatTableView.reloadData()
                    }
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    func requestSendChat() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
            "vendorid" : inbox?.vendorid ?? "",
            "taskid" : inbox?.taskid ?? "",
            "chatmessage": chatTextView.text ?? "",
            "sender": "Customer",
            "device_currentdatetime" : Date().toString(format: "yyyy-MM-dd HH:mm:ss"),
            "chat_pic": ""
        ]
        inboxViewModel.requestSendChat(input: params) { (result: SendChatBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    doOnMain {
                        self.chatTextView.text = ""
                        self.chatViewHeightConstraints.constant = 60
                        self.chatViewHeightConstraints.isActive = true
                    }
                    self.perform(#selector(self.requestChat), with: nil, afterDelay: 0.1)
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "Try again")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension ChatViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let textSize = chatTextView.sizeThatFits(CGSize(width: chatTextView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        if textSize.height > 20 {
            let newHeight = textSize.height + 25
            if newHeight > ContainerViewHeight.maximum.rawValue {
                chatViewHeightConstraints.constant = ContainerViewHeight.maximum.rawValue
            } else {
                chatViewHeightConstraints.constant = newHeight
            }
        } else {
            chatViewHeightConstraints.constant = ContainerViewHeight.minimum.rawValue
        }
        chatViewHeightConstraints.isActive = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        chatTextView.enablesReturnKeyAutomatically = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= MessengerConstant.maximumCharCount
    }
}
