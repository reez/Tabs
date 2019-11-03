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
                .animation(.interactiveSpring())
                .frame(width: 125, height: 125, alignment: .center)
                .foregroundColor(Color(.mr_gold)) //.foregroundColor(state.syncedState ? .green : .red)
            
            Button("Get Info") { self.showAlert = true }
                .padding()
                .foregroundColor(.blue)
                .padding()
                .sheet(
                    isPresented: $showAlert,
                    onDismiss: { self.showAlert = false })
                    { StatusDetailUIView() }
            
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
            //'weak' may only be applied to class and class-bound protocol types, not 'StatusUIView'
            Current.lightningAPIRPC.info {  result in //[weak self]
                try? result.get()
                    |> flatMap {
                        //                        self?.viewModel.lightningNodeInfo = $0
                        
                        let creationDate = Current.date()
                        let formattedDate = mrDateFormatter.string(from: creationDate)
                        self.state.refreshedLabel = "Refreshed: \(formattedDate)"
                        
                        $0.syncedToChain ?
                            (self.state.syncedImage = "checkmark.circle") :
                            (self.state.syncedImage = "xmark.circle")
                        
//                        print("syncedIM: \(self.state.syncedImage)")
                        
                        $0.syncedToChain ?
                            (self.state.syncedState = true) :
                            (self.state.syncedState = false)
                        
//                        print("s2c: \($0.syncedToChain)")
//                        print("sS: \(self.state.syncedState)")
                        
                        $0.syncedToChain ?
                            (self.state.syncedLabel = "Synced") :
                            (self.state.syncedLabel = "Not Synced")
                }
            }
        case .failure(_):
            print("Status fetch failure")
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

struct StatusUIView_Previews: PreviewProvider {
    static var previews: some View {
        StatusUIView()
        
//        Group {
//            StatusUIView()
//                .colorScheme(.light)
//            StatusUIView()
//                .colorScheme(.dark)
//        }
        
    }
}
