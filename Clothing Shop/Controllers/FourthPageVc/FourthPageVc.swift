//
//  FourthPageVc.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit

class FourthPageVc: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var fourthtableView: UITableView!
    @IBOutlet weak var paymentLblLayer: UIButton!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var totalQuantityLbl: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var selectedHuman = Array<Human>()
    var selectedClothes = [Brand]()
    var selectedDiscount = [ClothingType]()
    
    var totalPrice = 0
    var totalQuantity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageLoad()
    }
    
    
    func pageLoad(){
        paymentLblLayer.layer.cornerRadius = 15
        fourthtableView.dataSource = self
        fourthtableView.delegate = self
        totalPriceLbl.text = "\(totalPrice)$"
        totalQuantityLbl.text = "Total.(Q) - \(totalQuantity)"
    }

    
    
    @IBAction func paymentAction(_ sender: Any) {
        indicatorView.isHidden = false
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.indicatorView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.indicatorView.isHidden = true
                self.indicator.stopAnimating()
                let payView = Bundle.main.loadNibNamed("successView", owner: nil, options: nil)![0] as! successView
                payView.frame = self.view.frame
                var answerType = paymentAnswerType.fail
                if self.totalQuantity > 0{
                    answerType = .success
                }
                payView.initView(type: answerType)
                self.view.addSubview(payView)
            }
        }
    }
    
    //MARK:- TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedClothes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FourthPageCell", for: indexPath)as! FourthPageCell
        let purchased = selectedClothes[indexPath.row] //Brand
        
        cell.logoImageLbl.image = UIImage.init(named: purchased.clothesImage)
        cell.modelLbl.text = purchased.name
        cell.quantityLbl.text = "\(purchased.clothesCount)x"
        
        if purchased.savedMoney > 0{
            cell.totalpriceLbl.text = "\((purchased.price*purchased.clothesCount)-purchased.savedMoney) $"
        }else{
            cell.totalpriceLbl.text = "\(purchased.price*purchased.clothesCount) $"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
