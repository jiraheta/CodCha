//
//  UsersListModel.swift
//  CodCha
//
//  Created by Jportdev on 6/5/21.
//

import Foundation
class UsersListModel {
    init(_page: Int,
         _limit: Int,
         _data: UserModel,
         _total: Int,
         _offset: Int) {
        self.page = _page
        self.limit = _limit
        self.data = _data
        self.total = _total
        self.offset = _offset
    }
    var page: Int = 0
    var limit: Int = 0
    var data: UserModel
    var total: Int = 0
    var offset: Int = 0
        
}
