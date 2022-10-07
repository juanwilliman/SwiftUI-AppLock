//
//  ContentView.swift
//  Locker
//
//  Created by Juan Williman on 10/6/22.
//

import SwiftUI

// MARK: - Content View

struct ContentView: View {
    
    // MARK: - Variables
    
    @StateObject private var securityController = SecurityController()
    
    @Environment(\.scenePhase) var scenePhase
    
    // MARK: - Body
    
    var body: some View {
        content
            .onAppear {
                securityController.showLockedViewIfEnabled()
            }
            .onChange(of: scenePhase, perform: { value in
                switch value {
                case .background, .inactive:
                    securityController.lockApp()
                default:
                    break
                }
            })
        
    }
    
    // MARK: - Content
    
    var content: some View {
        Toggle("App Lock", isOn: $securityController.isAppLockEnabled)
            .padding(80)
            .onChange(of: securityController.isAppLockEnabled, perform: { value in
                securityController.appLockStateChange(value)
            })
            .sheet(isPresented: $securityController.isLocked) {
                LockedView()
                    .environmentObject(securityController)
                    .interactiveDismissDisabled()
            }
    }
    
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
