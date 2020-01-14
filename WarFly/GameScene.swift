//
//  GameScene.swift
//  WarFly
//
//  Created by Georgy Stepanov on 13.01.2020.
//  Copyright © 2020 Georgy Stepanov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: PlayerPlane!
    
    override func didMove(to view: SKView) {
        configureStartScene()
        spawnClouds()
        spawnIslands()
        player.performFly()
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
        // перебрать различные ноды с определенным именем
        // stop == 0 - прекращаем перебор
        
        player.checkPosition()
        
        enumerateChildNodes(withName: "backgroundSprite") { (node, stop) in
            // удаляем ноды по position.y меньше 0
            if node.position.y < -199 {
                node.removeFromParent()
            }
        }
    }
}
