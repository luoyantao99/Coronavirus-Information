//
//  GameScene.swift
//  Final Project
//
//  Created by Yantao Luo on 4/23/20.
//  Copyright © 2020 Yantao Luo. All rights reserved.
//

import SpriteKit
class GameScene: SKScene, Alertable {
    weak var viewController: UIViewController?
    
    // ----- basic info -----
    let width = CGFloat(700)
    let height = CGFloat(1051)
    let min_x = CGFloat(-350+2)
    let max_x = CGFloat(350-2)
    let min_y = CGFloat(-525+2)
    let max_y = CGFloat(525-2)
    
    // ----- game items -----
    var bat_array = [SKSpriteNode]()
    let dropZone: CGRect
    let flyZone: CGRect
    let Zone_lineWidth = CGFloat(0)
    var score = 0
    
    // ----- progress bar items -----
    var researchProgress: ProgressBar
    var infectionProgress: ProgressBar
    var virusKilled = false
    let incrementValue = CGFloat(0.01)
    var incrementCount = 0
    let barHeight = CGFloat(25)
    let barWidth = CGFloat((700-130)/2)
    
    // ----- infection calculation & balance -----
    var virus_array = [SKSpriteNode]()
    let time_interval = 0.05
    var base_rate = CGFloat(1/500*0.05)
    let max_rate = CGFloat(1/20*0.05)
    let growth_rate = CGFloat(0.005)
    
    
    override init(size: CGSize) {
        // define drop & fly zone size
        dropZone = CGRect(x: -width/1.4/2, y: -height/2+20, width: width/1.4, height: height/4)
        flyZone = CGRect(x: -width*1.2/2, y: height/4, width: width*1.2, height: height/5)

        // init progress bar
        researchProgress = ProgressBar(color: .green, size: CGSize(width: barWidth, height: barHeight-1))
        researchProgress.position = CGPoint(x: min_x/2+30, y: max_y-barHeight/2)
        researchProgress.zPosition = 4
        
        infectionProgress = ProgressBar(color: .green, size: CGSize(width: barWidth, height: barHeight-1))
        infectionProgress.position = CGPoint(x: max_x/2-30, y: max_y-barHeight/2)
        infectionProgress.zPosition = 4
        
        super.init(size: size)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        addChild(background)
        
        drawDropZone()
        drawFlyZone()
        
        let actions = [SKAction.run(sendBat), SKAction.wait(forDuration: 1.5),
                       SKAction.run(dropVirus), SKAction.run(sendBat),
                       SKAction.wait(forDuration: 2),SKAction.run(dropVirus),
                       SKAction.run(sendBat),SKAction.wait(forDuration: 1.5),
                       SKAction.run(dropVirus)]

        run(SKAction.repeatForever(SKAction.sequence(actions)))
        
        // add bar UI
        let vaccine_background = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 5)
        vaccine_background.position = CGPoint(x: min_x/2+30, y: max_y-barHeight/2)
        vaccine_background.zPosition = 2
        vaccine_background.strokeColor = .black
        vaccine_background.fillColor = .systemGray3
        self.addChild(vaccine_background)

        let vaccine_label = SKLabelNode(text: "Vaccine Progress")
        vaccine_label.horizontalAlignmentMode = .center
        vaccine_label.position = CGPoint(x: vaccine_background.position.x, y: max_y-barHeight*0.75)
        vaccine_label.zPosition = 10
        vaccine_label.fontSize = 18
        vaccine_label.fontColor = .black
        vaccine_label.fontName = "AvenirNext-Bold"
        self.addChild(vaccine_label)
        
