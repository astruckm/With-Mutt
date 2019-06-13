//
//  Business.swift
//  With Mutt
//
//  Created by ASM on 6/12/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import Foundation
import CoreLocation

enum BusinessType {
    case restaurant
    case hotel
    case event
}

struct Business {
    let name: String
    let location: CLLocation
    let type: BusinessType
    let userReview: Review
    var reviews: [Review]
}

struct Review {
    let text: String
    var score: Int {
        didSet {
            score = abs(oldValue % 5) ///Constrain the score from 0-5
        }
    }
}

struct User {
    
}
