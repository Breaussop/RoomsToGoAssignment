//
//  HomeViewModel.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isInvalidEmail: Bool = false
    @Published var isSuccessfulLogin: Bool = false
    
    
    // since we only have the one request, we don't have an actual login function or authorization to determine if the user has valid access so we I've hard-coded in the Network class some "valid" users. keeping logins to be case sensitive or not was a decision to be made, i opted to keep it case sensitive
    func login(with email: String) {
        if Network.validUsers.contains(email) {
            if isInvalidEmail {
                isInvalidEmail = false 
            }
            isSuccessfulLogin = true
        } else {
            isInvalidEmail = true
         
        }
    }
}
