//
//  LoginView.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 23.05.2023.
//

import SwiftUI
import SwiftyDropbox

struct LoginView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State private var isShownLogin = false
    @State private var showDropBoxLoginOnce = true
    var body: some View {
        ZStack {
            if showDropBoxLoginOnce {
                DropboxView(isShown: $isShownLogin)
            }
            Button("Login in DropBox") {
                isShownLogin = true
            }
            .buttonStyle(.bordered)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onOpenURL { url in
                showDropBoxLoginOnce = false
                DropboxClientsManager.handleRedirectURL(url) { _ in
                    contentViewModel.refreshClient()
                }
                     
                  }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
