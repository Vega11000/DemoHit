//
//  SlingshotLaunchViewController.swift
//  DemoHit
//
//  Created by Илья Калганов on 23.11.2022.
//

import UIKit
import SpriteKit
import GameplayKit


final class SlingshotLaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = SKView(frame: view.bounds)
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)

            scene.scaleMode = .aspectFill

            view.presentScene(scene)
        }
    }
    
    
}

