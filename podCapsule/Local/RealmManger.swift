//
//  RealmManger.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import RealmSwift

enum RealmError: Error{
    
    case AddError
    case ReadError
    var errorMessage: String {
        
        switch self{
        case .AddError:
            return "Something went wrong when adding information"
        case .ReadError:
            return "Couldn't get these data!"
        }
    }
}

class RealmManger{
    
    static let shared = RealmManger()
    private var realm = try! Realm()
    
    private init(){}
    
    //Read all the data for an object type
    
     func retrieveAllObjects (_ type: Object.Type, completion: @escaping(Result<[Object], Error>) -> () ){
    
        var objects = [Object]()
        let result = realm.objects(type)
        
        guard !result.isEmpty else{
            return completion(.failure(RealmError.ReadError))
        }
        
        for entry in result {
            objects.append(entry)
        }
        
        completion(.success(objects))
    }
    
    private func retrieveAllObjects (_ type: Object.Type) -> [Object]{
        
        var objects = [Object]()
        let result = realm.objects(type)
        
        for entry in result {
            objects.append(entry)
        }
        
        return objects
    }
    
    func replaceAllObjects(_  type: Object.Type, with objects: [Object], completion: @escaping(Result< Bool , Error>) -> ()){
        
        do {
            // try to retrieve and remove all objects
            try realm.write{
                realm.delete(self.retrieveAllObjects(type))
            }
            //adding new objects
            try add(objects: objects)
            
            completion(.success(true))
        }
        catch{
            completion(.failure(RealmError.AddError))
        }
        
    }
    
    
    func add(object: Object, completion: @escaping(Bool) -> ()){
        
    }
    
    
    func add(objects: [Object], completion: @escaping(Result< Bool , Error>) -> ()){
        
        do {
            
            try realm.write{
                realm.add(objects)
            }
            completion(.success(true))
        }
        catch{
            
            completion(.failure(RealmError.AddError))
        }
    }
    
    
    // private function for internal adding needs
    
    private func add(objects: [Object]) throws {
        
        do{
            try realm.write{
                realm.add(objects)
            }
        }
        catch{
            throw RealmError.AddError
        }
    }
    
}



