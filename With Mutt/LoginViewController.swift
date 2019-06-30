//
//  LoginViewController.swift
//  With Mutt
//
//  Created by ASM on 6/27/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var register: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let cornerRadius: CGFloat = 15.0
        let borderWidth: CGFloat = 2.0
        let borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0).cgColor

        email.layer.cornerRadius = cornerRadius
        password.layer.cornerRadius = cornerRadius
        login.layer.cornerRadius = cornerRadius
        register.layer.cornerRadius = cornerRadius
        
        email.layer.borderWidth = borderWidth
        password.layer.borderWidth = borderWidth
        login.layer.borderWidth = borderWidth
        register.layer.borderWidth = borderWidth
        
        email.layer.borderColor = borderColor
        password.layer.borderColor = borderColor
        login.layer.borderColor = borderColor
        register.layer.borderColor = UIColor(red: 243/255, green: 187/255, blue: 125/255, alpha: 1.0).cgColor
        
        underlineLogoutText()

        //TODO: inset text fields' text
    }
    
    private func underlineLogoutText() {
        let logoutTextAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont(name: "HiraginoSans-W6", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor(red: 185/255, green: 191/25, blue: 179/255, alpha: 0.9),
        ]
        let logoutAttributedString = NSMutableAttributedString(string: "ログインできない場合", attributes: logoutTextAttributes)
        logout.setAttributedTitle(logoutAttributedString, for: .normal)
    }
    
    private func customizeTextFields() {
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        email.leftView = paddingView
        email.leftViewMode = .always
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        //Login here
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        //Logout
    }
    
}
