//
//  ViewController.swift
//  Final Project
//
//  Created by Yantao Luo on 4/23/20.
//  Copyright © 2020 Yantao Luo. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        let scene = GameScene(size:CGSize(width: 700, height: 1051))
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.viewController = self
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}

