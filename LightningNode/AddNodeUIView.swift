//
//  AddNodeUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class AddNodeState: ObservableObject {
    @Published var rnc = RemoteNodeConnection(uri: "", certificate: "", macaroon: "")
}

struct AddNodeUIView: View {
    @ObservedObject var state = AddNodeState()
    @State var certificate: String = ""
    @State var macaroon: String = ""
    @State var uri: String = ""
    @State var showCamera = false
    @State var isButtonDisabled = true
    @State var showTab = false
    @State var alertErrorMessage = ""
    @State var alertNeeded = false
    
    var body: some View {
        
        VStack {
            
            Button("Scan Node QR Code") { self.showCamera = true }
                .padding()
                .foregroundColor(.blue)
                .padding()
                .sheet(isPresented: $showCamera, onDismiss: { self.showCamera = false}) { QRUIView() }
            
            Text("Or Add Below")
            
            TextField("Certificate", text: $certificate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Macaroon", text: $macaroon)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("URI", text: $uri)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            NavigationLink(destination: TabUIView()) {
                Text("Add Node")
            }
            .padding()
            .disabled(self.isButtonDisabled)
            
            NavigationLink(destination: TabUIView(), isActive: self.$showTab ) { Spacer().fixedSize() }
            
        }
        .onAppear {
            
            NotificationCenter.default.addObserver(
                forName: NSNotification.Name(rawValue: "loadRNC"),
                object: nil,
                queue: nil
            ) { notification in
                if notification.name.rawValue == "loadRNC" {
                    self.loadRNC()
                    self.submitPressed()
                }
            }
            
            switch loadFromKeychain() {
            case let .success(value):
                Current.remoteNodeConnectionFormatted = value
                self.showTab = true
            case .failure(_):
                break
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
    
    func submitPressed() {
        if
            !self.certificate.isEmpty,
            !self.macaroon.isEmpty,
            !self.uri.isEmpty {
            
            let input = AddNodeViewModelInputs(
                certificateTextFieldInput: self.certificate,
                macaroonTextFieldInput: self.macaroon.trimmingCharacters(in: .whitespacesAndNewlines),
                uriTextFieldInput: self.uri.trimmingCharacters(in: .whitespaces)
            )
            
            addNodeViewModel(input: input) { (output) in
                if output.alertNeeded {
                    self.isButtonDisabled = true
                    self.alertErrorMessage = output.alertErrorMessage
                    self.alertNeeded = true
                } else {
                    self.isButtonDisabled = false
                    self.alertErrorMessage = ""
                    self.alertNeeded = false
                }
            }
        } else {
            self.alertErrorMessage = DataError.remoteNodeInfoMissing.localizedDescription
        }
    }
    
}

struct AddNodeUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddNodeUIView()
    }
}