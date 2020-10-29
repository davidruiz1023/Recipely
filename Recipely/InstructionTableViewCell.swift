//
//  InstructionTableViewCell.swift
//  Recipely
//
//  Created by Mireya Leon on 10/24/20.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var instructionsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
