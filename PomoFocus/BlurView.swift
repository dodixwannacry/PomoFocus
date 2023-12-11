//
//  BlurView.swift
//  PomoFocus
//
//  Created by Davide Formisano on 06/12/23.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) ->  {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        
        return view
    }
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        
    }
}


