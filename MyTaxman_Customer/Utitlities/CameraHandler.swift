//
//  CameraHandler.swift
//  jps
//
//  Created by vijaykarthik on 15/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import Photos

class CameraHandler : NSObject {
    
    static let shared = CameraHandler()
    fileprivate var currentVC : UIViewController!
    
    let myPickerController = UIImagePickerController()
    
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage,String) -> Void)?
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Camera access is denied",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                        // Handle
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        })
        currentVC.present(alertController, animated: true)
    }
    
    /// Show alert
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    func showAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in })
        alert.addAction(cancel)
        
        let settings = UIAlertAction(title: "Settings", style: .default) { (_) in
            // Take the user to Settings app to possibly change permission.
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        // Finished opening URL
                    })
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(settings)
        
        currentVC.present(alert, animated: true, completion: {})
    }
    
    /// Camera
    func camera(){
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            //already authorized
            openCamera()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    self.openCamera()
                } else {
                    //access denied
                    self.showAlert(title: "Unable to access the Camera", message: "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app.")
                }
            })
        }
        
    }
    
    /// Open Camera
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            self.myPickerController.delegate = self;
            //myPickerController.allowsEditing = true
            self.myPickerController.sourceType = .camera
            //let navigatoinController = UINavigationController(rootViewController: myPickerController)
            
            doOnMain {
                
                self.currentVC.present(self.myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    /// Photo library
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            self.myPickerController.delegate = self;
            self.myPickerController.sourceType = .photoLibrary
            //                myPickerController.navigationController?.navigationBar.tintColor = .blue
            //                                let navigatoinController = UINavigationController(rootViewController: myPickerController)
            
            //                myPickerController.navigationBar.tintColor = .red
            //                myPickerController.navigationBar.barStyle = .blackOpaque // UIBarStyleBlackOpaque;
            //                myPickerController.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black //[UIColor blackColor];
            
            self.myPickerController.navigationBar.isTranslucent = false
            self.myPickerController.navigationBar.barTintColor = .blue // Background color
            self.myPickerController.navigationBar.tintColor = .white // Cancel button ~ any UITabBarButton items
            self.myPickerController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ] // Title color
            
            
            doOnMain {
                
                self.currentVC.present(self.myPickerController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        vc.present(actionSheet, animated: true, completion: nil)
    }
}

extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        /* if let image = info[.originalImage] as? UIImage {
         var name = ""
         if let url = info[UIImagePickerController.InfoKey.UIImagePickerController.InfoKey.phAsset] as? URL {
         let assets = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
         if let firstAsset = assets.firstObject,
         let firstResource = PHAssetResource.assetResources(for: firstAsset).first {
         name = firstResource.originalFilename
         } else {
         name = generateNameForImage()
         }
         } else {
         name = generateNameForImage()
         }*/
        
        
        //obtaining saving path
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let filename = Date().toString(format: "yyyy-MM-dd-HH-mm-ss-SSS")
        let imagePath = documentsPath?.appendingPathComponent("\(filename).jpg")
        
//        print("File path : \(imagePath)")
        // extract image from the picker and save it
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageData = pickedImage.jpegData(compressionQuality: 0.75)
            try! imageData?.write(to: imagePath!)
            self.imagePickedBlock?(pickedImage,imagePath?.absoluteString ?? "")
        }
        
//        let identifier = (info[UIImagePickerController.InfoKey.phAsset] as? PHAsset)?.localIdentifier
//        print(identifier)
        
        //       // self.dismiss(animated: true, completion: nil)
        //
        //
        //            self.imagePickedBlock?(image,name)
        //        } else {
        //            print("Something went wrong")
        //        }
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func generateNameForImage() -> String {
        return "IMG_random_string"
    }
}
/*
 extension UIImagePickerController {
 open override func viewWillLayoutSubviews() {
 super.viewWillLayoutSubviews()
 self.navigationBar.barTintColor = .black
 //        self.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.black
 //        self.navigationBar.topItem?.rightBarButtonItem?.isEnabled = true
 }
 }
 */
