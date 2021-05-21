//
//  FirstPageVc.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit

enum LoginErrors: Error{
    case notCompleteFilled
    case noEmailFormat
    case shortPassword
    case wrongPassword
}

class FirstPageVc: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var EnterOutlet: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        EnterOutlet.layer.cornerRadius = 10
    }
    @IBAction func EnterAction(_ sender: Any) {
        do {
            try EnterAction()
        } catch LoginErrors.notCompleteFilled {
            myalert.showAlert(title: "Incomplete Data", message: "Please Fill In", vc: self)
        }catch LoginErrors.noEmailFormat {
                myalert.showAlert(title: "Incorrect Email", message: "Please Fill In The Field In The Right Order", vc: self)
        }catch LoginErrors.shortPassword {
                myalert.showAlert(title: "Short Password", message: "Enter At Least 8 Symbols", vc: self)
        }catch LoginErrors.wrongPassword {
                myalert.showAlert(title: "Incorrect Password", message: "Enter The Correct Password", vc: self)
        }catch{
            myalert.showAlert(title: "other", message: "other error", vc: self)
        }
        let pushSecondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondPageVc") as! SecondPageVc
        self.navigationController?.pushViewController(pushSecondVC, animated: true)
    }
        
    // throwing function-> throws
        
    func EnterAction() throws{
        let email = emailField.text!
        let password = passwordField.text!
        
        if email.count == 0 || password.count == 0{
            throw LoginErrors.notCompleteFilled
        }
        if isValidEmail(email: email) == false{
            throw LoginErrors.noEmailFormat
        }
        if password.count < 8{
            throw LoginErrors.shortPassword
        }
        if passwordField.text != "12345678"{
            throw LoginErrors.wrongPassword
        }
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
