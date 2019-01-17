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
