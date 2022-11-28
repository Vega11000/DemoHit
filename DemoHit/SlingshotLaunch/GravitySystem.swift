//
//  GravitySystem.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 21.11.2022.
//

import SpriteKit

final class GravitySystem : SKNode {
    
    private var rocket: Rocket?
    private var planets = [Planet]()
    private var lineTrailFadeDuration = 1.5
    
    func add(planet: Planet) {
        planet.node.physicsBody?.isDynamic = false
        planets.append(planet)
        addChild(planet.node)
    }
    
    func addRocket(rocket: Rocket) {
        self.rocket = rocket
        addChild(rocket.node)
    }
    
    func startRocket(vector: CGVector) {
        rocket?.node.physicsBody?.velocity = CGVector(dx: vector.dx, dy: vector.dy)
    }
    
    func rotateRocket(vector: CGVector) {
        rocket?.node.zRotation = -atan2(vector.dx, vector.dy)
    }
        
    func update() {
        if GameScene.userHasSetAVector == true {
            addTrailSegment(for: rocket!)
            for planet in planets {
                rocket!.applyGravitationalAttraction(to: planet)
            }
        }
    }
    
    private func addTrailSegment(for rocket: Rocket) {          //TODO либо поменять название класса, либо вынести метод в другой класс
        if let lastPosition = rocket.lastPosition {
            let path = CGMutablePath()
            path.move(to: lastPosition)
            path.addLine(to: rocket.position)

            let lineSeg = SKShapeNode(path: path)
            lineSeg.lineCap = .butt
            lineSeg.lineWidth = 5
            lineSeg.strokeColor = .red
            lineSeg.fillColor = .red
            addChild(lineSeg)

            lineSeg.run(SKAction.sequence([SKAction.fadeOut(withDuration: lineTrailFadeDuration), SKAction.removeFromParent()]))
        }
        rocket.lastPosition = rocket.position
    }
}
