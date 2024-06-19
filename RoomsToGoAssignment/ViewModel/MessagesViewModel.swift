//
//  MessagesViewModel.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import Foundation
import SwiftUI

class MessagesViewModel: ObservableObject {
   var network: Network = Network()
    
    var email: String = ""
    @Published var users: [User] = [User]()
    @Published var isLoading: Bool = false
    
    init(email: String) {
        self.email = email 
    }
    

    func getUsers() async {
        self.isLoading = true 
        let _ = await network.getUsers(with: email)
        print("NEXT")
     
    }
    
     func dateStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return dateFormatter.date(from: dateString)
    }
}
