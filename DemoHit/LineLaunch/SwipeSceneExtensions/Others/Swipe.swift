//
//  Swipe.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import SpriteKit

extension SwipeScene {
    func setupSwipe() {
        swipeNode = SKShapeNode()
        swipeNode.lineWidth = 7
        swipeNode.zPosition = 0
        addChild(swipeNode)
    }
    
    func drawSwipe() {
        guard pathPoints.count > 3 else {
            swipeNode.path = nil
            return
        }
        
        path.removeAllPoints()
        path.move(to: pathPoints[0])
        for point in pathPoints {
            path.addLine(to: point)
        }
        swipeNode.path = path.cgPath
    }
}
