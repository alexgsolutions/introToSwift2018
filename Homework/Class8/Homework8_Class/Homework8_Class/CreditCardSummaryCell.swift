//
//  CreditCardSummaryCell.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

class CreditCardSummaryCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardInfoLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var cellBackgroundView: UIView! {
        didSet {
            cellBackgroundView.layer.cornerRadius = 10
        }
    }
    
}
