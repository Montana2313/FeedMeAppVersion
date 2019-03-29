//
//  commentCell.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 30.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {

    
    @IBOutlet weak var usernametext: UILabel!
    @IBOutlet weak var commenttextview: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
