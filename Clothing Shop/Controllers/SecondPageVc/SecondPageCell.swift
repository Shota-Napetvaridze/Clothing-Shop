//
//  SecondPageCell.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit


protocol eraseDataDelegate: class {
    func erase(cell: UITableViewCell)
}


class SecondPageCell: UITableViewCell {
    
    @IBOutlet weak var clothingTypeLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var trashLbl: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var uiImageView: UIImageView!
    
    
    

    weak var eraseDelegate: eraseDataDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func trashAction(_ sender: Any) {
        eraseDelegate.erase(cell: self)
    }
    
}
