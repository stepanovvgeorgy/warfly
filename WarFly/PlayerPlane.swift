//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Georgy Stepanov on 13.01.2020.
//  Copyright © 2020 Georgy Stepanov. All rights reserved.
//

import SpriteKit

class PlayerPlane: SKSpriteNode {

    static func populate(at point: CGPoint) -> SKSpriteNode {
        
        // создаем текстуру на основе изображения
        // текстура может меняться
        // используя покадровую анимацию .atlas
        
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        
        // создаем спрайт нод на основе текстуры
        let playerPlane = SKSpriteNode(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
    
}
