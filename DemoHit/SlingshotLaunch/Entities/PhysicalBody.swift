//
//  StaticPlanet.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 24.11.2022.
//

import SpriteKit

class PhysicalBody {
    
    let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    let node: SKNode
    
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
        
    init(mass: CGFloat) {               //TODO добавить параметр imageName: String
        let safeRadius = max(0.5, mass)
        let shapeNode = SKShapeNode.init(circleOfRadius: safeRadius)
        let body = SKPhysicsBody(circleOfRadius: safeRadius)
        body.mass = mass
        body.affectedByGravity = false
        body.allowsRotation = false
        
        shapeNode.physicsBody = body
        body.collisionBitMask = 0
        
        shapeNode.fillColor = self.color
        
        node = shapeNode
    }
}
