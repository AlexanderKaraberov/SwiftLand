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
        
        if self.imageOrientation == UIImageOrientation.Left || self.imageOrientation == UIImageOrientation.Right {
            
            cropSquare = CGRectMake(yPosition, xPosition, edge, edge)
        } else {
            
            cropSquare = CGRectMake(xPosition, yPosition, edge, edge)
        }
        
        let imageRef: CGImageRef! = CGImageCreateWithImageInRect(self.CGImage, cropSquare)
        return UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    }
    
    
    /// Encode this image as Base64 string
    func encodeToBase64String() -> String {
        
        let compressionQuality: CGFloat = 1.0
        let imageData: NSData = UIImageJPEGRepresentation(self, compressionQuality)
        return imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
    }
}
