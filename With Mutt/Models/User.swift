//
//  User.swift
//  With Mutt
//
//  Created by ASM on 7/30/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import Foundation

class User {
    let userName: String
    var reviews: [Review] = []
    
    init(userName: String) {
        self.userName = userName
    }
}

