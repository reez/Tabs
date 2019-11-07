//
//  StatusUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class StatusAppState: ObservableObject {
    @Published var syncedLabel = "Syncing..."
    @Published var syncedImage = "xmark.circle"
    @Published var syncedState = false
    @Published var refreshedLabel = "Refreshing..."
}

struct StatusUIView: View {
    @ObservedObject var state = StatusAppState()
    @State private var showAlert = false
    
    var body: some View {
        
        VStack {
            
            VStack {
                Text(self.state.syncedLabel)
                    .font(.largeTitle)
                Text(self.state.refreshedLabel)
                    .font(.footnote)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Image(systemName: self.state.syncedImage)
                .resizable()
                .frame(width: 125, height: 125, alignment: .center)
                .foregroundColor(Color(.mr_gold))
                .animation(.spring())
            
            Button("Get Info") { self.showAlert = true }
                .padding()
                .foregroundColor(.blue)
                .padding()
                .sheet(isPresented: $showAlert, onDismiss: { self.showAlert = false }) { StatusDetailUIView() }
            
        }.onAppear {
            self.loadStatus()
        }
        
    }
    
}

extension StatusUIView {
    func loadStatus() {
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            //            self.viewModel = LightningViewModel { _ in }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info {  result in
                try? result.get()
                    |> flatMap {
                        //                        self?.viewModel.lightningNodeInfo = $0
                        
                        let creationDate = Current.date()
                        let formattedDate = mrDateFormatter.string(from: creationDate)
                        self.state.refreshedLabel = "Refreshed: \(formattedDate)"
                        
                        $0.syncedToChain ?
                            (self.state.syncedImage = "checkmark.circle") :
                            (self.state.syncedImage = "xmark.circle")
                        
                        $0.syncedToChain ?
                            (self.state.syncedState = true) :
                            (self.state.syncedState = false)
                        
                        $0.syncedToChain ?
                            (self.state.syncedLabel = "Synced") :
                            (self.state.syncedLabel = "Not Synced")
                }
            }
        case .failure(_):
            break
        }
    }
}

struct StatusUIView_Previews: PreviewProvider {
    static var previews: some View {
        StatusUIView()
    }
}
