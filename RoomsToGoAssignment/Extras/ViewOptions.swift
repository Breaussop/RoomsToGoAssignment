//
//  ViewOptions.swift
//  RoomsToGoAssignment
//
//  Created by Kenneth Adams on 6/19/24.
//

import Foundation
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
