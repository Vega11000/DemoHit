import SpriteKit

final class GameScene: SKScene {
    
    private var background: SKSpriteNode?
    private let gravitySystem = GravitySystem()                 //система, куда добавляются ноды с физ. данными и где осуществляется гравитация
    private var indicatorNode: SKSpriteNode?                    //Индикатор силы запуска
    
    static var userHasSetAVector: Bool = false                  //Задал ли пользователь вектор движению ракеты
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let powerIncreaseStep: Double = 100.0                //Шаг для увелечения мощности запуска ракеты
    private let timeForMostPowerfulLaunch: Double = 5          //Время, нужное для запуска ракеты на полную мощность(потолок)
    
    private var timeAtTouchDown = Date.timeIntervalSinceReferenceDate
    private lazy var locationOfTouchDown = CGPoint()
    private var placerLine: SKShapeNode?                        //нод для отображения вектора
    private var userTapped: Bool = false
    
    private enum Constants {
        static var widthConstant: CGFloat = 50
        static var heightConstant: CGFloat = 50
        static var multiply: CGFloat = 10
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        setNodes()
        addChilds()
        setupGestureRecognizer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        gravitySystem.update()
        
        if userTapped && indicatorNode?.hasActions() == false {
            indicatorNode?.color = .green
            indicatorNode?.size.height = Constants.heightConstant
            startIndicatorAction()
        }
    }
}

private extension GameScene {
    
    func setNodes() {
        background = setNode(an: "background",
                             at: CGPoint(x: frame.size.width/2, y: frame.size.height/2),
                             level: 0)
        
        indicatorNode = setNode(an: nil, at: CGPoint(x: size.width / 10, y: size.height / 8), level: 0)
        indicatorNode?.size = CGSize(width: Constants.widthConstant, height: Constants.heightConstant)
        indicatorNode?.color = .green
    }
    
    func addChilds() {
        let emptyNode = SKSpriteNode()
        
        addChild(background ?? emptyNode)
        addChild(indicatorNode ?? emptyNode)
        addChild(gravitySystem)
        setNodesInGravitySystem()
    }
    
    func setNodesInGravitySystem() {
        let factory = FactoryPlanets()
        let mediumPlanet = factory.getMediumPlanet()
        let bigPlanet = factory.getBigPlanet()
        mediumPlanet.position = CGPoint(x: size.width / 1.3, y: size.height / 2.2)
        bigPlanet.position = CGPoint(x: size.width / 3, y: size.height / 1.3)
        
        gravitySystem.add(planet: mediumPlanet)
        gravitySystem.add(planet: bigPlanet)
        
        let rocket = Rocket(mass: 20, imageName: "rocket")
        rocket.position = CGPoint(x: size.width / 2, y: size.height / 6)
        
        gravitySystem.addRocket(rocket: rocket)
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
    
    func setupGestureRecognizer() {
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.addTarget(self, action: #selector(handlePanGestureRecognizer(gesture:)))
        self.view?.addGestureRecognizer(panGestureRecognizer)
    }
    
    func startIndicatorAction() {
        let actionColorize = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: timeForMostPowerfulLaunch)
        let actionSize = SKAction.resize(toHeight: Constants.multiply * Constants.heightConstant, duration: timeForMostPowerfulLaunch)
        indicatorNode?.run(SKAction.group([actionColorize, actionSize]))
    }
    
    @objc func handlePanGestureRecognizer(gesture: UIPanGestureRecognizer) {
        
        var touchLocation = gesture.location(in: gesture.view)
        touchLocation = self.convertPoint(fromView: touchLocation)
        
        switch gesture.state {
        case .began:
            userTapped = true
            startIndicatorAction()
            
            timeAtTouchDown = Date.timeIntervalSinceReferenceDate
            locationOfTouchDown = touchLocation
            
        case .changed:
            let panVector = create(a: locationOfTouchDown, b: touchLocation)
            gravitySystem.rotateRocket(vector: panVector)
            if placerLine != nil {
                placerLine!.removeFromParent()
                placerLine = nil
            }
            
            let placementPath = CGMutablePath()
            placementPath.move(to: locationOfTouchDown)
            placementPath.addLine(to: touchLocation)
            
            placerLine = SKShapeNode(path: placementPath)
            placerLine!.lineCap = .round
            placerLine!.alpha = 0.5
            self.addChild(placerLine!)
            
        case .ended, .failed:
            GameScene.userHasSetAVector = true
            userTapped = false
            
            let durationOfPress = Date.timeIntervalSinceReferenceDate - timeAtTouchDown
            let levelLaunchPower = durationOfPress.truncatingRemainder(dividingBy: timeForMostPowerfulLaunch)
            let launchPower = levelLaunchPower * powerIncreaseStep
            
            var panVector = create(a: locationOfTouchDown, b: touchLocation)
            panVector = normalize(a: panVector)
            panVector = mult(a: panVector, b: CGFloat(launchPower))
            print(launchPower)
            gravitySystem.startRocket(vector: panVector)
            
            indicatorNode?.removeAllActions()
            indicatorNode?.color = .green
            indicatorNode?.size.height = Constants.heightConstant
            placerLine?.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.3),SKAction.removeFromParent()]))
            
        default: break
        }
    }
    
    func displayGameOver() {
        GameScene.userHasSetAVector = false
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameOver = GameOverScene(size: size)
        gameOver.scaleMode = scaleMode
        view?.presentScene(gameOver, transition: transition)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        displayGameOver()
//        print("contact detected")
    }
}

extension GameScene: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == panGestureRecognizer || otherGestureRecognizer == panGestureRecognizer {
            return false
        }
        
        return true
    }
}
