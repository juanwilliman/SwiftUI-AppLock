//
//  SecurityController.swift
//  Locker
//
//  Created by Juan Williman on 10/6/22.
//

import SwiftUI
import LocalAuthentication

// MARK: - Security Controller

@MainActor
class SecurityController: ObservableObject {
    
    // MARK: - Variables
    
    var error: NSError?
    
    @Published var isLocked = false
    @Published var isAppLockEnabled: Bool = UserDefaults.standard.object(forKey: "isAppLockEnabled") as? Bool ?? false
    
}

// MARK: - App Lock Toggle

extension SecurityController {
    
    func showLockedViewIfEnabled() {
        if isAppLockEnabled {
            isLocked = true
            authenticate()
        } else {
            isLocked = false
        }
    }
    
    func lockApp() {
        if isAppLockEnabled {
            isLocked = true
        } else {
            isLocked = false
        }
    }
    
}

// MARK: - App Lock State

extension SecurityController {
    
    func appLockStateChange(_ isEnabled: Bool) {
        let context = LAContext()
        let reason = "Authenticate to toggle App Lock"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                        self.isAppLockEnabled = isEnabled
                        UserDefaults.standard.set(self.isAppLockEnabled, forKey: "isAppLockEnabled")
                    }
                }
            }
        }
    }
        
}

// MARK: - Biometric Authentication

extension SecurityController {
    
    func authenticate() {
        let context = LAContext()
        let reason = "Authenticate yourself to unlock Locker"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                    }
                }
            }
        }
    }
    
}
