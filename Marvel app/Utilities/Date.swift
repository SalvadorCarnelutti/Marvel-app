//
//  Date.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//

import Foundation

extension Date {
    static func formatAsDate(_ dateString: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.date(from: dateString)
    }
    
    func formatAsString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let stringFormatted = dateFormatter.string(from: self)
        
        return stringFormatted
    }
}
