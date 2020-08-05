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


class CallViewController: UIViewController {
    
    @IBOutlet weak var callerNameLabel: UILabel!
    @IBOutlet weak var callStatusLabel: UILabel!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var callStackView: UIStackView!
    
    @IBOutlet weak var hangupBtn: UIButton!
    @IBOutlet weak var hangUpView: UIView!
    
    var durationTimer: Timer?
    var call: SINCall!
    var getCallButtonStatus : ButtonsStatus = .hangup
    
    var audioController:SINAudioController {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        return (appDelegate.client?.audioController())!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewUI()
        
    }
    
    func setViewUI() {
        
        call.delegate = self
        
        callerNameLabel.setLabelCustomProperties(titleText: call.remoteUserId ?? "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(25.0)), numberOfLines: 0, alignment: .center)
        
        callStatusLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .center)
        
        
        acceptBtn.setDarkGreenTheme(btn: acceptBtn, title: "Accept")
        declineBtn.setDarkGreenTheme(btn: declineBtn, title: "Decline")
        
        print(call?.remoteUserId!)
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
        self.setButtonAlignmentBasedOnCallStatus()
    }
    
    func setButtonAlignmentBasedOnCallStatus() {
        if self.getCallButtonStatus == .decline {
            self.callStackView.isHidden = false
            self.hangUpView.isHidden = true
            
        }
        else if self.getCallButtonStatus == .hangup {
            self.callStackView.isHidden = true
            self.hangUpView.isHidden = false
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapDeclineBtn(_ sender: UIButton) {
        self.audioController.disableSpeaker()
        call.hangup()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onTapAcceptBtn(_ sender: UIButton) {
        self.audioController.disableSpeaker()
        self.audioController.stopPlayingSoundFile()
        call.answer()
    }
    
    @IBAction func onTapHangUpBtn(_ sender: UIButton) {
        call.hangup()
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onDurationTimer(_ unused: Timer) {
        let duration = Int(Date().timeIntervalSince(call.details.establishedTime))
        
        DispatchQueue.main.async {
            self.setDuration(duration)
        }
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func setDuration(_ seconds: Int)
    {
        setCallStatusText(String(format: "%02d:%02d", arguments: [Int(seconds / 60), Int(seconds % 60)]))
    }
    
    @objc func internal_updateDurartion(_ timer: Timer)
    {
        
        let selector:Selector = NSSelectorFromString(timer.userInfo as! String)
        
        if self.responds(to: selector)
        {
            self.performSelector(inBackground: selector, with: timer)
        }
        
    }
    
    func startCallDurationTimerWithSelector(_ selector: Selector) {
        let selectorString  = NSStringFromSelector(selector)
        durationTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(CallViewController.internal_updateDurartion(_:)), userInfo: selectorString, repeats: true)
    }
    
    func stopCallDurationTimer() {
        durationTimer?.invalidate()
        durationTimer = nil
    }
    
}

extension CallViewController : SINCallDelegate {
    func callDidProgress(_ call: SINCall)
    {
        callStatusLabel.text = "Ringing..."
        audioController.startPlayingSoundFile(pathForSound("ringback.wav"), loop: true)
    }
    
    func callDidEstablish(_ call: SINCall)
    {
        startCallDurationTimerWithSelector(#selector(CallViewController.onDurationTimer(_:)))
        self.getCallButtonStatus = .hangup
        self.setButtonAlignmentBasedOnCallStatus()
        audioController.stopPlayingSoundFile()
    }
    
    func callDidEnd(_ call: SINCall)
    {
        audioController.stopPlayingSoundFile()
        stopCallDurationTimer()
        self.dismiss(animated: true, completion: nil)
        
    }
}
