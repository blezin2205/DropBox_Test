//
//  HomeViewModel.swift
//  DropBox_Test
//
//  Created by Alex Stepanov on 23.05.2023.
//

import Foundation
import SwiftyDropbox

extension Int {
    var byteSize: String {
        return ByteCountFormatter().string(fromByteCount: Int64(self))
    }
}

struct AuthUser {
    let name: String
    let email: String
    let totalSize: Double
    let usedSize: Double
}

class HomeViewModel: ObservableObject {
    
    let client: DropboxClient
    @Published var currentUser: AuthUser?
    
    init(client: DropboxClient) {
        self.client = client
        fetchAuthUserInfo()
    }
    
    private func getCurrentAccountInfo() async throws -> (String, String)  {
        try await withCheckedThrowingContinuation { continuation in
            client.users.getCurrentAccount().response {user, error in
                if let user = user {
                    let userName = user.name.givenName + " " + user.name.surname
                    let email = user.email
                    continuation.resume(returning: (userName, email))
                } else if let err = error {
                    let nsError = NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: err.description]) as Error
                    continuation.resume(throwing: nsError)
                }
            }
        }
    }
    
    private func getStorageInfoForUser() async throws -> (Double, Double) {
        try await withCheckedThrowingContinuation({ continuation in
            client.users.getSpaceUsage().response { result, error in
                if let result = result {
                    let used = Double(result.used)
                    if case .individual(let individualSpaceAllocation) = result.allocation {
                        let total = Double(individualSpaceAllocation.allocated)
                        continuation.resume(returning: (used, total))
                    } else {
                        continuation.resume(returning: (used, 0))
                    }
                 
                } else {
                    let nsError = NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: error?.description ?? "Unknown error"]) as Error
                    continuation.resume(throwing: nsError)
                }
            }
        })
    }
    
    private func getUserInfo() async throws -> AuthUser {
        async let accountInfo = try await getCurrentAccountInfo()
        async let storageInfo = try await getStorageInfoForUser()
        let (account, storage) = try await (accountInfo, storageInfo)
        return AuthUser(name: account.0, email: account.1, totalSize: storage.1, usedSize: storage.0)
    }
    
    private func fetchAuthUserInfo() {
        Task {
            do {
                let user = try await getUserInfo()
                await MainActor.run {
                    currentUser = user
                    print(user)
                }
            } catch {
                currentUser = .init(name: "Error!", email: error.localizedDescription, totalSize: 0, usedSize: 0)
                print(#function, error.localizedDescription)
            }
        }
    }
    
    
}
