//
//  Cardify.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 17/05/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    let color:Color
    
    var isFacedUp: Bool{
        rotation<90
    }
    
    var animatableData: Double{
        get {return rotation}
        set {rotation = newValue}
    }
    
    init(isFacedUp: Bool, color: Color){
        rotation = isFacedUp ? 0 : 180
        self.color = color
    }
    
    private let cornerRadius: CGFloat = 25.0
    private let lineWidth: CGFloat = 3
    
    
    
    func body(content: Content) -> some View {
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius, style: .circular).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius, style: .circular).stroke(lineWidth: lineWidth).fill(color)
                content
            }
                .opacity(isFacedUp ? 1: 0)
            RoundedRectangle(cornerRadius: cornerRadius, style: .circular).fill(color)
                .opacity(isFacedUp ? 0: 1)
        }
        .rotation3DEffect(
            Angle(degrees: rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
}

extension View{
    func cardify(isFacedUp: Bool, color: Color) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp, color: color))
    }
}
