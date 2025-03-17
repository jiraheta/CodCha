//
//  ListOfUsersModel.swift
//  CodCha
//
//  Created by Jportdev on 6/5/21.
//

import Foundation

class ListOfUsersModel {
    static var sharedModel = ListOfUsersModel()
    func getListOfUsers(completion: @escaping([UsersListModel]?,NetworkResponse) -> Void) {
        Network.shared.getListOfUsersQuery { list ,response in
            if response.success {
                completion( list , NetworkResponse(_success: true, _errorMessage: nil))
            } else {
                completion( list, NetworkResponse(_success: false, _errorMessage: response.error?.message))
            }
        }
    }
}
