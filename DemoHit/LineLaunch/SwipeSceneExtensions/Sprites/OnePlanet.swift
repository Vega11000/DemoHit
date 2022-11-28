//
//  Planet.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import SpriteKit

extension SwipeScene {
    func animatePlanet() {
        let orbitPath = UIBezierPath(ovalIn: CGRect(x: -100, y: -100, width: 300, height: 80))
        let movement = SKAction.follow(orbitPath.cgPath, asOffset: false, orientToPath: true, speed: 30)
        let movementRepeat = SKAction.repeatForever(movement)
    
        planet.run(movementRepeat)
    }
    
    func setupPlanet() {
        planet = SKSpriteNode(imageNamed: "planet")
        planet.size = CGSize(width: 90, height: 90)
        planet.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        planet.position = CGPoint(x: 0, y: 0)
        
        planet.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        planet.physicsBody?.affectedByGravity = false
        planet.physicsBody?.categoryBitMask = BitMask.planet
        planet.physicsBody?.collisionBitMask = BitMask.player
        planet.physicsBody?.contactTestBitMask = BitMask.player
        planet.physicsBody?.isDynamic = false
        
        addChild(planet)
    }
}
