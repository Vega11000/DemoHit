//
//  Asteroid.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import SpriteKit


extension SwipeScene {
    @objc func addAsteroid() {
        let asteroid = SKSpriteNode(imageNamed: "asteroid")
//        let asteroid = SKSpriteNode(texture: SKTexture(imageNamed: "asteroid"))
        asteroid.color = .systemCyan
        asteroid.size = CGSize(width: 40, height: 40)
        asteroid.position = CGPoint(x: -200, y: 200)
        asteroid.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        asteroid.zPosition = 1
        
        let randomScaleFactor = CGFloat.random(in: 0.6...1.4)
        asteroid.setScale(randomScaleFactor)
        
        // randomize movement
        let width = frame.size.width / 2
        let height = frame.size.height / 2 + asteroid.size.height
        let randomX = CGFloat.random(in: -width...width)
        let spawnPoint = CGPoint(x: randomX, y: height)
        let destinationPoint = CGPoint(x: randomX, y: -height)
        
        asteroid.position = spawnPoint
        
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: 20)
//        asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
        asteroid.physicsBody?.categoryBitMask = BitMask.asteroid
        asteroid.physicsBody?.collisionBitMask = BitMask.player
        asteroid.physicsBody?.contactTestBitMask = BitMask.player
        asteroid.physicsBody?.isDynamic = true
        asteroid.physicsBody?.affectedByGravity = false
        asteroid.physicsBody?.mass = 10
        addChild(asteroid)


        let time = TimeInterval.random(in: 3...7)
        var actArray = [SKAction]()
        let moveAct = SKAction.move(to: destinationPoint, duration: time)
        moveAct.timingMode = .easeIn
        actArray.append(moveAct)
        actArray.append(SKAction.removeFromParent())
        asteroid.run(SKAction.sequence(actArray))
        asteroid.run(SKAction.scale(by: CGFloat.random(in: 0.7...0.9), duration: time))
    }
}
