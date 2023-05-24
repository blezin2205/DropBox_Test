//
//  HomeView.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 23.05.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @StateObject var viewModel: HomeViewModel
    @State private var logoutIsPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let user = viewModel.currentUser {
                    VStack {
                        Text(user.name)
                            .font(.title)
                        Text(user.email)
                            .font(.title2)
                        
                        ProgressView("Used space: \(Int(user.usedSize).byteSize) of \(Int(user.totalSize).byteSize)", value: user.usedSize, total: user.totalSize)
                            .padding()
                        
                        if let myPath = contentViewModel.localManager.getPathFor(name: nil)?.path {
                            Text("Your DropBox folder destination:\n" + myPath)
                        }
                    }.padding()
                } else {
                    ProgressView()
                }
            }.navigationTitle("Home")
                .toolbar {
                    Button("Logout", action: { logoutIsPresented = true })
                }
                .confirmationDialog("Logout", isPresented: $logoutIsPresented) {
                    Button("Logout", action: contentViewModel.logOutUser)
                    Button("Cancel", role: .cancel, action: {})
                }
        }
    }
    
}
