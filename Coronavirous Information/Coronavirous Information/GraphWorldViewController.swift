//
//  GraphWorldViewController.swift
//  Coronavirous Information
//
//  This view controller is present the number of
//  confirmed cases in different country or region.
//
//  Created by Runhai Lin on 5/3/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit


class GraphWorldViewController: UIViewController {

    var inputgraphobj = globalData()
    

    @IBOutlet weak var sceneView: SCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        // Do any additional setup after loading the view.
        
        // currently only dealing with
        // data in the newest day
        
        // change in the future
        
   
        let inputgraphobjMirror = Mirror(reflecting: inputgraphobj)
        
        var datablock : [String:Int] = [:]
        for (label,value) in inputgraphobjMirror.children{
            guard let  label = label else {
                continue
            }
            
            if let ref = value as? [dayData]{
                datablock[label] = ref[ref.count-1].confirmed
            } else {
                datablock[label] = 0;
            }
        }
        
        //print(datablock)
     
        
        // earth scene
     
        let earthscene = SCNScene()
        sceneView.scene = earthscene
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        earthscene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(0, 0, 4)
        
        let lightNode1 = SCNNode()
        lightNode1.light = SCNLight()
        lightNode1.light?.type = .omni
        lightNode1.position = SCNVector3(0,8,2)
        
        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light?.type = .omni
        lightNode2.position = SCNVector3(0,-8,2)
        
        earthscene.rootNode.addChildNode(lightNode1)
        earthscene.rootNode.addChildNode(lightNode2)
        
        let earthnode = EarthNode()
        
     
        
        
        earthscene.rootNode.addChildNode(earthnode)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
