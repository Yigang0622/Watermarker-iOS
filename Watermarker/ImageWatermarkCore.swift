//
//  ImageWatermarkCore.swift
//  Watermarker
//
//  Created by Yigang Zhou on 2020/12/31.
//

import UIKit

class ImageWatermarkCore {
    
    private var image: UIImage
    private var watermarkConfiguration: WatermarkConfiguration!
    var fontSize:CGFloat = 0
    var opacity:CGFloat = 0
    var seperation:CGFloat = 0
    
    typealias ImageWatermarkUpdateBlock = (UIImage) -> Void
    private var imageWatermarkUpdateBloack: ImageWatermarkUpdateBlock?
    
    init(image: UIImage) {
        self.image = image
        self.watermarkConfiguration = WatermarkConfiguration(w: Int(image.cgImage!.width), h: Int(image.cgImage!.height))
        self.opacity = watermarkConfiguration.opacity(withFactor: 0.5)
        self.fontSize = watermarkConfiguration.fontSize(withFactor: 0.5)
        self.fontSize = watermarkConfiguration.fontSize(withFactor: 0.5)
    }
    
    
    private func updateWatermark() {
        let image = addWaterMarkToImage(drawText: watermarkConfiguration.content, inImage: self.image, atPoint: CGPoint.zero)
        self.imageWatermarkUpdateBloack?(image)
    }
    
    func getWatermarkedImage() -> UIImage {
        return addWaterMarkToImage(drawText: watermarkConfiguration.content, inImage: self.image, atPoint: CGPoint.zero)
    }
    
    func updateOpacity(withFactor: Float) {
        self.opacity = watermarkConfiguration.opacity(withFactor: withFactor)
        updateWatermark()
    }
    
    func updateFontSize(withFactor: Float) {
        self.fontSize = watermarkConfiguration.fontSize(withFactor: withFactor)
        updateWatermark()
    }
    
    func updateSeperation(withFactor: Float) {
        self.seperation = watermarkConfiguration.seperation(withFactor: withFactor)
        updateWatermark()
    }
    
    func updateContent(content: String) {
        self.watermarkConfiguration.content = content
        updateWatermark()
    }
    
    func updateColor(color: UIColor) {
        self.watermarkConfiguration.watermarkColor = color
        updateWatermark()
    }
    
    func onImageWatermarkUpdate(blcok: @escaping ImageWatermarkUpdateBlock){
        self.imageWatermarkUpdateBloack = blcok
    }
    
    private func addWaterMarkToImage(drawText: String, inImage: UIImage, atPoint: CGPoint) -> UIImage{

        let imageWidth = inImage.cgImage?.width
        let imageHeight = inImage.cgImage?.height
        
        let textColor = watermarkConfiguration.watermarkColor.withAlphaComponent(self.opacity)
        let textFont = UIFont(name: "Helvetica Bold", size: fontSize)!
        

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        let c = UIGraphicsGetCurrentContext()!
        c.saveGState()
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]

        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        c.translateBy(x: atPoint.x, y: atPoint.y)
        c.rotate(by: -45 * .pi / 180)
        
        
        var y = -imageHeight!
        while y < imageHeight! * 2 {
            var x = -imageWidth!
            while x < imageWidth! * 2 {
                let rect = CGRect(x: atPoint.x + CGFloat(x), y: atPoint.y + CGFloat(y), width: inImage.size.width, height: inImage.size.height)
                drawText.draw(in: rect, withAttributes: textFontAttributes)
                x += Int(drawText.width(font: textFont) + self.seperation)
            }
            y += Int(drawText.height(font: textFont) + self.seperation)
        }

 
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!

    }
    
}

extension String {
    func height(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
