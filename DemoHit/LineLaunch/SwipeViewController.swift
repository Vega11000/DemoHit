//
//  GameViewController.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 22.11.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class SwipeViewController: UIViewController {
    private lazy var spriteView: SKView = SKView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        view = spriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = spriteView
        guard let view = view as? SKView else { return }
//        if let view = self.view as! SKView? {
            let scene = SwipeScene(size: self.view.bounds.size)
            scene.viewController = self
            scene.scaleMode = .aspectFit
            scene.view?.showsPhysics = true
            
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
//        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
}
