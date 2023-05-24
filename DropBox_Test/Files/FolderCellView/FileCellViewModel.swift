//
//  FileCellViewModel.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 24.05.2023.
//

import SwiftyDropbox
import SwiftUI

enum DownloadButtonState {
    case initial, loading, success, error
}

class FileCellViewModel: ObservableObject {
    
    let client = DropboxClientsManager.authorizedClient
    let fileManager = LocalFileManager.instance
    
    @Published var downloadState: DownloadButtonState
    @Published var progress = Progress()
    let fileName: String
    let filePath: String?
    
    init(fileName: String, filePath: String?) {
        self.fileName = fileName
        self.filePath = filePath
        if fileManager.checkIfFileExists(name: fileName) {
            downloadState = .success
        } else {
            downloadState = .initial
        }
    }
    
    func downloadDocument() {
        guard let path = filePath, let destURL = fileManager.getPathFor(name: fileName) else {return}
        let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
            return destURL
        }
        withAnimation {
            downloadState = .loading
        }
        client?.files.download(path: path, overwrite: true, destination: destination)
            .response {[weak self] response, error in
                if let response = response {
                    print(response)
                    withAnimation {
                        self?.downloadState = .success
                    }
                    
                } else if let error = error {
                    print(error)
                    withAnimation {
                        self?.downloadState = .initial
                    }
                } else {
                    self?.downloadState = .initial
                }
            }
            .progress {[weak self] progressData in
                print(progressData)
                self?.progress = progressData
            }
    }
}
