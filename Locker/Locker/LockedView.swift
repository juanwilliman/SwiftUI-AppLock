//
//  LockedView.swift
//  Locker
//
//  Created by Juan Williman on 10/6/22.
//

import SwiftUI

// MARK: - Locked View

struct LockedView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var securityController: SecurityController
    
    // MARK: - Body
    
    var body: some View {
        Button("Unlock") {
            securityController.authenticate()
        }
    }
    
}

// MARK: - Preview

struct LockedView_Previews: PreviewProvider {
    static var previews: some View {
        LockedView()
    }
}

