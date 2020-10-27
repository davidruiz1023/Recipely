//
//  IngredientTableViewCell.swift
//  Recipely
//
//  Created by Mireya Leon on 10/24/20.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var metricLabel: UILabel!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
