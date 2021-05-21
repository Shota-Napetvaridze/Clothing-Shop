//
//  SecondPageVc.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit


struct Human{
    var type = ""
    var clothes :[ClothingType]
}
struct ClothingType{
    var clothingCategory = ""
    var discount = 0
    var count = 0
    var brand :[Brand]
}

struct Brand{
    var clothesImage = ""
    var name = ""
    var price = 0
    var discountPrice = 0
    var savedMoney = 0
    var clothesCount = 0
}

class SecondPageVc: UIViewController, UITableViewDelegate, UITableViewDataSource, cloathingDelegate{
    
    @IBOutlet weak var secVCtableView: UITableView!
    @IBOutlet weak var payLbl: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var savedMoneyLbl: UILabel!
    
    var updatedClothesArray = [Human]()
    var boughtClothes = Array<Brand>()
    
    var totalQuantity = 0
    var totalPrice = 0
    var totalSaved = 0
   
    var indexForChange : IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadPage()
        createClothes()
        calculateData()
    }
    
    
    //MARK:- Functions
    
    func sendClothes(model: [Brand]) {
        updatedClothesArray[indexForChange.section].clothes[indexForChange.row].brand = model
        calculateData()
        secVCtableView.reloadData()
    }
    func clearList(){
        createClothes()
        calculateData()
    }
    
    func calculateData(){
        boughtClothes = []
        totalQuantity = 0
        totalPrice = 0
        totalSaved = 0
        for cloth in updatedClothesArray {
            for cl in cloth.clothes {
                for c in cl.brand {
                    if c.discountPrice > 0{
                        totalSaved += c.clothesCount*(c.price*cl.discount/100)
                        totalQuantity += c.clothesCount
                        totalPrice += (c.price-(c.price * cl.discount/100))*c.clothesCount
                    }else{
                        totalSaved += c.clothesCount*(c.price*cl.discount/100)
                        totalQuantity += c.clothesCount
                        totalPrice += (c.price-(c.price * cl.discount/100))*c.clothesCount
                    }
                    if c.clothesCount > 0{
                        boughtClothes.append(c)
                    }
                }
            }
        }
        savedMoneyLbl.text = "\(totalSaved) $"
        totalPriceLbl.text = "\(totalPrice) $"
        quantityLbl.text = "\(totalQuantity)"
    }
    func createClothes(){
        // ManShirts
        let shirt1 = Brand(clothesImage: "blackShirt", name: "blackShirt", price: 100, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let shirt2 = Brand(clothesImage: "whiteShirt", name: "whiteShirt", price: 101, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let allManShirts = [shirt1,shirt2]
        let manClothingType1 = ClothingType(clothingCategory: "Shirt", discount: 20, count: 0, brand: allManShirts)
        
        // ManTrousers
        let trouser1 = Brand(clothesImage: "blackTrouser", name: "blackTrouser", price: 102, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let trouser2 = Brand(clothesImage: "whiteTrouser", name: "whiteTrouser", price: 103, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let allManTrousers = [trouser1,trouser2]
        let manClothingType2 = ClothingType(clothingCategory: "Trouser", discount: 0, count: 0, brand: allManTrousers)

        // WomanDresses
        let dress1 = Brand(clothesImage: "WomanBlackDress", name: "BlackDress", price: 104, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let dress2 = Brand(clothesImage: "WomanWhiteDress", name: "WhiteDress", price: 105, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let allWomanDresses = [dress1,dress2]
        let womanClothingType1 = ClothingType(clothingCategory: "Dress", discount: 75, count: 0, brand: allWomanDresses)

        // WomanHats
        let hat1 = Brand(clothesImage: "WomanBlackHat", name: "BlackHat", price: 106, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let hat2 = Brand(clothesImage: "WomanWhiteHat", name: "WhiteHat", price: 107, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let allWomanHats = [hat1,hat2]
        let womanClothingType2 = ClothingType(clothingCategory: "Hat", discount: 0, count: 0, brand: allWomanHats)

        // ChildDresses
        let dress3 = Brand(clothesImage: "childBlackDress", name: "Black Dress", price: 108, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let dress4 = Brand(clothesImage: "childWhiteDress", name: "White Dress", price: 109, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let allChildDresses = [dress3,dress4]
        let childClothingType1 = ClothingType(clothingCategory: "Dress", discount: 75, count: 0, brand: allChildDresses)
        
        // ChildHats
        let hat3 = Brand(clothesImage: "childBlackHat", name: "Black Hat", price: 110, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let hat4 = Brand(clothesImage: "childWhiteHat", name: "White Hat", price: 111, discountPrice: 0, savedMoney: 0, clothesCount: 0)
        let allChildHats = [hat3,hat4]
        let childClothingType2 = ClothingType(clothingCategory: "Hat", discount: 0, count: 0, brand: allChildHats)
        
        let manSection = Human(type: "MAN", clothes: [manClothingType1,manClothingType2])
        let womanSection = Human(type: "WOMAN", clothes: [womanClothingType1,womanClothingType2])
        let childSection = Human(type: "CHILD", clothes: [childClothingType1,childClothingType2])
        
        updatedClothesArray = [manSection,womanSection,childSection]
        secVCtableView.reloadData()
    }
    func loadPage(){
    payLbl.layer.cornerRadius = 15
    secVCtableView.dataSource = self
    secVCtableView.delegate = self
}
    
    
    //MARK:-Pay Button

    @IBAction func payAction(_ sender: Any) {
        let fourthPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FourthPageVc") as! FourthPageVc
        fourthPage.selectedClothes = boughtClothes
        fourthPage.selectedHuman = updatedClothesArray
        fourthPage.selectedDiscount = updatedClothesArray[indexForChange.section].clothes
        fourthPage.totalPrice = totalPrice
        fourthPage.totalQuantity = totalQuantity
        self.present(fourthPage, animated: true, completion: nil)
    }
    
    //MARK:-TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        updatedClothesArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updatedClothesArray[section].clothes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondPageCell", for: indexPath)as! SecondPageCell
        
        let currentClothingType = updatedClothesArray[indexPath.section].clothes[indexPath.row]
        
        cell.clothingTypeLbl.text = currentClothingType.clothingCategory
        
        if currentClothingType.discount > 0{
            cell.discountLbl.isHidden = false
            cell.discountLbl.text = "-\(currentClothingType.discount)%"
        }else{
            cell.discountLbl.isHidden = true
        }
        
        var count = 0
        for i in currentClothingType.brand{
            cell.trashLbl.isHidden = count > 0 ? false : true
            count += i.clothesCount
        }
        cell.countLbl.text = "\(count)"
        
        switch updatedClothesArray[indexPath.section].type {
        case "MAN":
            cell.uiImageView.layer.cornerRadius = 20
            cell.uiImageView.layer.borderColor = UIColor.gray.cgColor
            cell.countLbl.textColor = .gray
            cell.uiImageView.layer.borderWidth = 3
        case "WOMAN":
            cell.uiImageView.layer.cornerRadius = 20
            cell.uiImageView.layer.borderColor = UIColor.red.cgColor
            cell.countLbl.textColor = .red
            cell.uiImageView.layer.borderWidth = 3
        default:
            cell.uiImageView.layer.cornerRadius = 20
            cell.uiImageView.layer.borderColor = UIColor.blue.cgColor
            cell.countLbl.textColor = .blue
            cell.uiImageView.layer.borderWidth = 3
        }
        cell.eraseDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch updatedClothesArray[indexPath.section].type {
        case "MAN":
            return 80
        case "WOMAN":
            return 100
        default:
            return 120
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView =  Bundle.main.loadNibNamed("secondVcHeader", owner: nil, options: nil)![0] as! secondVcHeader
        let currentPerson = updatedClothesArray[section]
        headerView.humanTypeLbl.text = currentPerson.type
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thirdPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ThirdPageVc") as! ThirdPageVc
        
        let currentBrand = updatedClothesArray[indexPath.section].clothes[indexPath.row].brand
        let currentModel = updatedClothesArray[indexPath.section].clothes[indexPath.row
        ].clothingCategory
        let currentDiscount = updatedClothesArray[indexPath.section].clothes[indexPath.row]
        
        thirdPage.allClothesArr = currentBrand
        thirdPage.pageHumanText = updatedClothesArray[indexPath.section].type
        thirdPage.pageClothingText = currentModel
        
        thirdPage.clothingTypeArr = [currentDiscount]
        thirdPage.humanArr = [updatedClothesArray[indexPath.section]]

        indexForChange = indexPath

        thirdPage.choosenModelDelegate = self
        self.navigationController?.pushViewController(thirdPage, animated: true)
    }
}

//MARK:- Erase Button
extension SecondPageVc: eraseDataDelegate{
    func erase(cell: UITableViewCell) {
        clearList()
    }
}
