//
//  GlobalConstants.swift
//  CodCha
//
//  Created by Jportdev on 6/5/21.
//

import Foundation

struct GlobalConstants {
    
    static let shared = GlobalConstants()
    
    // MARK: SEGUES IDENTIFIERS
    
    // MARK: ViewControllers
    let LoginToListOfUsers = "ListOfUserViewController"
    let UserDetails = "UserDetailsViewController"
    
    // MARK: ENDPOINT
    let endpoint = "https://dummyapi.io/data/graphql"
    let websocket = "wss://dummyapi.io/data/graphql"
    
    // MARK: TOKEN
    //ideally we would have some time of process to fetch the App-id
    //and store it in the keychain. But for the time being and the
    //time constrains we will hard code it.
    let appid = "60bb30dc2ad52d71266dbbb8"
    
}
