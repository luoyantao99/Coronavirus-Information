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

//render an UIView to UIImage
extension UIView {
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }

    func getImage(scale: CGFloat? = nil) -> UIImage {
        let newScale = scale ?? UIScreen.main.scale
        self.scale(by: newScale)

        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale

        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)

        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }

        return image
    }
}

class GraphWorldViewController: UIViewController {

    var inputgraphobj = [country_info]()
    var inputgraphobj2 = [String]()
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var datelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Global"
        let length = inputgraphobj[0].confirmed.count
        var date = Int(slider.value*Float(length))
        if (date == length){
            date = date - 1
        }
        
        datelabel.text = inputgraphobj2[date]
       
        // Do any additional setup after loading the view.
        
        
        // earth scene
     
        let earthscene = SCNScene()
        sceneView.scene = earthscene
        sceneView.backgroundColor = UIColor(displayP3Red: CGFloat(62.0/255), green: CGFloat(67.0/255), blue: CGFloat(100.0/255), alpha: 0.0)
        sceneView.allowsCameraControl = true
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        earthscene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(0, 0, 4)
        
        let lightNode1 = SCNNode()
        lightNode1.light = SCNLight()
        lightNode1.light?.type = .omni
        lightNode1.position = SCNVector3(0,10,2)
        
        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light?.type = .omni
        lightNode2.position = SCNVector3(0,-10,-2)
        
        let lightNode3 = SCNNode()
        lightNode3.light = SCNLight()
        lightNode3.light?.type = .omni
        lightNode3.position = SCNVector3(-10,10,0)
     
        let lightNode4 = SCNNode()
       lightNode4.light = SCNLight()
       lightNode4.light?.type = .omni
       lightNode4.position = SCNVector3(10,-10,0)
    
        
        earthscene.rootNode.addChildNode(lightNode1)
        earthscene.rootNode.addChildNode(lightNode2)
        earthscene.rootNode.addChildNode(lightNode3)
        earthscene.rootNode.addChildNode(lightNode4)
       
        
        let earthnode = EarthNode()
        
        let image2 = generateimage(date: date)
        
        earthnode.geometry?.firstMaterial?.diffuse.contents = image2
        earthnode.name = "earthnode"
        earthscene.rootNode.addChildNode(earthnode)
    }
    
    func generateimage(date:Int) -> UIImage{
        let image = UIImage(named: "Diffuse")
               let imageView = UIImageView(image: image)
               let myview = UIView()
               
               myview.frame = CGRect(x: 0, y: 0, width: 344, height: 172)
               myview.addSubview(imageView)
               
          
              
               for i in 0...inputgraphobj.count-1{
                   let country = inputgraphobj[i]
                   let confirmed_number = country.confirmed[date]
                   //print(country.name)
                   //print(confirmed_number)
                   //print(country.x)
                   //print(country.y)
                   var color = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.8)
                   if (confirmed_number<100000){
                       color = CGColor(srgbRed: 1, green: 130.0/255, blue:0 , alpha: 0.8)
                   } else if (confirmed_number<500000) {
                       color = CGColor(srgbRed: 1, green: 0, blue:0 , alpha: 0.8)
                       
                   } else {
                       color = CGColor(srgbRed: 130.0/255, green: 0.0, blue:0.0 , alpha: 1)
                       
                   }
                   
                   var radius = 0;
                   
                   if confirmed_number<100000{
                       radius = Int(confirmed_number/10000)+1
                   } else if confirmed_number<1000000{
                       radius = Int(11 + confirmed_number/100000)
                   } else{
                       radius = 25
                   }
                   
                   
                   let layer = CAShapeLayer();
                   
                   layer.path = UIBezierPath(ovalIn: CGRect(x: country.x, y: country.y, width: radius, height: radius)).cgPath;
                   
                   layer.fillColor = color
                          myview.layer.addSublayer(layer);
               }
              
               
               let image2 = myview.getImage()
        
            return image2
        
    }
    
    
    @IBAction func sliderslided(_ sender: Any) {
        
        let length = inputgraphobj[0].confirmed.count
        var newdate = Int(slider.value*Float(length))
        if (newdate == length){
            newdate = newdate - 1
        }
        
        datelabel.text = inputgraphobj2[newdate]
        let image2 = generateimage(date: newdate)

        
        if let node = sceneView.scene?.rootNode.childNode(withName:"earthnode", recursively: true) as? EarthNode {
            node.geometry?.firstMaterial?.diffuse.contents = image2
            return
        } else {
            return
        }
        
        
    }

}
