//
//  Network.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import Foundation

class Network: ObservableObject {
    static var validUsers: [String] = ["cshort@gmail.com", "mtaylor@gmail.com", "oduke@gmail.com"] 
    @Published var needsAlert: Bool = false
    @Published var users: [User] = [] {
        didSet{
            print("we're setting it")
        }
    }

    func getUsers(with email: String)  async -> [User] {
        if needsAlert {
            needsAlert = false 
        }
        guard let url = URL(string: "https://vcp79yttk9.execute-api.us-east-1.amazonaws.com/messages/users/\(email)") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        var array = [User]()
        let dataTask =  URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                self.needsAlert = true
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                        print(decodedUsers)
                        self.users = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.needsAlert = true
                }
            }
        }
        dataTask.resume()
        return users
    }
    
    
}

