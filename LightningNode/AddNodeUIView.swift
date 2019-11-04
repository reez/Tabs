//
//  AddNodeUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class AddNodeState: ObservableObject {
//    @Published var certificate = ""
//    @Published var macaroon = ""
//    @Published var uri = ""
    @Published var rnc = RemoteNodeConnection(uri: "", certificate: "", macaroon: "") 
}

class UserSettings: ObservableObject {
    @Published var score = 0
}

struct AddNodeUIView: View {
    @ObservedObject var state = AddNodeState()
    @State var certificate: String = ""
    @State var macaroon: String = ""
    @State var uri: String = ""
    @State var showCamera = false
    @State var isLoggedIn = false

    var body: some View {
        
        VStack {
            
            Text("Add Via camera")
            
            Button("Take picture") {
                print("Tapped camera")
             }
             .padding()
 
            Button("Camera Swift UI") { self.showCamera = true }
                 .padding()
                 .foregroundColor(.blue)
                 .padding()
                 .sheet(
                     isPresented: $showCamera,
                     onDismiss: { self.showCamera = false})
                 { CameraUIView() }
                
            Text("Or Add below manually")
            
            TextField("Certificate", text: $certificate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Macaroon", text: $macaroon)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("URI", text: $uri)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            Button("Add Node") {
                
            }
            .padding()
            //            .disabled(self.isAddNodeButtonDisabled)
            
        }
        .onAppear {
            print(Current.remoteNodeConnection)
            print(Current.remoteNodeConnectionFormatted)
                    switch loadFromKeychain() {
                    case let .success(value):
                        Current.remoteNodeConnectionFormatted = value
                        self.isLoggedIn = true

                    case let .failure(error):
                        print(error)
                    }
        }
        
        
    }
}

extension AddNodeUIView {
    func loadRNC(){
        if let lndConnect = Current.remoteNodeConnection {
            self.certificate = lndConnect.certificate
            self.macaroon = lndConnect.macaroon
            self.uri = lndConnect.uri
        }
    }
}

struct AddNodeUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddNodeUIView()
    }
}
