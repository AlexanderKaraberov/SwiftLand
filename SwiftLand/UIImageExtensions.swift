//
//  UIImageExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/27/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


extension UIImage {
    
    /// Crops the largest square from the image center
    func cropSquaredCenter() -> UIImage? {
        
        let originalWidth = self.size.width
        let originalHeight = self.size.height
        
        let edge: CGFloat = fmin(originalWidth, originalHeight)
        
        let xPosition = (originalWidth - edge) / 2.0
        let yPosition = (originalHeight - edge) / 2.0
        
        var cropSquare: CGRect
        
        if self.imageOrientation == UIImageOrientation.left || self.imageOrientation == UIImageOrientation.right {
            
            cropSquare = CGRect(x: yPosition, y: xPosition, width: edge, height: edge)
        } else {
            
            cropSquare = CGRect(x: xPosition, y: yPosition, width: edge, height: edge)
        }
        
        let imageRef: CGImage! = self.cgImage!.cropping(to: cropSquare)
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    }
    
    
    /// Encode this image as Base64 string
    func encodeToBase64String() -> String {
        
        let compressionQuality: CGFloat = 1.0
        return UIImageJPEGRepresentation(self, compressionQuality).map { (data) -> String in
            return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        } ?? ""
    }
}
