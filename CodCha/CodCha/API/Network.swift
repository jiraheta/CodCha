//
//  Network.swift
//  CodCha
//
//  Created by Jportdev on 6/5/21.
//

import Foundation
import Apollo

struct ErrorMessage: Error{
    let title: String = "Error"
    var message: String
    init(_ message: String) {
        self.message = message
    }
}

struct NetworkResponse {
    var success: Bool
    var error: ErrorMessage?
    init(_success: Bool, _errorMessage: String?) {
        self.success = _success
        if let errorMessage = _errorMessage {
            self.error =  ErrorMessage(errorMessage)
        }
    }
}

// MARK: Extension for Apollo to work with headers
class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        request.addHeader(name: "app-id", value: GlobalConstants().appid)
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
        //print("request :\(request)")
        //print("response :\(String(describing: response))")
        chain.proceedAsync(request: request,
                                   response: response,
                                   completion: completion)
    }
}
    
class Network{
    static let shared = Network()
    //auth with api code
    private(set) lazy var apollo: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        //let token = UserDefaults.standard.value(forKey: GlobalConstants().appid)
        let authPayloads = ["Authorization": "Bearer \(GlobalConstants().appid)"]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = authPayloads
        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let provider = NetworkInterceptorProvider(client: client, shouldInvalidateClientOnDeinit: true, store: store)
        let url = URL(string: GlobalConstants().endpoint)!
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
    
    public func getListOfUsersQuery(completion: @escaping([UsersListModel]? ,NetworkResponse) -> Void){
        Network.shared.apollo.fetch(query: ListOfUsersQuery()){ response in
            //print("============= \(response) =============")
            
            /*MARK TODO: find out why there is nil response before we get the paidload.
                         due to the constrain of time this is a hotfix.
            */
            let res = String("\(response)")
            if (res.contains("failure")){
            } else {
                switch(response) {
                case .success(let result):
                    if let errors = result.errors , !errors.isEmpty {
                        let returningFailure = NetworkResponse(_success: false, _errorMessage: errors.first?.message)
                        completion(nil, returningFailure)
                    } else {
                        
                        var list = [UsersListModel]() //Array of listOfUsers
                        guard let data = result.data?.users else { return }
                        let limit = result.data?.users.limit ?? 0
                        let total = result.data?.users.total ?? 0
                        let page = result.data?.users.page ?? 0
                        let offset = result.data?.users.offset ?? 0
                        if result.data != nil {
                            for user in data.data!{
                                let id = user?.id ?? ""
                                let title = user?.title ?? ""
                                let firstName = user?.firstName ?? ""
                                let lastName = user?.lastName ?? ""
                                let user = UserModel(_id: id, _title: title, _firstName: firstName, _lastName: lastName)
                                list.append(UsersListModel(_page: page, _limit: limit, _data: user, _total: total, _offset: offset))
                            }
                        } else {
                            completion(nil, NetworkResponse(_success: false, _errorMessage: "An error occured with the Network."))
                        }
                        completion(list, NetworkResponse(_success: true, _errorMessage: nil))
                    }
                case .failure(let error):
                    print("Error loading data from ListOfUsersQuery() \(error)")
                }
            }
        }
    }
    
    public func getUsersDetailsQuery(userID: String, completion: @escaping(UserModel? ,NetworkResponse) -> Void){
        Network.shared.apollo.fetch(query: UserInfoQuery(id: userID)){ response in
            //print("============= \(response) =============")
            /*MARK TODO: find out why there is nil response before we get the paidload.
                         due to the constrain of time this is a hotfix.
            */
            let res = String("\(response)")
            if (res.contains("failure")){
            } else {
                switch(response) {
                case .success(let result):
                    if let errors = result.errors , !errors.isEmpty {
                        let returningFailure = NetworkResponse(_success: false, _errorMessage: errors.first?.message)
                        completion(nil, returningFailure)
                    } else {
                        var userDetails: UserModel?
                        guard let data = result.data else { return }
                        if result.data?.user != nil {
                            let id = data.user?.id ?? ""
                            let title = data.user?.title ?? ""
                            let firstName = data.user?.firstName ?? ""
                            let lastName = data.user?.lastName ?? ""
                            let gender = data.user?.gender ?? ""
                            let email = data.user?.email ?? ""
                            let phone = data.user?.phone ?? ""
                            let picture = data.user?.picture ?? ""
                            let regDate = data.user?.registerDate ?? ""
                            let DOB = data.user?.dateOfBirth ?? ""
                            userDetails = UserModel(_id: id, _title: title, _firstName: firstName, _lastName: lastName, _gender: gender, _email: email, _phone: phone, _picture: picture, _registrationDate: regDate, _dateOfBirth: DOB)
                            }
                        completion(userDetails, NetworkResponse(_success: true, _errorMessage: nil))
                    }
                case .failure(let error):
                    print("Error loading data from ListOfUsersQuery() \(error)")
                }
            }
        }
    }
}


