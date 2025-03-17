//
//  ViewController.swift
//  CodCha
//
//  Created by Jportdev on 6/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    private var currentPass: String?
    private var currentUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard(_:)))
            self.view.addGestureRecognizer(tapGesture)
    }
    
    //Username validation as they enter the username
    //if the user enters anything else than a letter or underscore
    //it will trigger a UI alert contoller to let the user know
    //they can only enter characters and underscore for a user.
    //futher more deletes the characters that triggers this alert.
    @IBAction func usernameTxtFieldEditingChanged(_ sender: UITextField) {
        username.becomeFirstResponder()
        var content = sender.text!
        currentUser = content
        if !((sender.text?.isAlphanumeric)!) {
            let alert = UIAlertController(title: "Error", message: "Only characters and underscore.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            if !content.isEmpty{
                self.present(alert, animated: true, completion: nil)
                content.removeLast()
                username.text = content
            }
        }
    }
    
    @IBAction func passwordTxtFieldEditingChanged(_ sender: UITextField) {
        password.becomeFirstResponder()
        if !(sender.text!.isEmpty){
            currentPass = sender.text!
        }else{
            currentPass = ""
        }
        
    }
    
    @IBAction func singInValidation() {
        //MARK: TODO: uncommend once we are done working.
        //I did not have time to make a helper file for the alert.
        //so I reused the one from the user validation field.
        //alert message implementation
        let alert = UIAlertController(title: "Error", message: "Wrong Username or Password, Try again!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        //fetching the user from the password typed.
        let ret = KeychainWrapper.standard.string(forKey: currentPass!) ?? ""
        // validating that the user typed and the user retrieve are the same.
        // if they are  we push the view.
        if (ret == ""){
            self.present(alert, animated: true, completion: nil)
        }else{
            if (currentUser! != "" && currentUser! == ret){
                //pushing view after validation
                let listVC = (storyboard?.instantiateViewController(identifier: GlobalConstants().LoginToListOfUsers)) as! ListOfUserViewController
                self.navigationController?.pushViewController(listVC, animated: true)
            }else{
                self.present(alert, animated: true, completion: nil)
            }

        }
        
        //uncomment to bypass login credentials
        //pushing view without validation
        //let listOfUsersVC = (storyboard?.instantiateViewController(identifier: GlobalConstants().LoginToListOfUsers)) as! ListOfUserViewController
        //self.navigationController?.pushViewController(listOfUsersVC, animated: true)
    }
    
    @objc func dissmissKeyboard(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }

}

//regex for username validation.
extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z_]", options: .regularExpression) == nil
    }
}
