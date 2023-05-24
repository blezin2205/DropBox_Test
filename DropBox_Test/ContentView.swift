//
//  ContentView.swift
//  DropBox_Test
//
//  Created by Oleksandr Stepanov on 23.05.2023.
//

import SwiftUI
import SwiftyDropbox
import Alamofire

class ContentViewModel: ObservableObject {
    @Published var client = DropboxClientsManager.authorizedClient
    let localManager = LocalFileManager.instance
    
    func logOutUser() {
        DropboxClientsManager.unlinkClients()
        client = nil
    }
    
    func refreshClient() {
        client = DropboxClientsManager.authorizedClient
    }

}

struct ContentView: View {
    
    @State var isShown = false
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if let authorizedClient = viewModel.client {
                MainView(client: authorizedClient)
            } else {
                LoginView()
            }
        }.environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DropboxView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    @Binding var isShown : Bool
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        if isShown {
            let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read", "files.metadata.write", "files.metadata.read", "files.content.write", "files.content.read"], includeGrantedScopes: false)
            DropboxClientsManager.authorizeFromControllerV2(
                UIApplication.shared,
                controller: uiViewController,
                loadingStatusDelegate: nil,
                openURL: { (url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil) },
                scopeRequest: scopeRequest)
        }
    }
    
    func makeUIViewController(context _: Self.Context) -> UIViewController {
        return UIViewController()
    }
}
