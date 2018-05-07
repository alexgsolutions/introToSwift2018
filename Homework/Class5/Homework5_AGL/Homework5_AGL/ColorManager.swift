//
//  ColorManager.swift
//  Homework5_AGL
//
//  Created by Alexis Gonzalez on 4/14/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation
import UIKit

enum ColorType {
    case Red
    case Blue
    case Random
}

let maxRGBValue: UInt32 = 255
let maxRGBFloatValue: CGFloat  = CGFloat(maxRGBValue)
var randomRGBValue: CGFloat {
    return CGFloat(arc4random_uniform(maxRGBValue))
}

func generateColorList(quantity numberOfColor: Int, colorType:ColorType) -> [ColorViewModel] {
    
    switch colorType {
    case .Red:
        return generateRedColors(quantity: numberOfColor)
    case .Blue:
        return generateBlueColors(quantity: numberOfColor)
    case .Random:
        return generateRandomColors(quantity: numberOfColor)

    }
    
}

private func generateRedColors(quantity: Int)->[ColorViewModel] {
    var randomRedValues: [CGFloat] = []
    
    for _ in 0..<quantity{
        randomRedValues.append(randomRGBValue)
    }
    
    var redColors: [ColorViewModel] = []
    
    for i in  0..<randomRedValues.count {
        let color = UIColor(red: randomRedValues[i] / maxRGBFloatValue, green: 0 / maxRGBFloatValue, blue: 0 / maxRGBFloatValue, alpha: 1)
        let colorName = String(format:"R: %.0f , G: %.0f, B: %.0f, A: %.0f", randomRedValues[i],0,0,1.0)
        let colorViewModel = ColorViewModel(name: colorName, color: color, isSelected: false)
        redColors.append(colorViewModel)
    }
    return redColors
}
private func generateBlueColors(quantity: Int)->[ColorViewModel] {
    var randomColorValues: [CGFloat] = []
    
    for _ in 0..<quantity{
        randomColorValues.append(randomRGBValue)
    }
    
    var listColors: [ColorViewModel] = []
    
    for i in  0..<randomColorValues.count {
        let color = UIColor(red: 0 / maxRGBFloatValue, green: 0 / maxRGBFloatValue, blue: randomColorValues[i] / maxRGBFloatValue, alpha: 1)
        let colorName = String(format:"R: %.0f , G: %.0f, B: %.0f, A: %.0f", 0,0,randomColorValues[i],1.0)
        let colorViewModel = ColorViewModel(name: colorName, color: color, isSelected: false)
        listColors.append(colorViewModel)
    }
    return listColors
}

private func generateRandomColors(quantity: Int)->[ColorViewModel] {
    var listColors: [ColorViewModel] = []
    
    for _ in  0..<quantity {
        let randomRed: CGFloat = randomRGBValue
        let randomGreen: CGFloat = randomRGBValue
        let randomBlue: CGFloat = randomRGBValue
        
        let color = UIColor(red: randomRed / maxRGBFloatValue, green: randomGreen / maxRGBFloatValue, blue: randomBlue / maxRGBFloatValue, alpha: 1)
        let colorName = String(format:"R: %.0f , G: %.0f, B: %.0f, A: %.0f", randomRed,randomGreen,randomBlue,1.0)
        let colorViewModel = ColorViewModel(name: colorName, color: color, isSelected: false)
        listColors.append(colorViewModel)
    }
    return listColors
}
