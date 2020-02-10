//
//  ActivityIndicatorView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 2/10/20.
//  Copyright © 2020 Matthew Ramsden. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        uiView.startAnimating()
    }
    
}
