//
//  CAGradientLayer.swift
//  Instagram-Parse
//
//  Created by Tasfia Addrita on 3/5/16.
//  Copyright © 2016 Tasfia Addrita. All rights reserved.
//

import UIKit

extension CAGradientLayer {

    func instagram() -> CAGradientLayer {
        
        let topColor = UIColor(red: 237/255, green: 66/255, blue: 100/255, alpha: 1)
        let bottomColor = UIColor(red: 255/255, green: 237/255, blue: 188/255, alpha: 1)
        
        let gradientColors: [CGColorRef] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
        
    }
    
}
