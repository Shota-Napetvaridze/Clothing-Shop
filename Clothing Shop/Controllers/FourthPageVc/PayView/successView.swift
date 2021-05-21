//
//  successView.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit

enum paymentAnswerType{
    case fail
    case success
}

class successView: UIView {

    @IBOutlet weak var answerImage: UIImageView!
    @IBOutlet weak var answerLbl: UILabel!
   
    var viewType: paymentAnswerType!
    
    func initView(type: paymentAnswerType){
        switch type {
        case .fail:
            answerImage.image = UIImage.init(named: "unsuccessful")
            answerLbl.text = "Unsuccessful Payment"
            answerLbl.textColor = .red
        case .success:
            answerImage.image = UIImage.init(named: "successful")
            answerLbl.text = "Successful Payment"
            answerLbl.textColor = .green
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.isHidden = true
        }
    }

}

