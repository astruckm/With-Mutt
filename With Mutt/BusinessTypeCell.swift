//
//  BusinessTypeCell.swift
//  With Mutt
//
//  Created by ASM on 6/17/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class BusinessTypeCell: UITableViewCell {
    @IBOutlet weak var businessTypeIcon: UIImageView!
    @IBOutlet weak var businessTypeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
