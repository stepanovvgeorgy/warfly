//
//  GameScene.swift
//  WarFly
//
//  Created by Georgy Stepanov on 13.01.2020.
//  Copyright © 2020 Georgy Stepanov. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {

    let motionManager = CMMotionManager() // объект, который дает доступ к акселерометру
    
    var xAcceleration: CGFloat = 0 // акселерометр смещение по x
    
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        configureStartScene()
        spawnClouds()
        spawnIslands()
    }
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint, size: self.size)
        self.addChild(background)
        
        let screen = UIScreen.main.bounds // размер экрана пользователя
        
        let island = Island.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(island)
        
        let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)
        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        
        self.addChild(player)
        
        motionManager.accelerometerUpdateInterval = 0.2 // как часто акселерометр должен замерять ускорение
        
        // отлавливаем изменения акселерометра в текущем потоке
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x * 0.7) + self.xAcceleration * 0.3 // ускорение в зависимости от наклона устройства
            }
        }
    }
    
    // генерация облаков
    fileprivate func spawnClouds() {
        // SKAction интервал в пределах которого ничего не происходит
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
            self.addChild(cloud)
        }
        
        // создаем бесконечную последовательность
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        // ставим повторение экшенов
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        
        run(spawnCloudForever)
    }
    
    // генерация островов
    fileprivate func spawnIslands() {
        // SKAction интервал в пределах которого ничего не происходит
        let spawnIslandWait = SKAction.wait(forDuration: 1)
        let spawnIslandAction = SKAction.run {
            let island = Island.populate(at: nil)
            self.addChild(island)
        }
        
        // создаем бесконечную последовательность
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        // ставим повторение экшенов
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        
        run(spawnIslandForever)
    }
    
    // вся физика была просчитана для определенного кадра
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
        
        // перебрать различные ноды с определенным именем
        // stop == 0 - прекращаем перебор
        enumerateChildNodes(withName: "backgroundSprite") { (node, stop) in
            // удаляем ноды по position.y меньше 0
            if node.position.y < -199 {
                node.removeFromParent()
            }
        }
    }
}
