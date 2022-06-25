//
//  NFCTagManager.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import Foundation
import CoreNFC

class NFCTagManager: NSObject {
    
    private lazy var session: NFCNDEFReaderSession = {
        NFCNDEFReaderSession(
            delegate: self,
            queue: nil,
            invalidateAfterFirstRead: false
        )
    }()
    
    override init() {
        super.init()
    }
    
    func detectCollar() {
        session.begin()
    }
    
    func register(pet: Pet, on tag: Any) {
        
    }
    
    
    let uriPayloadFromString = NFCNDEFPayload.wellKnownTypeURIPayload(
        string: "https://twitter.com/HeyDaveTheDev"
    )!
    let uriPayloadFromURL = NFCNDEFPayload.wellKnownTypeURIPayload(
        url: URL(string: "www.apple.com")!
    )!

    // 2
    let textPayload = NFCNDEFPayload.wellKnownTypeTextPayload(
        string: "Hello World",
        locale: Locale.init(identifier: "en")
    )!

    // 3
    let customTextPayload = NFCNDEFPayload.init(
        format: .nfcWellKnown,
        type: "T".data(using: .utf8)!,
        identifier: Data(),
        payload: "Hello world".data(using: .utf8)!
    )

    // 4
    lazy var messge = NFCNDEFMessage.init(
        records: [
            uriPayloadFromString,
            uriPayloadFromURL,
            textPayload,
            customTextPayload
        ]
    )
}

extension NFCTagManager: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        guard let tag = tags.first else { return }

        session.connect(to: tag) { error in
            print(error ?? "")
            tag.queryNDEFStatus { (status, i, error) in
                print(status, i , error as Any)
                
                tag.writeNDEF(self.messge) { (error) in
                    print(error as Any)
                }
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print(messages)
    }
}
