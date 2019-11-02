//
//  TabUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

struct TabUIView: View {
    var body: some View {
        
        TabView {
            
            StatusUIView()
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Status")
                }.tag(0)
            
            Text("Invoices")
                 .tabItem {
                     Image(systemName: "bolt.circle")
                     Text("Invoices")
                 }.tag(1)
            
            SettingsUIView()
                 .tabItem {
                     Image(systemName: "line.horizontal.3.decrease.circle")
                     Text("Settings")
                 }.tag(2)
            
            
        }
        
    }
}

struct TabUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabUIView()
    }
}
