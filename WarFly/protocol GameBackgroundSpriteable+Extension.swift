//
//  protocol GameBackgroundSpriteable+Extension.swift
//  WarFly
//
//  Created by Georgy Stepanov on 14.01.2020.
//  Copyright © 2020 Georgy Stepanov. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable {
    static func populate(at point: CGPoint?) -> Self // Self - вернется либо тип протокола, либо тип класса внутри которого реализуется метод
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height + 100), highestValue: Int(screen.size.height + 200))
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        
        return CGPoint(x: x, y: y)
    }
}
