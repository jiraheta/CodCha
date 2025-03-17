//
//  UserDetailsViewController.swift
//  CodCha
//
//  Created by Jportdev on 6/6/21.
//

import UIKit
class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userRegisterDate: UILabel!
    @IBOutlet weak var userDOB: UILabel!
    var UserDesc: UserModel?
    var userImgURL: String?
    var UserID: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        // wait three seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.loadData()
            //then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadData(){
        UserDetailsModel.sharedModel.getListOfUsers(userID: UserID) { [self] (user, response) in
            if response.success, let data = user {
                self.UserDesc = data
                self.id.text = ("ID: \(UserDesc?.id ?? "N/A")")
                self.userTitle.text = ("Title: \(UserDesc?.title ?? "N/A")")
                self.userFirstName.text = ("First Name: \(UserDesc?.firstName  ?? "N/A")")
                self.userLastName.text = ("Last Name: \(UserDesc?.lastName  ?? "N/A")")
                self.userGender.text = ("Gender: \(UserDesc?.gender  ?? "N/A")")
                self.userEmail.text = ("Email: \(UserDesc?.email  ?? "N/A")")
                self.userPhone.text = ("Phone Number: \(UserDesc?.phone  ?? "N/A")")
                self.userImgURL = UserDesc?.picture  ?? ""
                self.userRegisterDate.text = ("Reg Date: \(UserDesc?.registrationDate  ?? "N/A")")
                self.userDOB.text = ("DOB: \(UserDesc?.dateOfBirth  ?? "N/A")")
                let imgURL = UserDesc?.picture!
                self.UserImage.loadUserImage(url: URL(string: imgURL!)!)
            }else{
                if let error = response.error?.message{
                    print("Error loading User data \(error)")
                }
            }
        }
    }
}

//Extention of UIImageView to fetch image with URL provided.
extension UIImageView {
    func loadUserImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = img
                    }
                }
            }
        }
    }
}
