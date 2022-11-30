//
//  NetworkManger.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/2/22.
//

import Foundation


class NetworkManger {
    
    static let shared = NetworkManger()
    private init(){}
    
    func callRequest <T:Codable> (objectType: T.Type, endpoint: Endpoint, completion: @escaping (Result<T,Error>) -> ()){

        URLRequestHandler.sharedInstanse.startRequest(endPoint: endpoint, objectType: objectType, completion: { (response) in

            switch response{
            
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
        
    }
    
    
}
