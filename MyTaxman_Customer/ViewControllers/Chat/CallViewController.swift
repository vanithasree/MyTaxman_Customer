//
//  CallViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 03/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Sinch

class CallViewController: UIViewController {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var durationTimer: Timer?
    var call: SINCall!
    
    var audioController:SINAudioController {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        return (appDelegate.client?.audioController())!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        call.delegate = self
        
        print(call?.remoteUserId!)
        print(call.userInfo)
        
        if call.direction == .incoming
        {
            statusLabel.text = "Incoming"
            self.audioController.enableSpeaker()
            self.audioController.startPlayingSoundFile(self.pathForSound("incoming.wav"), loop: true)
        }
        else
        {
            statusLabel.text = "Calling.."
        }
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Sounds
    func pathForSound(_ soundName: String) -> String {
        let resourcePath = Bundle.main.resourcePath! as NSString
        return resourcePath.appendingPathComponent(soundName)
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

extension CallViewController : SINCallDelegate {
    func callDidProgress(_ call: SINCall)
    {
        statusLabel.text = "ringing..."
        audioController.startPlayingSoundFile(pathForSound("ringback.wav"), loop: true)
    }
    
    func callDidEstablish(_ call: SINCall)
    {
        
        //startCallDurationTimerWithSelector(#selector(CallViewController.onDurationTimer(_:)))
        // showButtons(.hangup)
        audioController.stopPlayingSoundFile()
    }
    
    func callDidEnd(_ call: SINCall)
    {
        audioController.stopPlayingSoundFile()
        //stopCallDurationTimer()
        self.dismiss(animated: true, completion: nil)
        
    }
}
