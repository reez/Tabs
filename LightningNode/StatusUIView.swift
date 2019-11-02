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
    @Published var refreshedLabel = "Refreshing..."
}

struct StatusUIView: View {
    @ObservedObject var state = StatusAppState()
    @State private var showAlert = false
    
    func loadStatus() {
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            //            self.viewModel = LightningViewModel { _ in }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            //'weak' may only be applied to class and class-bound protocol types, not 'StatusUIView'
            Current.lightningAPIRPC.info {  result in //[weak self]
                try? result.get()
                    |> flatMap {
                        //                        self?.viewModel.lightningNodeInfo = $0
                        
                        let creationDate = Current.date()
                        let formattedDate = mrDateFormatter.string(from: creationDate)
                        self.state.refreshedLabel = "Refreshed: \(formattedDate)"
                        
                        //                        $0.syncedToChain ?
                        //                            (self?.checkbox.setCheckState(.checked, animated: true)) :
                        //                            (self?.checkbox.setCheckState(.unchecked, animated: true))
                        
                        $0.syncedToChain ?
                            (self.state.syncedLabel = "Synced") :
                            (self.state.syncedLabel = "Not Synced")
                }
            }
        case .failure(_):
            print("yoyo")
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
            
            Text(self.state.syncedLabel)
                .font(.headline)
            
            // $ ?
            Text(self.state.refreshedLabel)
                .font(.footnote)
            
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 175, height: 175, alignment: .center)
                .foregroundColor(.green)
            
            Button("Get Info") {
                print("Get it")
                self.showAlert = true
                
            }
            .padding()
            .foregroundColor(.blue)
            .padding()
            .sheet(isPresented: $showAlert, onDismiss: {
                print("Dismissed")
                self.showAlert = false
                
            }) {
                StatusDetailUIView()
            }
            
        }.onAppear {
            self.loadStatus()
        }
        
        
    }
    
}

struct StatusUIView_Previews: PreviewProvider {
    static var previews: some View {
        StatusUIView()
    }
}
