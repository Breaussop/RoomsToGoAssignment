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
            header
            scrollView
        }
        .navigationTitle("")
        .onAppear {
            Task {
                await viewModel.getUsers()
            }
        }
        .alert(String.callbackError, isPresented: $needsAlert, actions: {
            Button(action: {path.removeLast()}){
                Text(String.goBack)
                    .font(.smallText())
            }
        })
        .onReceive(viewModel.network.$needsAlert, perform: { needsAlert in
            if needsAlert {
                self.needsAlert = true
            }
        })
        .onReceive(viewModel.network.$users, perform: { users in
            if users.count > 0{
                    for user in users {
                            self.viewModel.isLoading = false
                            self.viewModel.users.append(user)
                    }
            }
            self.viewModel.users = self.viewModel.users.sorted(by: {viewModel.dateStringToDate(dateString: $0.date).compare(viewModel.dateStringToDate(dateString: $1.date)) == .orderedDescending })
        })
    }
    
    var header: some View {
        HStack {
            Text(String.center)
                .font(.mediumBoldText())
                .padding([.leading, .bottom])
            Spacer()
        }
        .frame(width:UIScreen.screenWidth*0.95)
        .padding()
    }
    
    var scrollView: some View {
        ScrollView {
            VStack {
                if !viewModel.network.isLoading {
                    if viewModel.users.count > 0 {
                        ForEach(self.viewModel.users, id: \.message) { user in
                            let formattedDate = viewModel.dateStringToDate(dateString:user.date)
                            HStack {
                                Text(user.message)
                                    .font(.smallText())
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.alphabet)
                                    .textContentType(.oneTimeCode)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                                    .padding()
                                Spacer()
                                Text( formattedDate.mmDDyyyySlash() )
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
                    } else if !viewModel.network.isLoading {
                        Spacer()
                        Text(String.noMessages)
                            .font(.smallText())
                        Spacer()
                    }
                } else {
                    Spacer()
                    Text(String.loading)
                        .font(.smallText())
                    Spacer()
                }
            }
        }
        .refreshable {
            Task {
                viewModel.users = [User]()
                await viewModel.getUsers()
            }
        }
    }
}

//#Preview {
//    
//    MessagesView(path: $path, viewModel: MessagesViewModel(email: "oduke@gmail.com"))
//}
