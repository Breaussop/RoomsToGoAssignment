//
//  MessagesView.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import SwiftUI

struct MessagesView: View {
    @Binding var path: NavigationPath
    @StateObject var viewModel: MessagesViewModel
    @State var users: [User] = [User]()
    @State var needsAlert: Bool = false
    
    @ViewBuilder
    var body: some View {
        VStack {
            HStack {
                Text("Message Center")
                    .font(.mediumBoldText())
                Spacer()
            }
            .frame(width:UIScreen.screenWidth*0.95)
            .padding()
            ScrollView {
                VStack {
                    if !viewModel.isLoading {
                        ForEach(self.viewModel.users, id: \.message) { user in
                            let formattedDate = viewModel.dateStringToDate(dateString:user.date)
                            HStack {
                                Text(user.message)
                                    .font(.smallText())
                                    .padding()
                                Spacer()
                                Text( formattedDate?.mmDDyyyySlash() ?? "" )
                                    .font(.smallText())
                                    .padding()
                            }
                            .frame(width:UIScreen.screenWidth*0.95)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.searchBlue)
                            )
                            .padding()
                        }
                    } else {
                        Spacer()
                        Text("Loading...")
                            .font(.smallText())
                        Spacer()
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.getUsers()
                }
            }
        }
        .navigationTitle("")
        .onAppear {
            Task {
                await viewModel.getUsers()
            }
        }
        .alert("There was an error retrieving your messages. Please try again later.", isPresented: $needsAlert, actions: {
            
        })
        .onReceive(viewModel.network.$needsAlert, perform: { needsAlert in
            print("on receive is going")
            if needsAlert {
                self.needsAlert = true
            }
        })
        .onReceive(viewModel.network.$users, perform: { users in
            print("on receive is going")
            if users.count > 0 {
                for user in users {
                    print("in my receive my user is \(user) with a message of \(user.message)")
                    DispatchQueue.main.async {
                        self.viewModel.isLoading = false
                        self.viewModel.users.append(user)
                    }
                    
                }
                self.viewModel.users.sort(by: {viewModel.dateStringToDate(dateString: $0.date)?.compare(viewModel.dateStringToDate(dateString: $1.date) ?? Date()) == .orderedDescending })
            }
        })
    }
}

//#Preview {
//    
//    MessagesView(path: $path, viewModel: MessagesViewModel(email: "oduke@gmail.com"))
//}
