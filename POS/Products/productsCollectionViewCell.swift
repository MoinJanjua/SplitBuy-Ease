//
//  productsCollectionViewCell.swift
//  POS
//
//  Created by Maaz on 09/10/2024.
//

import UIKit

class productsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQunatityLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var producImages: UIImageView!
    @IBOutlet weak var cView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        contentView.layer.cornerRadius = 30
        //     viewShadow(view: curveView)
        
        // Set up shadow properties
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        
        // Set background opacity
        contentView.alpha = 1.5 // Adjust opacity as needed
        
        
    }
}
