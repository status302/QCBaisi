//
//  UIImage+QC.swift
//  pullToScale
//
//  Created by 程庆春 on 16/5/9.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        CGContextFillRect(context, rect)
        
        let returnedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return returnedImage
        
        
        
    }
}