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
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(name) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
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
