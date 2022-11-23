//
//  GameScene.swift
//  DemoHit
//
//  Created by Илья Калганов on 23.11.2022.
//

import SpriteKit


final class GameScene: SKScene {
    
    private var background: SKSpriteNode?
    private var moon: SKSpriteNode?
    private var knobArea: SKSpriteNode?
    private var knob: SKSpriteNode?
    
    private var knobAction = false
    
    private enum Constants {
        static var weightConstant: CGFloat = 40
        static var heightConstant: CGFloat = 60
        static var xConstant: CGFloat = 20
        static var yConstant: CGFloat = 30
    }
    
    override func didMove(to view: SKView) {
        setNodes()
        addChilds()
    }
    
}

// MARK: Touches

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let knob = knob else { return }
        
        for touch in touches {
            let location = touch.location(in: knob)
            knobAction = knob.frame.contains(location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !knobAction { return }
        
        guard let knob = knob, let knobArea = knobArea else { return }
        
        let knobRadius: CGFloat = 50
        
        for touch in touches {
            let position = touch.location(in: knobArea)
            
            
            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
            let angle = atan2(position.y, position.x)
            
            if knobRadius > length {
                knob.position = position
            } else {
                knob.position = CGPoint(x: cos(angle) * knobRadius, y: sin(angle) * knobRadius)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}

// MARK: - Private methods

private extension GameScene {
    
    func setNodes() {
        background = setNode(an: "game-background",
                             at: CGPoint(x: frame.size.width/2, y: frame.size.height/2),
                             level: 0)
        background?.scale(to: frame.size)
        
        
        moon = setNode(an: "moon",
                       at: CGPoint(x: frame.size.width - 4*Constants.xConstant,
                                   y: frame.size.height - 3*Constants.yConstant),
                       level: 1)
        moon?.scale(to: CGSize(width: 4*Constants.weightConstant, height: 2.5*Constants.heightConstant))
        
        knobArea = setNode(an: nil,
                           at: CGPoint(x: frame.size.width/2, y: frame.size.height/5),
                           level: 1)
        
        knob = setNode(an: "knob",
                       at: CGPoint(x: 0, y: 0),
                       level: 1)
    }
    
    func addChilds() {
        let emptyNode = SKSpriteNode()
        
        addChild(background ?? emptyNode)
        addChild(moon ?? emptyNode)
        addChild(knobArea ?? emptyNode)
        knobArea?.addChild(knob ?? emptyNode)
    }
    
    func setNode(an image: String?, at point: CGPoint, level zPosition: CGFloat) -> SKSpriteNode {
        let node: SKSpriteNode
        
        if let image = image {
            node = SKSpriteNode(imageNamed: image)
        } else {
            node = SKSpriteNode()
        }
        
        node.position = point
        node.zPosition = zPosition
        
        return node
    }
}
