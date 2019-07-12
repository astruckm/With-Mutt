//
//  MenuTableViewController.swift
//  With Mutt
//
//  Created by ASM on 6/30/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    @IBOutlet var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.tableFooterView = UIView()
        menuTableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = UIColor(red: 244/255, green: 245/255, blue: 243/255, alpha: 1.0)
        header.textLabel?.font = UIFont(name: "HiraginoSans-W6", size: 17)
        header.textLabel?.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 10)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeVC = self.parent as? HomeViewController
        switch indexPath.row {
        case 0: //segue
            break
        case 1:
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            homeVC?.businessTypesViewShouldShow = false
            homeVC?.menuShouldDisplay = false
            homeVC?.businessTypesHeight.constant = 0
            homeVC?.businessTypesWidth.constant = 0
            homeVC?.menuWidth.constant = 0
            //TODO: move these to viewDidLoad of LoginVC?
            homeVC?.present(loginVC, animated: true, completion: nil)
        default: break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
