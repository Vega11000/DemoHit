//
//  Rocket.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 22.11.2022.
//

import SpriteKit

final class Rocket {
    
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

        let texture = SKTexture(imageNamed: "rocket2")
        let shapeNode = SKSpriteNode(texture: texture, size: CGSize(width: 40, height: 80))
        let body = SKPhysicsBody(texture: shapeNode.texture!, size: shapeNode.size)
        body.mass = mass
        body.affectedByGravity = false
        body.allowsRotation = false

        shapeNode.physicsBody = body
        body.categoryBitMask = spaceshipCategory
        body.collisionBitMask = planetCategory
        body.contactTestBitMask = planetCategory
        
        shapeNode.zPosition = 2
        node = shapeNode
    }
    
    //TODO добавить свойство bool значение, есть вектор или нет
    
    func applyGravitationalAttraction(to planet: Planet) {
        let gravitationalConstant : CGFloat = 250                               // грав постоянная
        let offset = create(a: planet.position, b: position)                    //вектор от одной до другой
        let length = length(a: offset)                                          //длина вектора
        let direction = normalize(a: offset)                                    //единичный вектор

        let force = gravitationalConstant * ((planet.mass * mass) / (length) )  //я знаю, что радиус в квадрате должен быть, но так играбельнее)))
        
        let forceVector = mult(a: direction, b: force)                          //вектор перемножаем на силу притяжения
        
        node.physicsBody?.applyForce(forceVector)
        node.zRotation = -atan2(node.physicsBody!.velocity.dx, node.physicsBody!.velocity.dy)
    }
}
