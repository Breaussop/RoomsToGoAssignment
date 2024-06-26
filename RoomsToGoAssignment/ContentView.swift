//
//  ContentView.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import SwiftUI


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
                Text(String.center)
                    .font(.largeText())
                Text(String.enterMessage)
                    .font(.mediumText())
                    .multilineTextAlignment(.center)
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
            .alert(String.notValidEmailAlert, isPresented: $viewModel.isInvalidEmail, actions: {
               
            })
            .padding()
        }
        
    }
    
    var textfield: some View {
        TextField(String.textfieldMessage, text: $enteredEmail, onEditingChanged: { (isChanged) in
            if isChanged {
                if !hasWritten && enteredEmail.count > 0 {
                    hasWritten = true
                }
            }
        })
        .font(.mediumText())
        .keyboardType(.alphabet)
        .textContentType(.oneTimeCode)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, lineWidth: 1)
        )
        .overlay(alignment: .top) {
            if !isValidEmail(enteredEmail) && hasWritten {
                Text(String.needsValidEmail)
                    .foregroundStyle(.red)
                    .offset(y: -4 )
            }
        }
    }
    
    var logo: some View {
        Image("RTGLogo")
    }
    
    var searchButton: some View {
 
        Button(action: {
            if isValidEmail(enteredEmail) {
                viewModel.login(with: enteredEmail) 
            }
            
        }) {
            Text(String.search)
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
