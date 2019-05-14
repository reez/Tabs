//
//  AddNodeViewModel.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/17/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

struct AddNodeViewModelInputs {
    let certificateTextFieldInput: String
    let macaroonTextFieldInput: String
    let uriTextFieldInput: String
}

struct AddNodeViewModelOutputs {
    var alertErrorMessage: String
    var alertNeeded: Bool
}

func addNodeViewModel(
    input: AddNodeViewModelInputs,
    output: @escaping (AddNodeViewModelOutputs) -> Void
    )
{
    var viewModelOutput = AddNodeViewModelOutputs(
        alertErrorMessage: "Unexpected Error",
        alertNeeded: true
    )
    
    let cert = Pem(key: input.certificateTextFieldInput).string
    let formattedMacaroon = input.macaroonTextFieldInput.replacingOccurrences(of: " ", with: "")
    guard let data = Data(base64Encoded: formattedMacaroon) else {
        viewModelOutput.alertNeeded = true
        viewModelOutput.alertErrorMessage = "Could not use format of Macaroon"
        output(viewModelOutput)
        return
    }
    viewModelOutput.alertNeeded = false
    viewModelOutput.alertErrorMessage = "Unexpected Error"
    let mac = data.hexDescription
    let rnc = RemoteNodeConnection(
        uri: input.uriTextFieldInput,
        certificate: cert,
        macaroon: mac
    )
    
    Current.remoteNodeConnectionFormatted = rnc
    let resultSavedPost = Current.keychain.save(rnc)
    switch resultSavedPost {
    case .success(_):
        viewModelOutput.alertNeeded = false
        output(viewModelOutput)
    case let .failure(error):
        viewModelOutput.alertNeeded = true
        viewModelOutput.alertErrorMessage = error.localizedDescription
        output(viewModelOutput)
    }
    
}
