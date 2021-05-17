//
//  Cardify.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 17/05/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFacedUp: Bool
    let color:Color
    
    private let cornerRadius: CGFloat = 25.0
    private let lineWidth: CGFloat = 3
    
    
    
    func body(content: Content) -> some View {
        ZStack{
            if isFacedUp {
                RoundedRectangle(cornerRadius: cornerRadius, style: .circular).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius, style: .circular).stroke(lineWidth: lineWidth).fill(color)
                content
            }
            else {
                RoundedRectangle(cornerRadius: cornerRadius, style: .circular).fill(color)
            }
        }
    }
    
}

extension View{
    func cardify(isFacedUp: Bool, color: Color) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp, color: color))
    }
}
