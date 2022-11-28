//
//  GameOverScene.swift
//  DemoHit
//
//  Created by Игорь Ходжгоров on 28.11.2022.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var newGameButtonNode: SKLabelNode!
    
    override func didMove(to view: SKView) {
        newGameButtonNode = SKLabelNode(text: "Retry")
        newGameButtonNode.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(newGameButtonNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode

        let transition = SKTransition.crossFade(withDuration: 0.5)
        view?.presentScene(gameScene, transition: transition)
    }
}

