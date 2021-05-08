//
//  String+Ext.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import Foundation
extension String{
    public static let space = " "
    public static let empty = ""
    public static let hash = "#"
    public static let percentage = "%"
    public static let colon = ":"
    
    func convertToDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else {
            return "N/A"
        }
        return date.convertToMonthYearFormat()
    }
}
