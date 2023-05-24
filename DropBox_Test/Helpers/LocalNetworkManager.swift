//
//  LocalNetworkManager.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 24.05.2023.
//

import Foundation

class LocalFileManager {
    
    static let instance = LocalFileManager()

    func getPathForFile(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(name) else {
            print("Error getting path.")
            return nil
        }
        
        return path
    }
    
    func checkIfFileExists(name: String) -> Bool {
        let path = getPathForFile(name: name)?.absoluteString ?? ""
        print(path)
        return FileManager.default.fileExists(atPath: path)
    }
    
    func getGeneralFolder() -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first else {
            print("Error getting path.")
            return nil
        }
        
        return path
    }
    
}
