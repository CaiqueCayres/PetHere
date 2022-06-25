//
//  Requester.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 30/03/21.
//

import FirebaseFirestore

enum DBCollection: String {
    
    case owners = "Owners"
    case pets = "Pets"
    case tags = "Tags"
    case alerts = "Alerts"
    case registers = "Registers"
}

enum RequestError: Swift.Error {
    case firebase(Error)
    case parser(Error)
    case encoder
    case emptyData
}

class DBRequest {
    
    private static let db = Firestore.firestore()
    
    class func documents<T>(on query: Query,
                            completion: @escaping (Result<T,RequestError>) -> Void) where T: Codable {

        query.getDocuments { (snap, error) in
            if let error = error { completion(.failure(.firebase(error))) }
            completion(decode(snap: snap))
        }
    }
    
    class func record<T>(document: T,
                         on collection: DBCollection,
                         completion: @escaping (Result<T,RequestError>) -> Void) where T: Encodable{
        
        guard let data = encode(object: document) else {
            completion(.failure(.encoder))
            return
        }
        
        db.collection(collection.rawValue).addDocument(data: data) { error in
            if let error = error { completion(.failure(.firebase(error))) }
            completion(.success(document))
        }
    }
    
    private class func decode<T>(snap: QuerySnapshot?) -> Result<T,RequestError> where T: Decodable {
        do {
            guard let snap = snap else { throw RequestError.emptyData }
            let data = try JSONSerialization.data(withJSONObject: snap, options: .prettyPrinted)
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return .failure(.parser(error))
        }
    }
    
    private class func encode<T>(object: T) -> [String: Any]? where T: Encodable {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: .sortedKeys)
            guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { throw RequestError.encoder }
            return json
        } catch {
            return nil
        }
    }
}