        let infection_background = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 5)
        infection_background.position = CGPoint(x: -vaccine_background.position.x, y: vaccine_background.position.y)
        infection_background.zPosition = 2
        infection_background.strokeColor = .black
        infection_background.fillColor = .red
        self.addChild(infection_background)

        let infection_label = SKLabelNode(text: "Population Infected")
        infection_label.horizontalAlignmentMode = .center
        infection_label.position = CGPoint(x: -vaccine_background.position.x, y: vaccine_label.position.y)
        infection_label.zPosition = 10
        infection_label.fontSize = 18
        infection_label.fontColor = .black
        infection_label.fontName = "AvenirNext-Bold"
        self.addChild(infection_label)
        
        researchProgress.progress = 0
        addChild(researchProgress)
        
        infectionProgress.progress = 1
        addChild(infectionProgress)
        
        // infection handler timer
        _ = Timer.scheduledTimer(timeInterval: time_interval, target: self,
        selector: #selector(infection_handler),
        userInfo: nil, repeats: true)
    }
    
    
    func drawDropZone() {
        let shape = SKShapeNode()
        let path = CGMutablePath()
        path.addRect(dropZone)
        shape.path = path
        shape.lineWidth = Zone_lineWidth
        addChild(shape)
    }
    
    
    func drawFlyZone() {
        let shape = SKShapeNode()
        let path = CGMutablePath()
        path.addRect(flyZone)
        shape.path = path
        shape.lineWidth = Zone_lineWidth
        addChild(shape)
    }
    
    
    func sendBat() {
        let bat = SKSpriteNode(imageNamed: "bat1")
        bat_array.append(bat)
        bat.name = "bat"
        bat.position = CGPoint(x: flyZone.maxX, y: CGFloat.random(in: flyZone.minY...flyZone.maxY))
        bat.setScale(CGFloat.random(in: 0.9...1.2))
        addChild(bat)
        
        var textures:[SKTexture] = []
        for i in 1...5 {
            textures.append(SKTexture(imageNamed: "bat\(i)"))
        }
        
        let batAnimation = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.1))
        if bat.action(forKey: "animation") == nil {
            bat.run(SKAction.repeatForever(batAnimation), withKey: "animation")
        }
        
        let destination = CGPoint(x: -flyZone.maxX*2, y: CGFloat.random(in: flyZone.minY...flyZone.maxY))
        let fly = SKAction.move(to: destination, duration:8)
        
        let removeFromParent = SKAction.removeFromParent()
        
        let actions = [fly, removeFromParent]
        bat.run(SKAction.sequence(actions))
    }
    
    
    func dropVirus() {
        for bat in bat_array {
            let virus = SKSpriteNode(imageNamed: "corona")
            virus_array.append(virus)
            virus.name = "corona"
            virus.position = bat.position
            virus.setScale(0)
            addChild(virus)
            let appear = SKAction.scale(to: CGFloat.random(in: 0.4...0.5), duration: 1)
            
            let dropPoint = CGPoint(
                x: CGFloat.random(in: dropZone.minX...dropZone.maxX),
                y: CGFloat.random(in: dropZone.minY...dropZone.maxY))
            let drop = SKAction.move(to: dropPoint, duration:6)
            
            let leftWiggle = SKAction.rotate(byAngle: 3.14/8, duration: 1)
            let rightWiggle = leftWiggle.reversed()
            let fullWiggle = SKAction.sequence([leftWiggle, rightWiggle, leftWiggle, rightWiggle, leftWiggle, rightWiggle])
            
            let falling = SKAction.group([appear, drop, fullWiggle])
            
            let scaleUp = SKAction.scale(by: 1.2, duration: 0.8)
            let scaleDown = scaleUp.reversed()
            let fullScale = SKAction.sequence([scaleUp, scaleDown, scaleUp, scaleDown])
            
            let disappear = SKAction.scale(to: 0, duration: 0.5)
            let removeFromParent = SKAction.removeFromParent()
            let actions = [falling, fullScale, disappear, removeFromParent]
            
            virus.run(SKAction.sequence(actions))
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "corona" {
                score+=1
                touchedNode.run(SKAction.scale(to: 0, duration: 0.2))
                virus_array.popLast()
                virusKilled = true
            }
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        if virusKilled == true {
            if incrementCount != 2 {
                researchProgress.progress += incrementValue
                incrementCount += 1
            }
            else {
                incrementCount = 0
                virusKilled = false
            }
        }
        
        if researchProgress.progress <= 0.21 {
            researchProgress.bar?.color = .red
        }
        else if researchProgress.progress <= 0.5 {
            researchProgress.bar?.color = .yellow
        }
        else {
            researchProgress.bar?.color = .green
        }
        
        
        if !bat_array.isEmpty{
            if self.bat_array[0].position.x < self.min_x {
                self.bat_array.remove(at: 0)
            }
        }
        
        if researchProgress.progress == 1 {
            showAlert(withTitle: "You Won!", message: "Alert message")
            self.isPaused = true
        }
        else if infectionProgress.progress == 0 {
            showAlert(withTitle: "You Lost!", message: "Alert message")
            self.isPaused = true
        }
        
    }

    
    // infection handler
    @objc func infection_handler() {
        if (base_rate > max_rate) {
            base_rate = max_rate
        }
        else {
            if (virus_array.count > 4)
            {
                base_rate = base_rate*CGFloat(virus_array.count-4)*growth_rate + base_rate
            }
        }
        infectionProgress.progress -= base_rate
        print("infection rate: \(base_rate)")
        print("array length: \(virus_array.count)")
        print()
    }
    
}



class ProgressBar:SKNode {
    var bar: SKSpriteNode?
    var _progress:CGFloat = 0
    var progress:CGFloat {
        get {
            return _progress
        }
        set {
            let value = max(min(newValue, 1.0), 0.0)
            if let bar = bar {
                bar.xScale = value
                _progress = value
            }
        }
    }
    
    convenience init(color: SKColor, size: CGSize) {
        self.init()
        bar = SKSpriteNode(color: color, size: size)
        if let bar = bar {
            bar.xScale = 0.0
            bar.zPosition = 3.0
            bar.position = CGPoint (x: -size.width / 2, y: 0)
            bar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            addChild(bar)
        }
    }
}
