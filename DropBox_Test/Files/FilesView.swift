//
//  FilesView.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 23.05.2023.
//

import SwiftUI
import SwiftyDropbox

struct FilesView: View {
    @StateObject var viewModel: FilesViewModel
    var nawTitle = "Files"
    
    var body: some View {
        NavigationStack {
            List(viewModel.files, id: \.name) { file in
                switch file {
                case let fileMetadata as Files.FileMetadata:
                    FileCellView(viewModel: FileCellViewModel(fileName: fileMetadata.name, filePath: fileMetadata.pathLower)).padding(.vertical, 4)
                case let folderMetadata as Files.FolderMetadata:
                    NavigationLink {
                        FilesView(viewModel: FilesViewModel(client: viewModel.client, path: folderMetadata.id), nawTitle: folderMetadata.name)
                    } label: {
                        HStack {
                            Image(systemName: "folder")
                            Text(folderMetadata.name)
                        }.padding(.vertical, 4)
                    }
                case let deletedMetadata as Files.DeletedMetadata:
                    Text(deletedMetadata.name)
                default:
                    EmptyView()
                }
            }
            .listStyle(.plain)
            .font(.title2)
            .navigationTitle(nawTitle)
        }
       
    }
}

