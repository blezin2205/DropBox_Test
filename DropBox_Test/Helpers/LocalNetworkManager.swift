//
//  LocalNetworkManager.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 24.05.2023.
//

import Foundation

class LocalFileManager {
    
    static let instance = LocalFileManager()

    func getPathFor(name: String?) -> URL? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        return url.appendingPathComponent(name ?? "")
    }
    
    func checkIfFileExists(name: String) -> Bool {
        if let path = getPathFor(name: name)?.path, FileManager.default.fileExists(atPath: path) {
            return true
        } else {
            return false
        }
    }
}
