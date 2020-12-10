//
//  FavoriteTableViewCell.swift
//  Recipely
//
//  Created by Kevin Guzman on 12/10/20.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
