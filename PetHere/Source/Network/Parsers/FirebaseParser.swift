//
//  FirebaseParser.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 31/03/21.
//

import FirebaseFirestore

enum FirebaseParserError: Swift.Error {
    case invalidData
    case invalidKey(key: String)
}

protocol FirebaseParser {

}

extension FirebaseParser {
    func string(withKey key: String, from document: DocumentSnapshot) throws -> String {
        guard let data = document.data() else { throw FirebaseParserError.invalidData }
        guard let string = data[key] as? String else { throw FirebaseParserError.invalidKey(key: key) }
        return string
    }
    
    func bool(withKey key: String, from document: DocumentSnapshot) throws -> Bool {
        guard let data = document.data() else { throw FirebaseParserError.invalidData }
        guard let value = data[key] as? Bool else { throw FirebaseParserError.invalidKey(key: key) }
        return value
    }
    
    func documentReferences(withKey key: String, from document: DocumentSnapshot) throws -> [DocumentReference] {
        guard let data = document.data() else { throw FirebaseParserError.invalidData }
        guard let references = data[key] as? [DocumentReference] else { throw FirebaseParserError.invalidKey(key: key) }
        return references
    }
    
    func dictionaries(withKey key: String, from document: DocumentSnapshot) throws -> [[String: Any]] {
        guard let data = document.data() else { throw FirebaseParserError.invalidData }
        guard let dictionaries = data[key] as? [[String: Any]] else { throw FirebaseParserError.invalidKey(key: key) }
        return dictionaries
    }
}
