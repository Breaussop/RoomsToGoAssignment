//
//  User.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import Foundation


// Perhaps naming this object Message and accessing the User.message property as Message.text would have been better
struct User: Decodable, Identifiable {
    var id: Int?
    var name: String
    var date: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, date, message
    }
}
