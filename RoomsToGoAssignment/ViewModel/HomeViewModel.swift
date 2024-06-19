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
    // since we only have the one request, we don't have an actual login function to determine if the email is in our database
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
