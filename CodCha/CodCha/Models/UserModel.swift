//
//  UserModel.swift
//  CodCha
//
//  Created by Jportdev on 6/5/21.
//

import Foundation
class UserModel {
    init(_id: String,
         _title: String,
         _firstName: String,
         _lastName: String,
         _gender: String,
         _email: String,
         _phone: String,
         _picture: String,
         _registrationDate: String,
         _dateOfBirth: String) {
        self.id = _id
        self.title = _title
        self.firstName = _firstName
        self.lastName = _lastName
        self.gender = _gender
        self.email = _email
        self.phone = _phone
        self.picture = _picture
        self.registrationDate = _registrationDate
        self.dateOfBirth = _dateOfBirth
    }
    
    init(_id: String,
         _title: String,
         _firstName: String,
         _lastName: String) {
        self.id = _id
        self.title = _title
        self.firstName = _firstName
        self.lastName = _lastName
    }
    var id: String?
    var title: String?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var email: String?
    var phone: String?
    var picture: String?
    var registrationDate: String?
    var dateOfBirth: String?
    
    
}


