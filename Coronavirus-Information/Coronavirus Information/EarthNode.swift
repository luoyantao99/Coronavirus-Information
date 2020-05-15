//
//  EarthNode.swift
//  Coronavirous Information
//
//  Created by Runhai Lin on 5/3/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//


import SceneKit

class EarthNode: SCNNode {
    
    override init(){
        super.init()
        
        self.geometry = SCNSphere(radius: 1)
        self.geometry?.firstMaterial?.diffuse.contents =
        UIImage(named: "Diffuse")
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
