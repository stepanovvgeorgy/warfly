//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Georgy Stepanov on 13.01.2020.
//  Copyright © 2020 Georgy Stepanov. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    let motionManager = CMMotionManager() // объект, который дает доступ к акселерометру
    
    var xAcceleration: CGFloat = 0 // акселерометр смещение по x
    
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        
        // создаем текстуру на основе изображения
        // текстура может меняться
        // используя покадровую анимацию .atlas
        
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        
        // создаем спрайт нод на основе текстуры
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
    
    func checkPosition() {
        
        self.position.x += xAcceleration * 30
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {
        
        motionManager.accelerometerUpdateInterval = 0.2 // как часто акселерометр должен замерять ускорение
        
        // отлавливаем изменения акселерометра в текущем потоке
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x * 0.7) + self.xAcceleration * 0.3 // ускорение в зависимости от наклона устройства
            }
        }
    }
}
