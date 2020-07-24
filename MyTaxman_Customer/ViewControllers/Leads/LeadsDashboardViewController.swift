//
//  LeadsDashboardViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class LeadsDashboardViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    var serviceDataListArray : [ServicesList] = []
    
    @IBOutlet weak var leadsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isTransparent = true
        isHideNavigationBar = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: leadsCollectionView.frame.width / 2 , height: leadsCollectionView.frame.height / 4 )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        leadsCollectionView!.collectionViewLayout = layout
    }
    
    func setUpCollectionView() {
        leadsCollectionView.register(LeadsCollectionViewCell.nib, forCellWithReuseIdentifier: LeadsCollectionViewCell.identifier)
        leadsCollectionView.delegate = self
        leadsCollectionView.dataSource = self
        leadsCollectionView.backgroundColor = .white
        
        
        serviceDataListArray.append(ServicesList(imageName: "Tax", title: "Tax Returns"))
        serviceDataListArray.append(ServicesList(imageName: "account", title: "Accounting"))
        serviceDataListArray.append(ServicesList(imageName: "plan", title: "Financial Planning"))
        serviceDataListArray.append(ServicesList(imageName: "fund", title: "Super Funds"))
        serviceDataListArray.append(ServicesList(imageName: "Audit", title: "Audit"))
        serviceDataListArray.append(ServicesList(imageName: "legal", title: "Legal Advice"))
    
        titleLabel.setLabelCustomProperties(label: titleLabel, titleText: "What are you looking for?", textColor: ColorManager.textDarkGreenColor.color, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 1, alignment: .center)
     
        
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

extension LeadsDashboardViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceDataListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeadsCollectionViewCell.identifier, for: indexPath) as? LeadsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if !cell.isAnimated {
               UIView.animate(withDuration: 0.5, delay: 0.5 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: indexPath.row % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
                
                if indexPath.row % 2 == 0 {
                    AnimationUtility.viewSlideInFromLeft(toRight: cell)
                }
                else {
                    AnimationUtility.viewSlideInFromRight(toLeft: cell)
                }
                
            }, completion: { (done) in
                cell.isAnimated = true
            })
        }
        cell.setCellData(value: self.serviceDataListArray[indexPath.row])
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedService = self.serviceDataListArray[indexPath.row].title
        switch selectedService {
        case ServiceListKeys.taxReturns.rawValue:
            LeadsManager.shared.choosenService = .taxReturns
            redirectToPageOne()
            break
            
        case ServiceListKeys.accounting.rawValue:
            LeadsManager.shared.choosenService = .accounting
            redirectToNextScreen()
            break
            
        case ServiceListKeys.financialPlanning.rawValue:
            LeadsManager.shared.choosenService = .financialPlanning
            redirectToNextScreen()
            break
            
        case ServiceListKeys.superFunds.rawValue:
            LeadsManager.shared.choosenService = .superFunds
            redirectToNextScreen()
            break
            
            
        case ServiceListKeys.audit.rawValue:
            LeadsManager.shared.choosenService = .audit
            redirectToNextScreen()
            break
            
        case ServiceListKeys.legalAdvice.rawValue:
            LeadsManager.shared.choosenService = .legalAdvice
            redirectToNextScreen()
            break
            
        default: break
            
        }
    }
}

extension LeadsDashboardViewController{
    func redirectToNextScreen() {
        
    }
    
    func redirectToPageOne() {
        let pageOneVC = PageOneViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageOneVC, animated: true)
    }
}
