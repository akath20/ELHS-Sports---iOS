//
//  MessagesTableViewCell.swift
//  ELHS Sports
//
//  Created by Alex Atwater on 4/7/15.
//  Copyright (c) 2015 Alex Atwater. All rights reserved.
//

import UIKit

@objc class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        [messageLabel .sizeToFit()];
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
