//
//  StatusDetailUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class TabsAppState: ObservableObject {
//    @Published var lightningNode: LightningViewModel!
    @Published var alias = ""
    @Published var blockHeight = ""
    @Published var chainsArray = ""
    @Published var network = ""
    @Published var numActiveChannels = ""
    @Published var numPeers = ""
    @Published var numPendingChannels = ""
    @Published var syncedToChain = ""
}

//class StatusDetailAppState: ObservableObject {
//    @Published var infoLabel = "Getting Info..."
//}

struct StatusDetailUIView: View {
//    @ObservedObject var state = StatusDetailAppState()
    @ObservedObject var appState = TabsAppState()

    var body: some View {
                
        Group {
            Text("alias: ")
                .bold()
                + Text(self.appState.alias)
            
            Text("chainsArray: ")
                .bold()
                + Text(self.appState.chainsArray)

            Text("network: ")
                .bold()
                + Text(self.appState.network)
            
            Text("numActiveChannels: ")
                .bold()
                + Text("\(self.appState.numActiveChannels)")
            
            Text("numPeers: ")
                .bold()
                + Text("\(self.appState.numPeers)")
            
            Text("numPendingChannels: ")
                .bold()
                + Text("\(self.appState.numPendingChannels)")
            
            Text("syncedToChain: ")
                .bold()
                + Text(String(self.appState.syncedToChain))
            
        }
        .font(.caption)
        .onAppear { self.loadStatusDetail() }
        
    }
    
}

extension StatusDetailUIView {
    func loadStatusDetail() {
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            //            self.viewModel = LightningViewModel { _ in }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { result in // [weak self]
                try? result.get()
                    |> flatMap {
                        // self?.viewModel.lightningNodeInfo = $0
                        
                        //                        let text = """
                        //                        "alias": \($0.alias)
                        //
                        //                        "blockHeight": \($0.blockHeight)
                        //
                        //                        "chain": \($0.chainsArray)
                        //
                        //                        "network": \($0.network)
                        //
                        //                        "numActiveChannels": \($0.numActiveChannels)
                        //
                        //                        "numPeers": \($0.numPeers)
                        //
                        //                        "numPendingChannels": \($0.numPendingChannels)
                        //
                        //                        "syncedToChain": \($0.syncedToChain)
                        //                        """
                        //
                        //                        self.state.infoLabel = text
                        
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
            print("big fail")
            //            self.nvActivityIndicator?.stopAnimating()
            //            if (self.navigationController != nil) {
            //                print("self.navigationController != nil")
            //                self.navigationController?.popToRootViewController(animated: true)
            //            } else {
            //                print("self.navigationController = nil")
            //                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            //            }
        }
    }
}

struct StatusDetailUIView_Previews: PreviewProvider {
    static var previews: some View {
        StatusDetailUIView()
    }
}
