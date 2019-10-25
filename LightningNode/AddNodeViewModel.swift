//
//  AddNodeViewModel.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/17/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import Combine

class AddNodeViewModelCombine {
    // prperty wrapper -adds publisher to any property
    @Published var certificateTextFieldInput: String = ""
    @Published var macaroonTextFieldInput: String = ""
    @Published var uriTextFieldInput: String = ""
    
    var readyToZip: AnyPublisher<Bool, Never> {
        
        return Publishers.Zip3(
            validCertificateTextFieldInput,
            validMacaroonTextFieldInput,
            validURITextFieldInput
        )
            .map { if $0, $1, $2 { return false } else { return true } }
            .eraseToAnyPublisher()
        
    }
    
    var readyToSubmit: AnyPublisher<Bool, Never> {
        return Publishers
            .CombineLatest3(
                validCertificateTextFieldInput,
                validMacaroonTextFieldInput,
                validURITextFieldInput
        )
//            .map { if $0, $1, $2 { return false } else { return true } } // is hidden
            .map { if $0, $1, $2 { return true } else { return false } } // is enabled
            .eraseToAnyPublisher()
        
        //            .map { value1, value2, value3 in
        //                print("value 1: \(value1)")
        //
        //                print("value 2: \(value2)")
        //
        //                print("value 3: \(value3)")
        //
        //                if value1 == true, value2 == true, value3 == true {
        //                    print("all systems go!")
        //                    return false//true
        //                } else {
        //                    return true//false
        //                }
        //
        //            }
        //            .eraseToAnyPublisher()
        
    }
    
    var validCertificateTextFieldInput: AnyPublisher<Bool, Never> {
        return $certificateTextFieldInput
            .debounce(for: 0.2, scheduler: RunLoop.main)
            //            .removeDuplicates()
            .map{$0.count > 0 ? true : false}
            .eraseToAnyPublisher()
    }
    
    var validMacaroonTextFieldInput: AnyPublisher<Bool, Never> {
        return $macaroonTextFieldInput
            .debounce(for: 0.2, scheduler: RunLoop.main)
            //            .removeDuplicates()
            .map{$0.count > 0 ? true : false}
            .eraseToAnyPublisher()
    }
    
    var validURITextFieldInput: AnyPublisher<Bool, Never> {
        return $uriTextFieldInput
            .debounce(for: 0.2, scheduler: RunLoop.main)
            //            .removeDuplicates()
            .map{$0.count > 0 ? true : false}
            .eraseToAnyPublisher()
    }
    
}


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
