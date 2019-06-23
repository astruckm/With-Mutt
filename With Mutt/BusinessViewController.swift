//
//  BusinessSelectionViewController.swift
//  With Mutt
//
//  Created by ASM on 6/23/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class BusinessSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BusinessType.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessType", for: indexPath) as! BusinessTypeCell
        let label = BusinessType.allCases[indexPath.row].label
        cell.businessTypeName.text = label
        if label == "ホテル" {
            cell.businessTypeIcon.image = UIImage(named: "bed")
        } else {
            cell.businessTypeIcon.image = UIImage()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            //assign search target to be BusinessType.allCases[indexPath.row] (but have some data structure for that
        }
    }


}
