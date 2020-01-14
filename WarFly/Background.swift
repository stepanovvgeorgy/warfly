//
//  Background.swift
//  WarFly
//
//  Created by Georgy Stepanov on 13.01.2020.
//  Copyright © 2020 Georgy Stepanov. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    
    // метод для установки фона
    static func populateBackground(at point: CGPoint, size: CGSize) -> Background {
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        background.size = size
        
        return background
    }
}
