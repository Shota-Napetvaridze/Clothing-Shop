//
//  ThirdPageVc.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit

protocol cloathingDelegate: class {
    func sendClothes(model: [Brand])
}

class ThirdPageVc: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var modelTypeLbl: UILabel!
    @IBOutlet weak var humanTypeLbl: UILabel!
    @IBOutlet weak var thirdVCtableView: UITableView!
    @IBOutlet weak var readyLbl: UIButton!
    @IBOutlet weak var endBackView: UIImageView!
    
    
    
    var pageHumanText = ""
    var pageClothingText = ""
    var allClothesArr = Array<Brand>()
    var humanArr = Array<Human>()
    
    var clothingTypeArr = Array<ClothingType>()
    
    weak var choosenModelDelegate: cloathingDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadpage()
        thirdVCtableView.reloadData()
    }
    
    func loadpage(){
        humanTypeLbl.text = pageHumanText
        modelTypeLbl.text = pageClothingText.uppercased()
        thirdVCtableView.dataSource = self
        thirdVCtableView.delegate = self
        readyLbl.layer.cornerRadius = 20
        endBackView.layer.cornerRadius = 20
        endBackView.layer.borderColor = UIColor.red.cgColor
        endBackView.layer.borderWidth = 3
    }
    //MARK:- Go_BACK Button
    
    @IBAction func ready(_ sender: Any) {
        choosenModelDelegate.sendClothes(model: allClothesArr)
        self.navigationController?.popViewController(animated: true)
    }

    //MARK:- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allClothesArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdPageCell", for: indexPath)as! ThirdPageCell
        let currentBrand = allClothesArr[indexPath.row]
        let currentDiscount = clothingTypeArr[indexPath.section].discount
        
        cell.modelLbl.text = currentBrand.name
        cell.priceLbl.text = "\(currentBrand.price) $"
        cell.quanLbl.text = "\(currentBrand.clothesCount)"
        cell.modelImage.image = UIImage.init(named: currentBrand.clothesImage)
        
        for d in clothingTypeArr{
            if d.discount > 0{
                cell.discountLbl.isHidden = false
                cell.savedMoneyLbl.isHidden = false
                cell.discountLbl.text = "Discount Price: \(currentBrand.price-(currentBrand.price*currentDiscount/100))"
                cell.savedMoneyLbl.text = "Saved: \(currentBrand.clothesCount*(currentBrand.price*currentDiscount/100))"
            }else{
                cell.discountLbl.isHidden = true
                cell.savedMoneyLbl.isHidden = true
            }
        }

        // Design
        
        cell.removeDesign.layer.cornerRadius = 20
        cell.addDesign.layer.cornerRadius = 20
        
        switch humanArr[indexPath.section].type {
        case "MAN":
            cell.imageviewborders.layer.cornerRadius = 20
            cell.imageviewborders.layer.borderColor = UIColor.gray.cgColor
            cell.quanLbl.textColor = .gray
            cell.imageviewborders.layer.borderWidth = 3
        case "WOMAN":
            cell.imageviewborders.layer.cornerRadius = 20
            cell.imageviewborders.layer.borderColor = UIColor.red.cgColor
            cell.quanLbl.textColor = .red
            cell.imageviewborders.layer.borderWidth = 3
        default:
            cell.imageviewborders.layer.cornerRadius = 20
            cell.imageviewborders.layer.borderColor = UIColor.blue.cgColor
            cell.quanLbl.textColor = .blue
            cell.imageviewborders.layer.borderWidth = 3
        }
    
        cell.cloathingDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
}
//MARK:- MINUS AND PLUS BUTTONS

extension ThirdPageVc: clothesCellDelegate{                       // Minus Button
    func remove(cell: UITableViewCell) {
        let indexPath = thirdVCtableView.indexPath(for: cell)
        if  allClothesArr[indexPath!.row].clothesCount > 0{
            allClothesArr[indexPath!.row].clothesCount -= 1
            let discount = clothingTypeArr[indexPath!.section]
            allClothesArr[indexPath!.row].savedMoney -= allClothesArr[indexPath!.row].price*discount.discount/100
            thirdVCtableView.reloadData()
        }

    }
    func add(cell: UITableViewCell) {                         // Plus Button
        let indexPath = thirdVCtableView.indexPath(for: cell)
        if  allClothesArr[indexPath!.row].clothesCount <= 9{
        allClothesArr[indexPath!.row].clothesCount += 1
            let discount = clothingTypeArr[indexPath!.section]
            allClothesArr[indexPath!.row].savedMoney += allClothesArr[indexPath!.row].price*discount.discount/100
            if allClothesArr[indexPath!.row].clothesCount > 9{
                let outOfStock = Bundle.main.loadNibNamed("stockView", owner: nil, options: nil)![0] as! stockView
                outOfStock.frame = self.view.frame
                self.view.addSubview(outOfStock)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    outOfStock.isHidden = true
                }
            }
        thirdVCtableView.reloadData()
        }
    }
}
