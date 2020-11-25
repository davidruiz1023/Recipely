//
//  ShoppingItemTableViewCell.swift
//  Recipely
//
//  Created by Mireya Leon on 11/23/20.
//

import UIKit

class ShoppingItemTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientImageView: UIImageView!
    
    @IBOutlet weak var ingredeintNameLabel: UILabel!
    
    @IBOutlet weak var multiplierLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var unitsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
