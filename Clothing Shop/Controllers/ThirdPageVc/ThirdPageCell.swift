//
//  ThirdPageCell.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit

protocol clothesCellDelegate: class{
    func remove(cell: UITableViewCell)
    func add(cell: UITableViewCell)
}

class ThirdPageCell: UITableViewCell {
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var quanLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var savedMoneyLbl: UILabel!
    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var imageviewborders: UIImageView!
    
    @IBOutlet weak var removeDesign: UIButton!
    @IBOutlet weak var addDesign: UIButton!
    
    
    weak var cloathingDelegate: clothesCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func removeButton(_ sender: Any) {
        cloathingDelegate.remove(cell: self)
    }
    @IBAction func addButton(_ sender: Any) {
        cloathingDelegate.add(cell: self)
    }
    
}

