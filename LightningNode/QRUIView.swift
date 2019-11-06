//
//  QRUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/5/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

struct QRUIView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> QRUIView.Coordinator {
        Coordinator(CameraViewController())
    }
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let vc = CameraViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ vc: CameraViewController, context: Context) {
    }

    class Coordinator: NSObject, QRCodeScannerDelegate {
        
        func codeDidFind(_ code: String) {
            print(code)
        }
        
        var parent: CameraViewController
        
        init(_ parent: CameraViewController) {
            self.parent = parent
        }
    }
    
    
}

struct QRUIView_Previews: PreviewProvider {
    static var previews: some View {
        QRUIView()
    }
}
