//
//  VideoCallViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 05/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Sinch

class VideoCallViewController: UIViewController {
    
    @IBOutlet weak var callerNameLabel: UILabel!
    @IBOutlet weak var callStatusLabel: UILabel!
    @IBOutlet weak var remoteVideoView: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var hangupBtn: UIButton!
    
    @IBOutlet weak var localVideoView: UIView!
    
    var call: SINCall!
    
    var videoController:SINVideoController {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        return (appDelegate.client?.videoController())!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewUI()
        
    }
    
    func setViewUI() {
        call.delegate = self
        
        callerNameLabel.setLabelCustomProperties(titleText: call.remoteUserId ?? "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(25.0)), numberOfLines: 0, alignment: .center)
        
        callStatusLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .center)
        
        
        print(call?.remoteUserId!)
        print(call.userInfo)
        
        if call.direction == .incoming
        {
            callStatusLabel.text = "Incoming"
            
        }
        else
        {
            callStatusLabel.text = "Calling..."
            
        }
        /*//  Converted to Swift 5.2 by Swiftify v5.2.19376 - https://swiftify.com/
         localVideoView.addSubview(videoController().localView())
         localVideoFullscreenGestureRecognizer.require(toFail: switchCameraGestureRecognizer)
         localVideoFullscreenGestureRecognizer.require(toFail: pauseResumeVideoRecognizer)
         switchCameraGestureRecognizer.require(toFail: pauseResumeVideoRecognizer)
         videoController().localView().addGestureRecognizer(localVideoFullscreenGestureRecognizer)
         videoController().localView().addGestureRecognizer(pauseResumeVideoRecognizer)
         videoController().remoteView().addGestureRecognizer(remoteVideoFullscreenGestureRecognizer)
         videoPaused = false*/
        
        if call.details.isVideoOffered == true {
            localVideoView.addSubview(self.videoController.localView())
            
            // localVideoFullscreenGestureRecognizer.require(toFail: switchCameraGestureRecognizer)
            //self.videoController.localView().addGestureRecognizer(localVideoFullscreenGestureRecognizer)
            //self.videoController.remoteView().addGestureRecognizer(remoteVideoFullscreenGestureRecognizer)
            
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
extension VideoCallViewController : SINCallDelegate {
    func callDidProgress(_ call: SINCall)
    {
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
        self.dismiss(animated: true, completion: nil)
        
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
