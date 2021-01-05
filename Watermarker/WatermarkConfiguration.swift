//
//  WatermarkConfiguration.swift
//  Watermarker
//
//  Created by Yigang Zhou on 2020/12/31.
//

import UIKit

//enum WatermarkTextColor {
//    case red
//    case yellow
//    case blue
//    case green
//    case black
//}

class WatermarkConfiguration {
    
    var content: String = "Hello World"
    
    var watermarkColor: UIColor = UIColor.red
    
    private var imageWidth: CGFloat = 0
    private var imageHeight: CGFloat = 0
    
    private var opacityMin: CGFloat = 0
    private var opacityMax: CGFloat = 1
    
    private var fontSizeMin: CGFloat = 0
    private var fontSizeMax: CGFloat = 0
    
    private var seperationMin: CGFloat = 0
    private var seperationMax: CGFloat = 0
    
    init(w: Int, h: Int) {
        self.imageWidth = CGFloat(w)
        self.imageHeight = CGFloat(h)
        
        fontSizeMin = CGFloat(min(self.imageWidth, self.imageHeight) * 0.1)
        fontSizeMax = CGFloat(min(self.imageWidth, self.imageHeight) * 0.3)
        
        seperationMin = CGFloat(min(self.imageWidth, self.imageHeight) * 0.1)
        seperationMax = CGFloat(min(self.imageWidth, self.imageHeight) * 0.3)
    }
    
    func opacity(withFactor: Float) -> CGFloat{
        return (opacityMax - opacityMin) * CGFloat(withFactor)
    }
    
    func fontSize(withFactor: Float) -> CGFloat{
        return (fontSizeMax - fontSizeMin) * CGFloat(withFactor)
    }
    
    func seperation(withFactor: Float) -> CGFloat{
        return (seperationMax - seperationMin) * CGFloat(withFactor)
    }
    
    
    
}
