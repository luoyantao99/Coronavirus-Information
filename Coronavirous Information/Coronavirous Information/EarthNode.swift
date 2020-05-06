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
        self.geometry?.firstMaterial?.specular.contents =
        UIImage(named: "Specular")
        self.geometry?.firstMaterial?.emission.contents =
        UIImage(named: "Emission")
        self.geometry?.firstMaterial?.normal.contents =
        UIImage(named: "Normal")
        self.geometry?.firstMaterial?.shininess = 30
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
