//
//  ListOfUserViewController.swift
//  CodCha
//
//  Created by Jportdev on 6/4/21.
//

import Foundation
import UIKit

class ListOfUserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var userID = ""
    //MODELS
    var ListUserModel = ListOfUsersModel() //model instance
    var UserList = [UsersListModel]() //array of models
    var loadingData: Bool = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        //call the model method
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
            let child = SpinnerViewController()
            addChild(child)
            child.view.frame = view.frame
            view.addSubview(child.view)
            child.didMove(toParent: self)
            // wait three seconds to simulate some work happening
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.tableView.reloadData()
                //then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        //tableview delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        //hidding back button on navigation bar
        self.navigationItem.setHidesBackButton(true, animated: true)
        //adding navigation button non the navigattion bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    }
    
    //Pops all the views in stack and take us to the rootview controller (login page)
    @objc func logoutTapped(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func loadData(){
        //to load data here
        ListUserModel.getListOfUsers{(models, response) in
            if response.success, let data = models {
                self.UserList = data
                
                if let error = response.error?.message {
                    print("Error loading table data \(error)")
                }
            }
        }
    }
}

extension ListOfUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = UserList[indexPath.row]
        
        userID = user.data.id!
        
        let UserDestailsVC = (storyboard?.instantiateViewController(identifier: GlobalConstants().UserDetails)) as! UserDetailsViewController
        UserDestailsVC.UserID = userID
        self.navigationController?.pushViewController(UserDestailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!

        let user = UserList[indexPath.row]
        let title = user.data.title
        let firstName = user.data.firstName
        let lastName = user.data.lastName
        cell.textLabel?.font = UIFont(name: "Marker Felt", size: 24)
        cell.textLabel?.text = "User: \(title ?? "master"). \(firstName ?? "of") \(lastName ?? "disaster")"
        return cell
        }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastElement = UserList.count - 1
//        if !loadingData && indexPath.row == lastElement {
//            loadingData = true
//            let child = SpinnerViewController()
//            addChild(child)
//            child.view.frame = view.frame
//            view.addSubview(child.view)
//            child.didMove(toParent: self)
//            loadData()
//            // wait three seconds to simulate some work happening
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                self.tableView.reloadData()
//                //then remove the spinner view controller
//                child.willMove(toParent: nil)
//                child.view.removeFromSuperview()
//            }
//            child.removeFromParent()
//        }
//        loadingData = false
//    }
}
