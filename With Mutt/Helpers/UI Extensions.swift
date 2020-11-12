//
//  UI Extensions.swift
//  With Mutt
//
//  Created by Andrew Struck-Marcell on 11/12/20.
//  Copyright © 2020 ASM. All rights reserved.
//

import UIKit

extension UITextField {
    func addSpaceBeforeText() {
        let leftView = UIView(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        leftView.backgroundColor = .clear
        self.leftView = leftView
        self.leftViewMode = .always
        self.contentVerticalAlignment = .center
    }
}
