//
//  Pie.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 16/05/21.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle : Angle
    var endAngle : Angle
    var clockwise : Bool = false
    
    var animatableData: AnimatablePair<Double,Double>{
        get{
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set{
            startAngle = Angle(radians: newValue.first)
            endAngle = Angle(radians: newValue.second)
        }
    }
    
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)
        path.addLine(to: center)
        
        return path
    }
    
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: -270), clockwise: true).fill(Color.black)
    }
}
