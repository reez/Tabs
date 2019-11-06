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

struct AddNodeUIView: View {
    @ObservedObject var state = AddNodeState()
    @State var certificate: String = ""
    @State var macaroon: String = ""
    @State var uri: String = ""
    @State var showCamera = false
    @State var isButtonDisabled = true
    @State var showTab = false
    
    func loadRNC(){
        if let lndConnect = Current.remoteNodeConnection {
            self.certificate = lndConnect.certificate
            self.macaroon = lndConnect.macaroon
            self.uri = lndConnect.uri
            self.isButtonDisabled = false
        } else {
            self.isButtonDisabled = true
        }
        print("loadRNC")
    }
    
    var body: some View {
        
        VStack {
            
            Text("Add Via camera")
            
            Button("Camera Swift UI") { self.showCamera = true }
                .padding()
                .foregroundColor(.blue)
                .padding()
                .sheet(
                    isPresented: $showCamera,
                    onDismiss: { self.showCamera = false})
                { QRUIView() }
            
            Text("Or Add below manually")
            
            TextField("Certificate", text: $certificate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Macaroon", text: $macaroon)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("URI", text: $uri)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            NavigationLink(destination: TabUIView()) {
                Text("Show Detail View")
            }
            .padding()
            .disabled(self.isButtonDisabled)
            
            NavigationLink(destination: TabUIView(), isActive: self.$showTab ) { Spacer().fixedSize() }
            
        }
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loadRNC"), object: nil, queue: nil)
            { note in
                if note.name.rawValue == "loadRNC" {
                    self.loadRNC()
                    self.hasNodeReady()
                } else {
                    print("not loadrnc notification")
                }
            }
            
            switch loadFromKeychain() {
            case let .success(value):
                Current.remoteNodeConnectionFormatted = value
                // need to push tabbar here if have something
                self.showTab = true
                NavigationLink(destination: TabUIView(), isActive: self.$showTab ) { Spacer().fixedSize() }
                
            case let .failure(error):
                print(error)
            }
            
        }
        
    }
}

extension AddNodeUIView {
    
    func hasNodeReady() {
        if
            //                    let certificate = self.certificate,
            //                            let macaroon = self.macaroon.trimmingCharacters(in: .whitespacesAndNewlines),
            //                            let uri = self.uritrimmingCharacters(in: .whitespaces),
            !self.certificate.isEmpty,
            !self.macaroon.isEmpty,
            !self.uri.isEmpty {
            
            let input = AddNodeViewModelInputs(
                certificateTextFieldInput: self.certificate,
                macaroonTextFieldInput: self.macaroon,
                uriTextFieldInput: self.uri
            )
            
            addNodeViewModel(input: input) { (output) in
                if !output.alertNeeded {
                    print("dude present the tab view!")
                } else {
                    print("alert needed")
                }
            }
        } else {
            print("someting empty")
        }
    }
    
}

struct AddNodeUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddNodeUIView()
    }
}
