//
//  DropBox_TestApp.swift
//  DropBox_Test
//
//  Created by Oleksandr Stepanov on 23.05.2023.
//

import SwiftUI
import SwiftyDropbox

@main
struct DropBox_TestApp: App {
    
    init() {
        DropboxClientsManager.setupWithAppKey("ky61jf1mf6pqxd7")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
