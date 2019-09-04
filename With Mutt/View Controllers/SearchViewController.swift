//
//  SearchViewController.swift
//  With Mutt
//
//  Created by ASM on 7/16/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var businessTypeIcon: UIImageView!
    @IBOutlet weak var businessTypeSelect: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var businessTypesContainerView: UIView!
    @IBOutlet weak var autocompleteTableView: UITableView!
    
    let cellHeight: CGFloat = 64
    let locationService = WithMuttLocationService()
    var autocompleteResults: [Business] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchTextField()
        autocompleteTableView.tableFooterView = UIView()
        autocompleteTableView.separatorStyle = .none
    }
    
    func configureSearchTextField() {
        let buttonWidth: CGFloat = searchTextField.bounds.width / 16
        let buttonHeight: CGFloat = searchTextField.bounds.height / 2
        let insetLeft: CGFloat = 10
        
        let clearButtonFrame = UIView(frame: CGRect(x: -insetLeft, y: 0, width: buttonWidth + insetLeft, height: buttonHeight))
        let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        clearButton.setImage(UIImage(named: "times"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        clearButtonFrame.addSubview(clearButton)
        
        searchTextField.rightView = clearButtonFrame
        searchTextField.rightViewMode = .always
    }
    
    @objc func clearButtonTapped() {
        dismiss(animated: false, completion: nil)
    }
    


}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("should clear")
        dismiss(animated: false, completion: nil)
        return true
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return autocompleteResults.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: cellHeight))
        let labelHeight: CGFloat = cellHeight/3
        let label = UILabel(frame: CGRect(x: 0, y: 0/*(cellHeight/2 - labelHeight/2*/, width: 64, height: labelHeight))
        label.text = "つつつ"
        label.font = UIFont(name: "HiraginoSans-W6", size: 22)
        label.textColor = .lightGray
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        label.widthAnchor.constraint(equalToConstant: 96).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentLocationCell", for: indexPath) as! CurrentLocationTableViewCell
            cell.currentLocation.textColor = .lightGray
            cell.currentLocation.font = UIFont(name: "HiraginoSans-W6", size: 22)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath) as! SearchResultsTableViewCell
        cell.result.textColor = .lightGray
//        cell.result.text = autocompleteResults[indexPath.row].shortenedName ?? autocompleteResults[indexPath.row].name
        cell.result.font = UIFont(name: "HiraginoSans-W6", size: 22)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Go to business's page
        
        if indexPath.row == 0 {
            //Use current location
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
