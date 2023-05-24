//
//  MainView.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 23.05.2023.
//

import SwiftUI
import SwiftyDropbox

struct MainView: View {
    let client: DropboxClient
    
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(client: client))
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView(viewModel: ProfileViewModel(client: client))
                
                .tabItem {
                    Label("Files", systemImage: "folder")
                }
        }
    }
}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
