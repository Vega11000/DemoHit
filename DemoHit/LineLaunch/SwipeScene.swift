//
//  GameScene.swift
//  RocketSwipeGameplay
//
//  Created by kpigalkin on 22.11.2022.
//

import SpriteKit
import GameplayKit

class SwipeScene: SKScene, SKPhysicsContactDelegate {
    
    weak var viewController: SwipeViewController?
    
    // MARK: - Properties
    
    // Nodes
    var rocket = SKSpriteNode()
    var station = SKSpriteNode()
    var planet = SKSpriteNode()
    var swipeNode = SKShapeNode()
    
    var isActive = false
        
    // Swipe
    var path = UIBezierPath()
    var pathPoints = [CGPoint]()
    
    // Timer
    var gameTimer = Timer()
    
    // MARK: - Setup scene
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        physicsWorld.contactDelegate = self
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.speed = 200
        
        setupBackgroundImage()
        setupSwipe()
        setupRocket()
        setupStation()
        setupPlanet()
        animatePlanet()
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(addAsteroid), userInfo: nil, repeats: true)
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        isActive = true
        
        pathPoints.removeAll()
        path = UIBezierPath()
        
        let point = touch.location(in: self)
        pathPoints.append(point)
        
        drawSwipe()
        swipeNode.removeAllActions()
        swipeNode.alpha = 1
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        
        pathPoints.append(point)
        drawSwipe()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard pathPoints.count > 2,
              pathPoints.count < 50,
              let firstPoint = pathPoints.first,
              let lastPoint = pathPoints.last,
              distanceBetween(previousPoint: firstPoint, currentPoint: lastPoint) > frame.size.height / 3
        else { return }
        
        
        /// Swipe works only from rocket
        guard let touchPoint = pathPoints.first,
              rocket.contains(touchPoint)
        else { return }
        
        animateRocket()
        swipeNode.run(SKAction.fadeOut(withDuration: 0.3))
    }
    
    // MARK: - Contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch collision {
        case BitMask.player | BitMask.planet:
            gameOver(isWin: false)
        case BitMask.player | BitMask.station:
            gameOver(isWin: isRocketLand())
        case BitMask.player | BitMask.asteroid:
            if isActive == true {
                gameOver(isWin: false)
            }
        default:
            return
        }
    }
}

extension SwipeScene {
    func setupBackgroundImage() {
        let backgroundImage = SKSpriteNode(imageNamed: "background")
        backgroundImage.size = self.size
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
    }
}
