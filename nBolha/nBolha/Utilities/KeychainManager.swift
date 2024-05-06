//
//  KeyChainManager.swift
//  nBolhaNetworking
//
//  Created by David Balažic on 23. 4. 24.
//

import Foundation
import KeychainAccess

protocol KeychainManagable {
    func set(_ value: String, forKey key: String)
    func get(forKey key: String) -> String?
    func remove(_ key: String)
}

class KeyChainManager: KeychainManagable {
    
    enum KeychainAction: String {
        case get
        case set
        case remove
    }
    
    private let keychain: Keychain

    var onErrorCallback: ((Error) -> Void)?
    
    init(service: String) {
        self.keychain = Keychain(service: service)
    }

    func set(_ value: String, forKey key: String) {
        defer { onFinish() }
        
        do {
            try keychain.set(value, key: key)
        } catch let error {
            handleFaileResponse(for: .set, with: key, error: error)
        }
    }

    func get(forKey key: String) -> String? {
        defer { onFinish() }
        
        do {
            return try keychain.get(key)
        } catch let error {
            handleFaileResponse(for: .get, with: key, error: error)
            return nil
        }
    }

    func remove(_ key: String) {
        defer { onFinish() }
        
        do {
            try keychain.remove(key)
        } catch let error {
            handleFaileResponse(for: .remove, with: key, error: error)
        }
    }
    
    public func setWithAccessibility(value: String, with accessibility: Accessibility, key: String){
        defer { onFinish() }
        
        do {
            try keychain.accessibility(accessibility).set(value, key: key)
        } catch let error {
            handleFaileResponse(for: .set, with: key, error: error)
        }
    }

    public func setWithAccessibility(value: String, with accessibility: Accessibility, authenticationPolicy: AuthenticationPolicy, key: String) {
        defer { onFinish() }
        
        do {
            try keychain.accessibility(accessibility, authenticationPolicy: authenticationPolicy).set(value, key: key)
        } catch let error {
            handleFaileResponse(for: .set, with: key, error: error)
        }
    }
    
    private func handleFaileResponse(for action: KeychainAction, with key: String, error: Error) {
        #if DEVELOPMENT
        print("!!!KEYCHAIN - Failed to \(action.rawValue) for key: '\(key)'")
        #endif
        onErrorCallback?(error)
    }
    
    // We set onErrorCallback to nil after every call
    private func onFinish() {
        onErrorCallback = nil
    }
}
