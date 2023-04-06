//
//  CryptoHelper.swift.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import Foundation
import CryptoKit

class CryptoHelper {
    // TODO: Change for cocopods key (Maybe)
    static let publicKey = "5b23e88d26cf56958f076f88be9fed9d"
    static let privateKey = "b220d549848ca21eacd776e73db60e6deccfd95f"
    
    private static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    static var apiKey: String {
        publicKey
    }
    
    static var hash: String {
        MD5(string: "1" + privateKey + publicKey)
    }
}
