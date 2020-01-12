//
//  StatusDetailUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class TabsAppState: ObservableObject {
    @Published var alias = "..."
    @Published var blockHeight = "..."
    @Published var chainsArray = "..."
    @Published var network = "..."
    @Published var numActiveChannels = "..."
    @Published var numPeers = "..."
    @Published var numPendingChannels = "..."
    @Published var syncedToChain = "..."
}

struct StatusDetailUIView: View {
    @ObservedObject var appState = TabsAppState()
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 15.0) {
            
            Text("alias: ")
                + Text(self.appState.alias)
                    .bold()
            
            Text("chainsArray: ")
                + Text(self.appState.chainsArray)
                    .bold()
            
            Text("network: ")
                + Text(self.appState.network)
                    .bold()
            
            Text("numActiveChannels: ")
                + Text("\(self.appState.numActiveChannels)")
                    .bold()
            
            Text("numPeers: ")
                + Text("\(self.appState.numPeers)")
                    .bold()
            
            Text("numPendingChannels: ")
                + Text("\(self.appState.numPendingChannels)")
                    .bold()
            
            Text("syncedToChain: ")
                + Text(String(self.appState.syncedToChain))
                    .bold()
            
        }
        .font(.system(.callout, design: .monospaced))
        .onAppear { self.loadStatusDetail() }
        
    }
    
}

extension StatusDetailUIView {
    func loadStatusDetail() {
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { result in
                try? result.get()
                    |> flatMap {
                        self.appState.alias = $0.alias
                        self.appState.blockHeight = String($0.blockHeight)
                        self.appState.chainsArray = $0.chainsArray
                        self.appState.network = $0.network
                        self.appState.numActiveChannels = String($0.numActiveChannels)
                        self.appState.numPeers = String($0.numPeers)
                        self.appState.numPendingChannels = String($0.numPendingChannels)
                        self.appState.syncedToChain = String($0.syncedToChain)
                }
            }
        case .failure(_):
            break
        }
    }
}

struct StatusDetailUIView_Previews: PreviewProvider {
    static var previews: some View {
        StatusDetailUIView()
    }
}
