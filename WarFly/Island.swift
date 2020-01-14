//
//  Island.swift
//  WarFly
//
//  Created by Georgy Stepanov on 13.01.2020.
//  Copyright © 2020 Georgy Stepanov. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgroundSpriteable {
    
    // генерация острова
    static func populate(at point: CGPoint?) -> Island {
        let islandImageName = configureName()
        let island = Island(imageNamed: islandImageName)
        island.setScale(randomScaleFactor)
        island.position = point ?? randomPoint()
        island.zPosition = 1
        island.name = "backgroundSprite"
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position))
        
        return island
    }
    
    // генерация случайного масштаба острова
    fileprivate static var randomScaleFactor: CGFloat {
        // GKRandomDistribution рандомное число от 1 до 10
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        // делим полученное число на 10
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    // генерация рандомного имени на основе подготовленных изображений
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distribution.nextInt()
        let imageName = "is" + "\(randomNumber)"
        return imageName
    }
    
    // вращение острова
    fileprivate static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
