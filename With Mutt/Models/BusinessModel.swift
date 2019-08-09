//
//  Business.swift
//  With Mutt
//
//  Created by ASM on 6/12/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit
import CoreLocation

protocol CurrentBusinessTypeDelegate {
    var currentSelectedBusinessType: BusinessType { get set }
}

enum BusinessType: String, CaseIterable, Hashable {
    case restaurant
    case exercise
    case hotel
    case service
    case event
    
    var label: String {
        switch self {
        case .restaurant: return "レストラン"
        case .exercise: return "運動"
        case .hotel: return "ホテル"
        case .service: return "サービス"
        case .event: return "イベント"
        }
    }
    
    var image: UIImage {
        switch self {
        case .restaurant: return #imageLiteral(resourceName: "utensils")
        case .exercise: return #imageLiteral(resourceName: "dog")
        case .hotel: return #imageLiteral(resourceName: "bed")
        case .service: return #imageLiteral(resourceName: "cut")
        case .event: return #imageLiteral(resourceName: "calendar-alt")
        }
    }
}

struct Business {
    let shortenedName: String?
    let name: String
    let location: CLLocation
    let type: BusinessType
    let userReview: Review
    var reviews: [Review]
}


