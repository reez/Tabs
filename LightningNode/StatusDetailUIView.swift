//
//  StatusDetailUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class StatusDetailAppState: ObservableObject {
    @Published var infoLabel = "Getting Info"
}

struct StatusDetailUIView: View {
    @ObservedObject var state = StatusDetailAppState()
    
    
    func loadStatusDetail() {
        //        self.nvActivityIndicator?.startAnimating()
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            //            self.viewModel = LightningViewModel { _ in }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { result in // [weak self]
                try? result.get()
                    |> flatMap {
                        //                        self?.viewModel.lightningNodeInfo = $0
                        
                        let text = """
                        "alias": \($0.alias)
                        
                        "blockHeight": \($0.blockHeight)
                        
                        "chain": \($0.chainsArray)
                        
                        "network": \($0.network)
                        
                        "numActiveChannels": \($0.numActiveChannels)
                        
                        "numPeers": \($0.numPeers)
                        
                        "numPendingChannels": \($0.numPendingChannels)
                        
                        "syncedToChain": \($0.syncedToChain)
                        """
                        
                        self.state.infoLabel = text
                        //                        self?.nvActivityIndicator?.stopAnimating()
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
    
    var body: some View {
        
        VStack {
            Text(state.infoLabel)
                .font(.caption)
        }
        .onAppear {
            self.loadStatusDetail()
        }
        
    }
    
}

struct StatusDetailUIView_Previews: PreviewProvider {
    static var previews: some View {
        StatusDetailUIView()
    }
}
