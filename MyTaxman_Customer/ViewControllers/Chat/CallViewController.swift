//
//  CallViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 03/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Sinch

enum ButtonsStatus: Int {
    
    case decline
    case hangup
    
}



class CallViewController: BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var callStatusLabel: UILabel!
    @IBOutlet weak var parentViewForImage: UIView!
    
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var muteImageView: UIImageView!
    @IBOutlet weak var muteLabel: UILabel!
    @IBOutlet weak var muteButton: UIButton!
    
    @IBOutlet weak var speakerViewExpandedForCall: NSLayoutConstraint!
    @IBOutlet weak var speakerViewShrinkedForCall: NSLayoutConstraint!
    /*@IBOutlet weak var speakerViewShrinkedForCall: NSLayoutConstraint!
     @IBOutlet weak var speakerViewExpandedForCall: NSLayoutConstraint!*/
    
    @IBOutlet weak var callDeclineLabel: UILabel!
    @IBOutlet weak var callDeclineImageView: UIImageView!
    
    @IBOutlet weak var callDeclineButton: UIButton!
    
    @IBOutlet weak var callAcceptImageView: UIImageView!
    
    @IBOutlet weak var callEndButton: UIButton!
    @IBOutlet weak var callEndImageView: UIImageView!
    @IBOutlet weak var callAcceptLabel: UILabel!
    @IBOutlet weak var callAcceptButton: UIButton!
    
    fileprivate var grayViewForRoundedProfile = UIView()
    fileprivate var blackViewForRoundedProfile = UIView()
    fileprivate var profileImageView = UIImageView()
    
    fileprivate var isSpeakerActive = false
    fileprivate var isMuteActive = false
    fileprivate var isCallStarted = false
    
    
    public var isInComingCall = false
    public var userId : String = ""
    
    
    var secondsCount = 0
    var minuteCount = 0
    
    fileprivate var sinCallManager : SinCallManager!
    fileprivate var callProvider : CallProviderDelegate? {
        return AppDelegate.shared.callProviderDelegate
    }
    
    //public var call : SINCall?
    var timer = Timer()
    
    //    var durationTimer: Timer?
    //    var call: SINCall!
    //  var getCallButtonStatus : ButtonsStatus = .hangup
    
    /*var audioController:SINAudioController {
     let appDelegate = UIApplication.shared.delegate! as! AppDelegate
     return (appDelegate.client?.audioController())!
     }*/
    
    override func viewWillDisappear(_ animated: Bool) {
        isHideNavigationBar = false
        self.makeTheCallObjectNil()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.layoutIfNeeded()
        isHideNavigationBar = true
        self.sinCallManager = AppDelegate.shared.sinCallManager
        print(AppDelegate.shared.sinCallManager?.currentCall?.direction.rawValue)
        print(sinCallManager.currentCall?.direction.rawValue)
        
        if sinCallManager.currentCall?.direction == .incoming{
            
            print(sinCallManager.client)
            print(sinCallManager.currentCall)
            print(sinCallManager.currentCallStatus)
            
            self.isInComingCall = true
            self.nameLabel.text = sinCallManager.currentCall!.remoteUserId!
            self.audioController.startPlayingSoundFile(path(forSound: "incoming"), loop: true)
            self.isCallStarted = sinCallManager.isComingFromCX
            if isCallStarted {
                answerCall()
            }
        }else{
            //self.audioController.startPlayingSoundFile(path(forSound: "ringback"), loop: true)
            self.nameLabel.text = userId
        }
        self.sinCallManager.currentCall?.delegate = self
        /*
         if call != nil{
         call?.delegate = self
         }
         */
        
        settingUpFrame()
        handlingUIForCall()
    }
    override func viewDidLayoutSubviews() {
        roundingUpProfileWithBorders()
    }
    
    
    /*  func setViewUI() {
     
     // call.delegate = self
     
     callerNameLabel.setLabelCustomProperties(titleText: call.remoteUserId ?? "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(25.0)), numberOfLines: 0, alignment: .center)
     
     callStatusLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .center)
     
     
     acceptBtn.setDarkGreenTheme(btn: acceptBtn, title: "Accept")
     declineBtn.setDarkGreenTheme(btn: declineBtn, title: "Decline")
     
     /* print(call?.remoteUserId!)
     print(call.userInfo)
     
     if call.direction == .incoming
     {
     callStatusLabel.text = "Incoming"
     self.getCallButtonStatus = .decline
     self.audioController.enableSpeaker()
     self.audioController.startPlayingSoundFile(self.pathForSound("incoming.wav"), loop: true)
     }
     else
     {
     callStatusLabel.text = "Calling..."
     self.getCallButtonStatus = .hangup
     }
     self.setButtonAlignmentBasedOnCallStatus()*/
     }*/
    
    @IBAction func speakerButtonClicked(_ sender: UIButton) {
        print("----speakerButtonClicked---")
        self.isSpeakerActive = !self.isSpeakerActive
        self.speakerImageView.image = self.isSpeakerActive ? UIImage(named:"speakerActive") : UIImage(named:"speakerButton")
        self.isSpeakerActive ? self.audioController.enableSpeaker() : self.audioController.disableSpeaker()
    }
    
    @IBAction func muteButtonClicked(_ sender: Any) {
        
        print("----muteButtonClicked---")
        self.isMuteActive = !self.isMuteActive
        self.muteImageView.image = self.isMuteActive ? UIImage(named:"muteActive") : UIImage(named:"muteButton")
        self.isMuteActive ? self.audioController.mute() : self.audioController.unmute()
    }
    
    
    @IBAction func callDeclineButtonClicked(_ sender: Any) {
        print("----callDeclineButtonClicked---")
        makeTheCallObjectNil()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func callAcceptButtonClicked(_ sender: Any) {
        print("----callAcceptButtonClicked---")
        self.isCallStarted = true
        handlingUIForCall()
        answerCall()
    }
    
    @IBAction func callEndButtonClicked(_ sender: Any) {
        print("----callEndButtonClicked---")
        self.makeTheCallObjectNil()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Sounds
    func pathForSound(_ soundName: String) -> String {
        let resourcePath = Bundle.main.resourcePath! as NSString
        return resourcePath.appendingPathComponent(soundName)
    }
    
    func setCallStatusText(_ text: String) {
        self.callStatusLabel.text = text
    }
    
    func setCallStatus(_ text: String) {
        self.callStatusLabel.text = text
    }
    @objc func updateTimer(){
        
        if secondsCount == 59{
            self.secondsCount = 0
            self.minuteCount += 1
        }else{
            secondsCount += 1
        }
        let secondCountIsOfOneDigit : Bool = secondsCount < 10
        let minuteCountIsOfOneDigit : Bool = minuteCount < 10
        
        callStatusLabel.text = "\(minuteCountIsOfOneDigit ? "0" : "")\(minuteCount):\(secondCountIsOfOneDigit ? "0" : "")\(secondsCount)"
    }
}

extension CallViewController : SINCallDelegate {
    func callDidProgress(_ call: SINCall!) {
        print("callDidProgress")
        audioController.startPlayingSoundFile(path(forSound: "ringback"), loop: true)
        callProvider?.reportOutgoingStarted(uuid: call.uuid)
    }
    
    func callDidEstablish(_ call: SINCall!) {
        print("callDidEstablish")
        self.isCallStarted = true
        callProvider?.reportOutoingConnected(uuid: call.uuid)
        self.handlingUIForCall()
        self.audioController.stopPlayingSoundFile()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func callDidEnd(_ call: SINCall!) {
        print("callDidEnd")
        self.makeTheCallObjectNil()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
extension CallViewController {
    
    func settingUpFrame(){
        let size = self.parentViewForImage.frame.size.height * 0.9
        
        grayViewForRoundedProfile.frame.size = CGSize(width: size, height: size)
        grayViewForRoundedProfile.frame.origin.y = self.parentViewForImage.bounds.minY
        grayViewForRoundedProfile.center.x = self.view.bounds.midX//CGPoint(x: , y: self.parentViewForImage.bounds.midY)
        
        grayViewForRoundedProfile.backgroundColor = UIColor.darkGray
        
        self.parentViewForImage.addSubview(grayViewForRoundedProfile)
        
        let sizeForBlack = size * 0.95
        
        blackViewForRoundedProfile.frame.size = CGSize(width: sizeForBlack, height: sizeForBlack)
        blackViewForRoundedProfile.center = CGPoint(x: self.grayViewForRoundedProfile.bounds.midX, y: self.grayViewForRoundedProfile.bounds.midY)
        blackViewForRoundedProfile.backgroundColor = UIColor.black
        
        grayViewForRoundedProfile.addSubview(blackViewForRoundedProfile)
        
        let sizeForImage = sizeForBlack * 0.95
        
        profileImageView.frame.size = CGSize(width: sizeForImage, height: sizeForImage)
        profileImageView.center = CGPoint(x: self.blackViewForRoundedProfile.bounds.midX, y: self.blackViewForRoundedProfile.bounds.midY)
        profileImageView.backgroundColor = .clear
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = UIImage(named:"profile_call")
        
        blackViewForRoundedProfile.addSubview(profileImageView)
    }
    
    fileprivate func roundingUpProfileWithBorders(){
        self.grayViewForRoundedProfile.layer.cornerRadius = grayViewForRoundedProfile.frame.height / 2
        self.grayViewForRoundedProfile.layer.masksToBounds = true
        
        self.blackViewForRoundedProfile.layer.cornerRadius = blackViewForRoundedProfile.frame.height / 2
        self.blackViewForRoundedProfile.layer.masksToBounds = true
        
        self.profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        self.profileImageView.layer.masksToBounds = true
        
    }
}


extension CallViewController{
    
    func handlingUIForCall(){
        if self.isCallStarted {
            self.callStatusLabel.text = "00:00" // timer in-progress left for now
            self.calling(True: true)
        }else{
            if self.isInComingCall{
                self.callStatusLabel.text = "Incoming"
                self.calling(True: false)
            }else{
                self.callStatusLabel.text = "Calling"
                self.calling(True: true)
            }
        }
    }
    
    func calling(True:Bool){
        self.callDeclineImageView.isHidden = True
        self.callDeclineLabel.isHidden = True
        self.callDeclineButton.isHidden = True
        
        self.callAcceptLabel.isHidden = True
        self.callAcceptButton.isHidden = True
        self.callAcceptImageView.isHidden = True
        
        self.callEndButton.isHidden = !True
        self.callEndImageView.isHidden = !True
        
        self.speakerButton.isHidden = !True
        self.speakerLabel.isHidden = !True
        self.speakerImageView.isHidden = !True
        
        self.muteButton.isHidden = !True
        self.muteLabel.isHidden = !True
        self.muteImageView.isHidden = !True
        
        /* self.speakerViewExpandedForCall.isActive = True
         self.speakerViewShrinkedForCall.isActive = !True*/
        
        
    }
    
    func makeTheCallObjectNil() {
        self.audioController.stopPlayingSoundFile()
        if self.sinCallManager.isComingFromCX{
            if let call = sinCallManager.currentCall{
                self.sinCallManager.endingThe(call: call)
            }
        }
        self.sinCallManager.currentCall?.hangup()
        
        self.sinCallManager.currentCall = nil
    }
    
    func answerCall(){
        self.audioController.stopPlayingSoundFile()
        self.sinCallManager.currentCall?.answer()
    }
}
extension CallViewController {
    
}
