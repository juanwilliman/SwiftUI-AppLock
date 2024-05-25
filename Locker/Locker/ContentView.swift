//
//  ContentView.swift
//  Locker
//
//  Created by Juan Williman on 10/6/22.
//

import SwiftUI

// MARK: - Content View

struct ContentView: View {
    
    // MARK: - Properties
    
    @StateObject private var securityController = SecurityController()
    
    @Environment(\.scenePhase) var scenePhase
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                Section("Security") {
                    Toggle("App Lock", isOn: $securityController.isAppLockEnabled)
                }
            }
            .navigationTitle("Locker")
        }
        .onAppear {
            securityController.showLockedViewIfEnabled()
        }
        .sheet(isPresented: $securityController.isLocked) {
            LockedView()
                .environmentObject(securityController)
                .interactiveDismissDisabled()
        }
        .onChange(of: securityController.isAppLockEnabled, perform: { value in
            securityController.appLockStateChange(value)
        })
        .onChange(of: scenePhase, perform: { value in
            switch value {
            case .background, .inactive:
                securityController.lockApp()
            default:
                break
            }
        })
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
