//
//  VideoCallViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 05/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Sinch

class VideoCallViewController: BaseViewController {
    
    @IBOutlet weak var callerNameLabel: UILabel!
    @IBOutlet weak var callStatusLabel: UILabel!
    @IBOutlet weak var remoteVideoView: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var hangupBtn: UIButton!
    @IBOutlet weak var localVideoView: UIView!
    
    fileprivate var sinCallManager : SinCallManager!
    fileprivate var callProvider : CallProviderDelegate? {
        return AppDelegate.shared.callProviderDelegate
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // setViewUI()
        
    
    
        
        
       /* view = mainView
        
        self.mainView.videoView.addSubview(self.videoController.localView())
        self.videoController.localView().contentMode = .scaleToFill
        if sinCallManager.currentCall?.direction == SINCallDirection.incoming {
       // self.audioController.startPlayingSoundFile(self.pathForSound("incoming.wav") as String, loop: true)
        }
        if AppDelegate.shared.sinCallManager?.currentCall?.details.isVideoOffered  == true {
        print("video offered")
        self.mainView.videoView.addSubview(self.videoController.localView())
            self.videoController.localView().contentMode = .scaleToFill
        }
        mainView.videoView.addSubview(self.videoController.localView())
        mainView.answerButton.addTarget(self, action: #selector(answer), forControlEvents: .TouchUpInside)
        mainView.declineButton.addTarget(self, action: #selector(decline), forControlEvents: .TouchUpInside)*/
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
      self.audioController.enableSpeaker()
        
    }
    func answer() {
        AppDelegate.shared.sinCallManager?.currentCall?.answer()
    }
    func decline() {
  AppDelegate.shared.sinCallManager?.currentCall?.hangup()
    }
    
    func setViewUI() {
        self.sinCallManager = AppDelegate.shared.sinCallManager
        //call.delegate = self
        
        /* callerNameLabel.setLabelCustomProperties(titleText: call.remoteUserId ?? "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(25.0)), numberOfLines: 0, alignment: .center)
         
         callStatusLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .center)*/
        
        if sinCallManager.currentCall?.direction == .incoming{
            
            print(sinCallManager.client)
            print(sinCallManager.currentCall)
            print(sinCallManager.currentCallStatus)
            
            /*  self.isInComingCall = true
             self.nameLabel.text = sinCallManager.currentCall!.remoteUserId!
             self.audioController.startPlayingSoundFile(path(forSound: "incoming"), loop: true)
             self.isCallStarted = sinCallManager.isComingFromCX
             if isCallStarted {
             answerCall()
             }*/
            
        }else {
            //self.audioController.startPlayingSoundFile(path(forSound: "ringback"), loop: true)
            self.callerNameLabel.text = "Vanithasree"
            self.videoController.localView().contentMode = .scaleToFill
        }
        self.sinCallManager.currentCall?.delegate = self
        
        self.localVideoView.isHidden = false
        self.remoteVideoView.isHidden = false
        
        
        
        
        /*   print(call?.remoteUserId!)
         print(call.userInfo)
         
         if call.direction == .incoming
         {
         callStatusLabel.text = "Incoming"
         
         }
         else
         {
         callStatusLabel.text = "Calling..."
         
         }*/
        //  Converted to Swift 5.2 by Swiftify v5.2.19376 - https://swiftify.com/
        // localVideoView.addSubview(videoController.localView())
        //   localVideoFullscreenGestureRecognizer.require(toFail: switchCameraGestureRecognizer)
        //   localVideoFullscreenGestureRecognizer.require(toFail: pauseResumeVideoRecognizer)
        //    videoController().localView().addGestureRecognizer(localVideoFullscreenGestureRecognizer)
        //  videoController.localView().addGestureRecognizer(pauseResumeVideoRecognizer)
        //  videoController().remoteView().addGestureRecognizer(remoteVideoFullscreenGestureRecognizer)
        //  videoPaused = false
        
        if AppDelegate.shared.sinCallManager?.currentCall?.details.isVideoOffered == true {
            
            localVideoView.addSubview(self.videoController.localView())
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
    
    @IBAction func onTapDeclineBtn(_ sender: UIButton) {
        
    }
    @IBAction func onTapHangUpBtn(_ sender: UIButton) {
    }
    @IBAction func onTapAcceptBtn(_ sender: UIButton) {
    }
}
extension VideoCallViewController : SINCallDelegate, SINCallClientDelegate {
    func callDidProgress(_ call: SINCall)
    {
           print("Call progress")
        callStatusLabel.text = "Ringing..."
        //        callStatusLabel.text = "Ringing..."
        //        audioController.startPlayingSoundFile(pathForSound("ringback.wav"), loop: true)
    }
    
    func callDidEstablish(_ call: SINCall)
    {
        print("Call connected")
        //        startCallDurationTimerWithSelector(#selector(CallViewController.onDurationTimer(_:)))
        //        self.getCallButtonStatus = .hangup
        //        self.setButtonAlignmentBasedOnCallStatus()
        //        audioController.stopPlayingSoundFile()
    }
    
    func callDidEnd(_ call: SINCall)
    {
        print("Call ended")
        self.navigationController?.popViewController(animated: true)
        
        //        audioController.stopPlayingSoundFile()
        //        stopCallDurationTimer()
        //        self.dismiss(animated: true, completion: nil)
        
    }
    func callDidAddVideoTrack(_ call: SINCall!) {
        self.remoteVideoView.addSubview(self.videoController.remoteView())
        self.remoteVideoView.isHidden = true
    }
    
    func callDidPauseVideoTrack(_ call: SINCall!) {
        self.remoteVideoView.isHidden = true
    }
    
    func callDidResumeVideoTrack(_ call: SINCall!) {
        self.remoteVideoView.isHidden = false
    }
    
}
