//
//  ContentView.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import SwiftUI

enum ViewOptions {
    case messages
    
    @ViewBuilder func view(_ path: Binding<NavigationPath>, email: String) -> some View  {
        switch self {
        case .messages:
            MessagesView(path: path, viewModel: MessagesViewModel(email: email))
        }
    }
}


struct ContentView: View {
    @StateObject var viewModel: HomeViewModel
    @State var enteredEmail: String = ""
    @State var hasWritten: Bool = false
    @State var path: NavigationPath = NavigationPath()
    @State var isInvalidEmail: Bool = false

    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 16) {
                logo
                Text("Message Center")
                    .font(.largeText())
                Text("Enter your email to search for your messages")
                    .font(.mediumText())
                textfield
                Spacer()
                searchButton
                
            }
            .navigationTitle("")
            .onReceive(viewModel.$isSuccessfulLogin) { isSuccessful in
                if isSuccessful {
                    path.append(ViewOptions.messages)
                }
            }
            .navigationDestination(for: ViewOptions.self) {option in
                option.view($path, email: enteredEmail)
            }
            .alert("Email not found. Please try again.", isPresented: $viewModel.isInvalidEmail, actions: {
               
            })
            .padding()
        }
        
    }
    
    var textfield: some View {
        TextField("Enter Email", text: $enteredEmail, onEditingChanged: { (isChanged) in
            if isChanged {
                if !hasWritten {
                    hasWritten = true
                }
            }
        })
            .padding()
            .overlay(alignment: .top) {
                if !isValidEmail(enteredEmail) && hasWritten {
                    Text("Please enter a valid email address")
                        .foregroundStyle(.red)
                        .offset(y: -4 )
                }
            }
    }
    
    var logo: some View {
        Image("RTGLogo")
//            .resizable()
//            .scaledToFit()
//            .frame(width: UIScreen.screenWidth *)
    }
    
    var searchButton: some View {
 
        Button(action: {
            if isValidEmail(enteredEmail) {
                viewModel.login(with: enteredEmail) 
            }
            
        }) {
            Text("Search")
                .foregroundStyle(.white)
                .frame(width: UIScreen.screenWidth*0.85, height: UIScreen.screenHeight*0.06)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.searchBlue)
                )
        }
        .padding()
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

#Preview {
    ContentView(viewModel: HomeViewModel())
}
