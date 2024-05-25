//
//  LockedView.swift
//  Locker
//
//  Created by Juan Williman on 10/6/22.
//

import SwiftUI

// MARK: - Locked View

struct LockedView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var securityController: SecurityController
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Button("Unlock") {
                securityController.authenticate()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .navigationTitle("Locked")
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .sheet(isPresented: .constant(true)) {
            LockedView()
                .environmentObject(SecurityController())
                .interactiveDismissDisabled()
        }
}
