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
    @Published var isLoading: Bool = true
    @Published var users: [User] = [] 

    func getUsers(with email: String)  async {
        // redundant when used only once but just in case a user wants to log in to multiple accounts, we have everything being refreshed.
        if needsAlert {
            needsAlert = false 
        }
        isLoading = true
        //
        guard let url = URL(string: "https://vcp79yttk9.execute-api.us-east-1.amazonaws.com/messages/users/\(email)") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)

        let dataTask =  URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                self.needsAlert = true
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                self.isLoading = false
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
    
    }
    
    
}

