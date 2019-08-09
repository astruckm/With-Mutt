//
//  SearchResultsTableViewCell.swift
//  With Mutt
//
//  Created by ASM on 8/4/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var result: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
