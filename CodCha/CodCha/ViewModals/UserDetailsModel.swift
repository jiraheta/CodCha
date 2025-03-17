//
//  UserDetailsModel.swift
//  CodCha
//
//  Created by Jportdev on 6/6/21.
//

import Foundation

class UserDetailsModel {
    static var sharedModel = UserDetailsModel()
    func getListOfUsers(userID: String, completion: @escaping(UserModel?,NetworkResponse) -> Void) {
        Network.shared.getUsersDetailsQuery(userID: userID) { (user ,response) in
            if response.success {
                completion(user , NetworkResponse(_success: true, _errorMessage: nil))
            } else {
                completion(user, NetworkResponse(_success: false, _errorMessage: response.error?.message))
            }
        }
    }
}
