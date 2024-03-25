import SwiftUI

struct BottomAlignedRectangleShape: Shape {
    let height: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let rectWidth = rect.width
        let rectHeight = rect.height
        
        let path = UIBezierPath(
            rect: CGRect(
                x: 0,
                y: rectHeight - height,
                width: rectWidth,
                height: height
            )
        )
        
        return Path(path.cgPath)
    }
}

