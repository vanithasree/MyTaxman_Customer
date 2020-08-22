//
//  JobMenuOptionViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class JobMenuOptionViewController: BaseViewController {

    @IBOutlet var contentViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet var optionTableView: UITableView!
    @IBOutlet var bgView: UIView!
    var optionList: [String] = []
    var hireBusinessAction : (() ->Void)?
    var viewJobAction : (() ->Void)?
    var cancelJobAction : (() ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        isTransparent = true
        isHideNavigationBar = true
    }
    
    func setupViews(){
        self.view.backgroundColor = ColorManager.darkText.color.withAlphaComponent(0.3)
        
        bgView.backgroundColor = ColorManager.white.color
        bgView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onTapBgView(tapGesture:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        
        optionTableView.register(JobOptionTableViewCell.nib, forCellReuseIdentifier: JobOptionTableViewCell.identifier)
        optionTableView.tableFooterView = UIView()
        optionTableView.backgroundColor = ColorManager.white.color
        doOnMain {
            self.contentViewHeightConstraints.constant = CGFloat((self.optionList.count * 60) + 50)
            self.contentViewHeightConstraints.isActive = true
        }
    }

    @objc func onTapBgView(tapGesture:UITapGestureRecognizer) {
          self.dismiss(animated: true) {}
          //        self.navigationController?.popViewController(animated: true)
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

extension JobMenuOptionViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

extension JobMenuOptionViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : JobOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobOptionTableViewCell.identifier) as? JobOptionTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.optionNameLabel.text = optionList[indexPath.row]
        switch optionList[indexPath.row] {
        case "Hire Business":
            cell.optionImageView.image = UIImage(named: "hire")
            break
        case "View Job Details":
            cell.optionImageView.image = UIImage(named: "viewJob")
            break
        case "Cancel Job":
            cell.optionImageView.image = UIImage(named: "cancel")
            break
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch optionList[indexPath.row] {
        case "Hire Business":
            hireBusinessAction?()
            break
        case "View Job Details":
            viewJobAction?()
            break
        case "Cancel Job":
            cancelJobAction?()
            break
        default:
            break
        }
        self.dismiss(animated: true) {}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
