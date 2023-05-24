//
//  FileCellView.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 24.05.2023.
//

import SwiftUI

struct FileCellView: View {
    @StateObject var viewModel: FileCellViewModel
    
    var body: some View {
            HStack {
                Image(systemName: "doc")
                Text(viewModel.fileName)
                Spacer()
                downloadStateButton
        }
    }
    
    @ViewBuilder private var downloadStateButton: some View {
        
        Button {
            viewModel.downloadDocument()
        } label: {
            buttonStateView
        }
        .buttonStyle(.borderless)
        .disabled(viewModel.downloadState != .initial)
    }
    
    
    private var buttonStateView: some View {
        ZStack {
            switch viewModel.downloadState {
            case .initial:
                Image(systemName: "icloud.and.arrow.down")
            case .loading:
               ProgressView()
            case .success:
                Image(systemName: "checkmark")
                    .renderingMode(.template)
                    .foregroundColor(.green)
            case .error:
                Image(systemName: "icloud.and.arrow.down")
            }
        }
    }
}

//struct FolderCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderCellView()
//    }
//}
