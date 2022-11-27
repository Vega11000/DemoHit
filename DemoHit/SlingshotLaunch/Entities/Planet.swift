//
//  StaticPlanet.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 24.11.2022.
//

import SpriteKit

final class Planet {
    
    let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    let node: SKNode
    
    let spaceshipCategory: UInt32 = 0x1 << 1
    let planetCategory: UInt32 = 0x1 << 0
    
    var position : CGPoint {
        get {
            return node.position
        } set {
            node.position = newValue
        }
    }
    
    var mass : CGFloat {
        get {
            return node.physicsBody!.mass
        } set {
            node.physicsBody!.mass = newValue
        }
    }
    
    var lastPosition : CGPoint?
        
    init(mass: CGFloat, imageName: String) {

        let safeRadius = max(0.5, mass)
        let shapeNode = SKShapeNode(circleOfRadius: safeRadius)
        let body = SKPhysicsBody(circleOfRadius: safeRadius)
        body.mass = mass
        body.affectedByGravity = false
        body.allowsRotation = false

        shapeNode.physicsBody = body
        let planetCategory: UInt32 = 0x1 << 0
        let spaceshipCategory: UInt32 = 0x1 << 1
        body.categoryBitMask = planetCategory
        body.collisionBitMask = spaceshipCategory
        body.contactTestBitMask = planetCategory
        
        shapeNode.fillColor = self.color
        shapeNode.zPosition = 2
        node = shapeNode
    }
}
