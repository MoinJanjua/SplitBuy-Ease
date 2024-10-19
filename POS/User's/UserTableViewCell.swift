//
//  UserTableViewCell.swift
//  POS
//
//  Created by Maaz on 09/10/2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
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
        
        makeImageViewCircular(imageView: ImageView)    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func makeImageViewCircular(imageView: UIImageView) {
           // Ensure the UIImageView is square
           imageView.layer.cornerRadius = imageView.frame.size.width / 2
           imageView.clipsToBounds = true
       }

}
