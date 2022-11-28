//
//  Destination.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import SpriteKit

extension SwipeScene {
    func setupStation() {
        station.color = UIColor.red
        station.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        station.position = CGPoint(x: 130, y: 350)
        station.size = CGSize(width: 100, height: 100)
        station.zRotation = .pi/4
        
        station.physicsBody = SKPhysicsBody(rectangleOf: station.size)
        station.physicsBody?.affectedByGravity = false
        station.physicsBody?.isDynamic = false
        station.physicsBody?.categoryBitMask = BitMask.station
        station.physicsBody?.collisionBitMask = BitMask.player
        station.physicsBody?.contactTestBitMask = BitMask.player
        station.physicsBody?.allowsRotation = false
        station.physicsBody?.friction = 1.0

        
//        let greenRect = SKSpriteNode(color: .green, size: CGSize(width: station.size.width, height: station.size.width / 3))
//        greenRect.position = station.position
//        greenRect.zPosition = 2
//        greenRect.anchorPoint = station.anchorPoint
//
        
        addChild(station)
    }
}
