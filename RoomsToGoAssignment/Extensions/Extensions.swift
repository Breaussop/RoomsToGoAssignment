//
//  Extensions.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import Foundation
import UIKit
import SwiftUI

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
      static let screenHeight = UIScreen.main.bounds.size.height
      static let screenSize = UIScreen.main.bounds.size
}

extension Color {
    static let searchBlue: Color = Color("RTGBlue")
}

extension Date {
    static let kMMddyyyy = "MM/dd/yyyy"
    
    func dateStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return dateFormatter.date(from: dateString)
    }
   
    
    func mmDDyyyySlash() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.current.identifier)
        formatter.setLocalizedDateFormatFromTemplate(Date.kMMddyyyy)
        return formatter.string(from: self).lowercased()
    }
}

extension String {
    func dateStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return dateFormatter.date(from: dateString)
    }
}
