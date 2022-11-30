//
//  Endpoints.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/2/22.
//

import Foundation

public typealias Parameters = [String: Any]

enum HTTPMethod: String {
    case GET
    case POST
}


protocol Endpoint{
    
    var baseURL: String {get}
    var URLPath: String {get}
    var headers: [String: String] {get}
    var parameters: Parameters {get}
    var method : HTTPMethod {get}
}

extension Endpoint{
    
    var baseURL: String{
        return "https://listen-api.listennotes.com/api/v2/"
    }
    
    var headers: [String: String]{
        return ["X-ListenAPI-Key": Constants.APIkey]
    }
    
    var defualtParameters: Parameters {
        let defualtParameters = Parameters()
        return defualtParameters
    }
    
}
