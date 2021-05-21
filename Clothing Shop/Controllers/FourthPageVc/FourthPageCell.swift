//
//  FourthPageCell.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit

class FourthPageCell: UITableViewCell {
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var totalpriceLbl: UILabel!
    @IBOutlet weak var logoImageLbl: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
