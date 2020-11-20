//
//  BusinessSelectionViewController.swift
//  With Mutt
//
//  Created by ASM on 6/23/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class BusinessSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var businessTypeTableView: UITableView!
    var rowHeight: CGFloat = 44
    var businessTypeDelegate: CurrentBusinessTypeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessTypeTableView.tableFooterView = UIView()
        businessTypeTableView.separatorStyle = .none
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BusinessType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(BusinessType.allCases.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row <= BusinessType.allCases.count - 1 else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessType", for: indexPath) as! BusinessTypeCell
        let label = BusinessType.allCases[indexPath.row].label
        let image = BusinessType.allCases[indexPath.row].image
        cell.businessTypeName.text = label
        cell.businessTypeIcon.image = image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row <= BusinessType.allCases.count - 1 else { return }
        let parentVC = self.parent
        let selectedBusinessType = BusinessType.allCases[indexPath.row]
        businessTypeDelegate?.currentSelectedBusinessType = selectedBusinessType

        if let homeVC = parentVC as? HomeViewController {
            homeVC.currentSelectedBusinessType = selectedBusinessType
            homeVC.businessTypeIcon.image = selectedBusinessType.image
            homeVC.businessTypesViewShouldShow = false
            homeVC.animateBusinessTypes()
        } else if let searchVC = parentVC as? SearchViewController {
            searchVC.currentSelectedBusinessType = selectedBusinessType
            searchVC.businessTypeIcon.image = selectedBusinessType.image
            searchVC.businessTypesViewShouldShow = false
            searchVC.animateBusinessTypes()
        }
    }
    
    
}
