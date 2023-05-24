//
//  FilesViewModel.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 23.05.2023.
//

import SwiftUI
import SwiftyDropbox

class FilesViewModel: ObservableObject {
    
    let client: DropboxClient
    @Published var files = [Files.Metadata]()
    let path: String
    
    init(client: DropboxClient, path: String = "") {
        self.client = client
        self.path = path
        getAllFiles()
    }
    
    private func getAllFiles() {
        client.files.listFolder(path: path).response {[weak self] result, error in
            if let result = result {
                self?.files = result.entries
                result.entries.forEach { entr in
                    print(entr)
                }
            }
        }
    }
}
