//
//  SettingsView.swift
//  LoginForm
//
//  Created by Lukas on 28.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView {
            List {
               Section {
                    Button(action: {},
                           label: {
                            SettingsCell(title: "Features", imgName: "sparkle", clr: .purple)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                           })
                    
                Button(action: {},
                       label: {
                        SettingsCell(title: "Settings", imgName: "sparkle", clr: .purple)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                       })
                Button(action: {},
                       label: {
                        SettingsCell(title: "Bla", imgName: "sparkle", clr: .purple)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                       })
                }
                
                
                   Section {
                        Button(action: {},
                               label: {
                                SettingsCell(title: "Features", imgName: "sparkle", clr: .purple)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                               })
                        
                    Button(action: {},
                           label: {
                            SettingsCell(title: "Settings", imgName: "sparkle", clr: .purple)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                           })
                    }
            }
        }
        .listStyle(GroupedListStyle())
//        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
