//
//  URLRequest.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/2/22.
//

import Foundation


class URLRequestHandler{
    
    var hostURL: URL?
    var absoluteURL : URL?
    var parameters: Parameters?
    var headers: [String: String] = [:]
    var httpMethod: HTTPMethod = .GET
    var queryParameters: URLComponents?
    var request: URLRequest?
    
    static let sharedInstanse = URLRequestHandler()
    
    func startRequest <T:Codable> (endPoint: Endpoint, objectType: T.Type, completion: @escaping(Result<T, Error>) -> ()){
        
        setRequestValue(endPoint: endPoint)
        constructURLParameters()
        
        let request = constructURLRequest()
        startRequestTask(type: objectType, request: request) {(result) in

            switch result {

            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
    
    private func setRequestValue(endPoint: Endpoint){
        
        hostURL = URL(string: endPoint.baseURL)
        absoluteURL = URL(string:endPoint.URLPath,relativeTo: hostURL)!
        parameters = endPoint.parameters
        headers = endPoint.headers
        httpMethod = endPoint.method
        
    }
    
    private func constructURLParameters(){
        
        guard let parameters = parameters else {
            return
        }
        
        var queries = [URLQueryItem]()
    
        for parameter in parameters{
            queries.append(URLQueryItem(name: parameter.key, value: String(describing: parameter.value)))
        }
        var urlCompenent = URLComponents(url: absoluteURL!, resolvingAgainstBaseURL: true)
        urlCompenent?.queryItems = queries
        absoluteURL = urlCompenent?.url

    }
    
    
    private func constructURLRequest() -> URLRequest{

        request = URLRequest(url: absoluteURL!)
        request?.allHTTPHeaderFields = headers
        request?.timeoutInterval = 30
        request?.httpMethod = httpMethod.rawValue
        return request!
    }
    
    private func startRequestTask <T : Codable> (type : T.Type ,
                                                 request: URLRequest ,
                                                 taskCompletion : @escaping(Result<T , Error>) -> Void)
    {
        let task = URLSession.shared.dataTask(with: request) {(data, response , error) in
         
            guard let data = data , error == nil else {
                taskCompletion(.failure(error!))
                return
            }
            
            do {
                
                let result = try JSONDecoder().decode(T.self, from: data)
                taskCompletion(.success(result))

//                let result2 = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(result2)
            }
            catch{
                taskCompletion(.failure(error))
            }
            
        }
        
        task.resume()
    }
}

