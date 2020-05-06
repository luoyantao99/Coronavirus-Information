//
//  GraphTabBarViewController.swift
//  Coronavirous Information
//
//  This tab bar controller is navigation view controller for graph view controller.
//
//  Created by Runhai LIn on 5/5/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit

class GraphTabBarViewController: UITabBarController {
    
    let DL = DataLoader()

    override func viewDidLoad() {
        super.viewDidLoad()

        let worldvc = self.viewControllers![0] as! GraphWorldViewController
        let usvc = self.viewControllers![1] as! GraphUSViewController
        let statevc = self.viewControllers![2] as! GraphStateViewController
        let ratevc = self.viewControllers![3] as! GraphRateViewController
        
        worldvc.inputgraphobj = DL.globaldataobj
        usvc.inputgraphobj = DL.historydatadarr
        statevc.inputgraphobj = DL.statedataarr
        
        let length = DL.historydatadarr.count
        
        var rate_inf_arr = [rate_inf]()
        
        for i in 1...length{
            let current = length-i
            let currentblock = DL.historydatadarr[current]
            let currentpos = currentblock.positive
            if (currentpos > 100){
                let currentdate = currentblock.date
                let currentrecovered = currentblock.recovered ?? 0
                let currentdeath = currentblock.death ?? 0
                let rec_rate:Double = Double(currentrecovered) / Double(currentpos)
                let dea_rate:Double = Double(currentdeath) / Double(currentpos)
                
                let currentrate_inf = rate_inf(date: currentdate, rec_rate: rec_rate, dea_rate: dea_rate)
                rate_inf_arr.append(currentrate_inf)
            }
        }
        ratevc.inputgraphobj = rate_inf_arr
        
        
        // Do any additional setup after loading the view.
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
