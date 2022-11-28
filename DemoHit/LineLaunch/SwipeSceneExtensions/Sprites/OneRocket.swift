//
//  Rocket.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import SpriteKit

extension SwipeScene {
    func setupRocket() {
        rocket = SKSpriteNode(texture: SKTexture(imageNamed: "rocket"))
        rocket.size = CGSize(width: 60, height: 65)
        rocket.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rocket.position = CGPoint(x: 0, y: -300)
        
        rocket.physicsBody = SKPhysicsBody(texture: rocket.texture!, size: rocket.size)
        rocket.physicsBody?.affectedByGravity = false
        rocket.physicsBody?.categoryBitMask = BitMask.player
        rocket.physicsBody?.collisionBitMask = BitMask.station | BitMask.planet
        rocket.physicsBody?.contactTestBitMask = BitMask.station | BitMask.planet
        rocket.physicsBody?.mass = 1000
        rocket.physicsBody?.friction = 1.0
        
        addChild(rocket)
    }
    
    func animateRocket() {
        let followAction = SKAction.follow(smoothPath(), asOffset: false,
                                           orientToPath: true, speed: physicsWorld.speed)
        followAction.timingMode = .easeIn
        rocket.run(followAction)
    }
    
    func isRocketLand() -> Bool{
            // Rocket
        let topLeftRocket = convert(CGPoint(x: -rocket.size.width/2, y: rocket.size.height/2), from: rocket)
        let topRightRocket = convert(CGPoint(x: rocket.size.width/2, y: rocket.size.height/2), from: rocket)

            // Station
        let topLeft = convert(CGPoint(x: -station.size.width/2, y: station.size.height/2), from: station)
        let bottomLeft = convert(CGPoint(x: -station.size.width/2, y: -station.size.width/2), from: station)
        let topRight = convert(CGPoint(x: station.size.width/2, y: station.size.height/2), from: station)
        let bottomRight = convert(CGPoint(x: station.size.width/2, y: -station.size.width/2), from: station)

            // Angles
        let rocketAngle = GLKMathRadiansToDegrees(Float(rocket.zRotation))
        let stationAngle = GLKMathRadiansToDegrees(Float(station.zRotation))
        print(rocketAngle)
        print(stationAngle)
        
        if  (topLeftRocket.y - topLeft.y) / (bottomLeft.y - topLeft.y) <= (topLeftRocket.x - topLeft.x) / (bottomLeft.x - topLeft.x) && (topLeftRocket.y - topRight.y) / (bottomRight.y - topRight.y) >= (topLeftRocket.x - topRight.x) / (bottomRight.x - topRight.x) &&
            (topRightRocket.y - topLeft.y) / (bottomLeft.y - topLeft.y) <= (topRightRocket.x - topLeft.x) / (bottomLeft.x - topLeft.x) &&
            (topRightRocket.y - topRight.y) / (bottomRight.y - topRight.y) >= (topRightRocket.x - topRight.x) / (bottomRight.x - topRight.x) &&
            abs(abs(rocketAngle) - abs(stationAngle)) < 35 {
               return true
           } else {
               return false
           }
    }
}
