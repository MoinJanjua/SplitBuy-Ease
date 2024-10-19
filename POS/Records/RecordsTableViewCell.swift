//
//  RecordsTableViewCell.swift
//  POS
//
//  Created by Maaz on 10/10/2024.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var orderNumLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 18
        // Set up shadow properties
        layer.shadowColor = UIColor.black.cgColor
         layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
       layer.masksToBounds = false
        // Set background opacity
        contentView.alpha = 1.5 // Adjust opacity as needed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
