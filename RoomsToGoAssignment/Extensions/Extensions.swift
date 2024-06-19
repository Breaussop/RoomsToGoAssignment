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
    // MARK: - Home
    static var center = "Message Center"
    static var textfieldMessage = "Enter Email"
    static var enterMessage = "Enter yor email to search for your messages"
    static var needsValidEmail =  "Please enter a valid email."
    static var notValidEmailAlert = "Email not found. Please try again."
    static var search = "Search"
    
    // MARK: - Messages
    static var callbackError = "There was an error retrieving your messages. Please try again later."
    static var loading = "Loading..."
    static var noMessages = "No messages"
    func dateStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return dateFormatter.date(from: dateString)
    }
}

extension Font {
    
    static func smallText() -> Font {
        Font.custom("Poppins-Regular", size: 14)
    }
    
    static func mediumText() -> Font {
        Font.custom("Poppins-Regular", size: 16)
    }
    
    static func largeText() -> Font {
        Font.custom("Poppins-Regular", size: 24)
    }
    
    static func mediumBoldText() -> Font {
        Font.custom("Poppins-Regular", size: 16)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
