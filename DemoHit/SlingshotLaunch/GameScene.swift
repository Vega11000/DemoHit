import SpriteKit

final class GameScene: SKScene {
    
    private var background: SKSpriteNode?
    private let gravitySystem = GravitySystem()                 //система, куда добавляются ноды с физ. данными и где осуществляется гравитация
    private var indicatorNode: SKSpriteNode?                    //Индикатор силы запуска
    
    static var userHasSetAVector: Bool = false                  //Задал ли пользователь вектор движению ракеты
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let powerIncreaseStep: Double = 50.0                //Шаг для увелечения мощности запуска ракеты
    private let timeForMostPowerfulLaunch: Double = 10          //Время, нужное для запуска ракеты на полную мощность(потолок)
    
    private var timeAtTouchDown = Date.timeIntervalSinceReferenceDate
    private lazy var locationOfTouchDown = CGPoint()
    private var placerLine: SKShapeNode?                        //нод для отображения вектора
    private lazy var userTaped: Bool = false                    //Начал ли юзер задавать вектор движения
    
    private enum Constants {
        static var widthConstant: CGFloat = 50
        static var heightConstant: CGFloat = 50
    }
    
    override func didMove(to view: SKView) {
        setNodes()
        addChilds()
        setupGestureRecognizer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        gravitySystem.update()
        
        if userTaped {
            let durationOfPress = Date.timeIntervalSinceReferenceDate - timeAtTouchDown
            let levelLaunchPower = durationOfPress.truncatingRemainder(dividingBy: timeForMostPowerfulLaunch)
            
            if levelLaunchPower < (timeForMostPowerfulLaunch / 3) {
                indicatorNode?.color = .green
            } else if levelLaunchPower < (2 * timeForMostPowerfulLaunch / 3) {
                indicatorNode?.color = .orange
            } else {
                indicatorNode?.color = .red
            }
        }
    }
}

// MARK: - Private methods

private extension GameScene {
    
    func setNodes() {
        background = setNode(an: "background",
                             at: CGPoint(x: frame.size.width/2, y: frame.size.height/2),
                             level: 0)
        
        indicatorNode = SKSpriteNode(color: .green, size: CGSize(width: Constants.widthConstant, height: Constants.heightConstant))
        let pointForIndicator = CGPoint(x: size.width / 5, y: size.height / 6)
        indicatorNode?.position = pointForIndicator
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
        mediumPlanet.position = CGPoint(x: size.width / 1.3, y: size.height / 3)
        bigPlanet.position = CGPoint(x: size.width / 3, y: size.height / 1.3)
        
        gravitySystem.add(planet: mediumPlanet)
        gravitySystem.add(planet: bigPlanet)
        
        let rocket = Rocket(mass: 20)
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
    
    @objc func handlePanGestureRecognizer(gesture: UIPanGestureRecognizer) {
        
        var touchLocation = gesture.location(in: gesture.view)
        touchLocation = self.convertPoint(fromView: touchLocation)
        
        switch gesture.state {
        case .began:
            userTaped = true
            timeAtTouchDown = Date.timeIntervalSinceReferenceDate
            locationOfTouchDown = touchLocation
            
        case .changed:
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
            let durationOfPress = Date.timeIntervalSinceReferenceDate - timeAtTouchDown
            let levelLaunchPower = (Double(durationOfPress).truncatingRemainder(dividingBy: timeForMostPowerfulLaunch))
            let launchPower = levelLaunchPower * powerIncreaseStep    //Сила может быть от 0 до 500

            print(launchPower)
            
            var panVector = create(a: locationOfTouchDown, b: touchLocation)
            panVector = normalize(a: panVector)
            panVector = mult(a: panVector, b: CGFloat(launchPower))
            
            gravitySystem.startRocket(vector: panVector)
            
            userTaped = false
            indicatorNode?.color = .green
            placerLine?.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.3),SKAction.removeFromParent()]))
            
        default: break
        }
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

// MARK: Touches

//extension GameScene {                                 //Пока не знаю, нужно это или нет (Код Ильи)
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let knob = knob else { return }
//
//        for touch in touches {
//            let location = touch.location(in: knob)
//            knobAction = knob.frame.contains(location)
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if !knobAction { return }
//
//        guard let knob = knob, let knobArea = knobArea else { return }
//
//        let knobRadius: CGFloat = 50
//
//        for touch in touches {
//            let position = touch.location(in: knobArea)
//
//
//            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
//            let angle = atan2(position.y, position.x)
//
//            if knobRadius > length {
//                knob.position = position
//            } else {
//                knob.position = CGPoint(x: cos(angle) * knobRadius, y: sin(angle) * knobRadius)
//            }
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
//
//}
