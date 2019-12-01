//
//  SettingsUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var alias = "Getting Node Alias..."
    @Published var pubkey = "Getting Pubkey..."
    @Published var version = "Getting LND Version..."
}

struct SettingsUIView: View {
    @State var removedNode = false
    @ObservedObject var state = AppState()
    
    var body: some View {
        
        VStack {
            
            VStack(spacing: 15.0) {
                
                VStack {
                    
                    Text(Constants.alias.rawValue)
                        .font(.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                    
                    Text(state.alias)
                        .font(.system(.subheadline, design: .monospaced))
                    
                }
                
                VStack {
                    
                    Text(Constants.pubkey.rawValue)
                        .font(.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                    
                    Text(state.pubkey)
                        .font(.system(.subheadline, design: .monospaced))
                        .multilineTextAlignment(.center)
                    
                }
                
                VStack {
                    
                    Text(Constants.tabsVersion.rawValue)
                        .font(.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                    
                    Text(state.version)
                        .font(.system(.footnote, design: .monospaced))
                        .multilineTextAlignment(.center)
                    
                }
                
            }
            .padding()
            
            Button.init("Remove Node") {
                self.removedNode = true
                Current.remoteNodeConnection = RemoteNodeConnection(uri: "", certificate: "", macaroon: "")
                Current.remoteNodeConnectionFormatted = RemoteNodeConnection(uri: "", certificate: "", macaroon: "")
                deleteFromKeychain()
            }
            .font(.system(.headline, design: Font.Design.monospaced))
            .padding()
            
            NavigationLink(destination: AddNodeUIView(), isActive: self.$removedNode ) { Spacer().fixedSize() }
            
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .onAppear {
            switch Current.keychain.load() {
            case let .success(savedConfig):
                self.state.alias = "Success"
                Current.remoteNodeConnectionFormatted = savedConfig
                Current.lightningAPIRPC.info {  result in
                    try? result.get()
                        |> flatMap {
                            self.state.alias = "\($0.alias)"
                            self.state.pubkey = "\($0.identityPubkey)"
                            self.state.version = "\(Constants.lndVersion.rawValue) \($0.version)"
                    }
                }
            case .failure(_):
                break
            }
            
        }
        
    }
}

struct SettingsUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUIView()
    }
}
