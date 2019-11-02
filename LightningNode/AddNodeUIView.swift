//
//  AddNodeUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

//class AddNodeState: ObservableObject {
//    @Published var certificate = ""
//    @Published var macaroon = ""
//    @Published var uri = ""
//}

struct AddNodeUIView: View {
//    @ObservedObject var state = AddNodeState()
    @State var certificate: String = ""
    @State var macaroon: String = ""
    @State var uri: String = ""
    @State var showCamera = true

    var body: some View {
        
        VStack {
            
            Text("Add Via camera")
            
            Button("Take picture") {
                print("Tapped camera")
             }
             .padding()
            
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
    }
}

struct AddNodeUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddNodeUIView()
    }
}
