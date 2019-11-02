//
//  SettingsUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var alias = "Getting Node Alias..."
    @Published var pubkey = "Getting Pubkey..."
    @Published var version = "Getting LND Version..."
}

struct SettingsUIView: View {
    @State var showAlert = false
    @ObservedObject var state = AppState()
    
    var body: some View {
        
        VStack {
            
            Text("Alias")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(state.alias)
                .font(.subheadline)
            
            Text("Identity Pubkey")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(state.pubkey)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Text(state.version)
                .font(.caption)
                .fontWeight(.light)
            
            Text("Tabs LND Version: 0.8.0")
                .font(.caption)
                .fontWeight(.light)
            
            
            Button.init("Remove Node") {
                self.showAlert = true
            }
            .padding()
            .foregroundColor(.red)
            .padding()
        }
        .alert(
            isPresented: $showAlert,
            content: { alert }
        )
            .onAppear {
                switch Current.keychain.load() {
                case let .success(savedConfig):
                    self.state.alias = "Success"
                    Current.remoteNodeConnectionFormatted = savedConfig
                    Current.lightningAPIRPC.info {  result in // [weak self]
                        try? result.get()
                            |> flatMap {
                                //self?.viewModel.lightningNodeInfo = $0
                                self.state.alias = "\($0.alias)"
                                self.state.pubkey = "\($0.identityPubkey)"
                                self.state.version = "LND Version: \($0.version)"
                        }
                    }
                case .failure(_):
                    self.state.alias = "Fail"
                    print("Failed")
                }
                
        }
        
    }
}

extension SettingsUIView {
    
    var alert: Alert {
        
        Alert(
            title: Text("REmmy"),
            primaryButton: Alert.Button.default(Text("Get out!"), action: {
                // TODO - make this pop back and work
                
                //deleteFromKeychain()
                //Current.remoteNodeConnection = RemoteNodeConnection(uri: "", certificate: "", macaroon: "")
                //self.presentationMode.wrappedValue.dismiss()
                print("Oked")
            }),
            secondaryButton: Alert.Button.cancel({
                print("Cancelled")
            })
        )
        
    }
}

//struct SettingsUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsUIView()
//    }
//}
