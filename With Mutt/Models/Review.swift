//
//  Review.swift
//  With Mutt
//
//  Created by ASM on 7/30/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import Foundation


struct Review {
    let text: String
    var score: Int {
        didSet {
            score = abs(score % 5) ///Constrain the score from 0-5
        }
    }
}

