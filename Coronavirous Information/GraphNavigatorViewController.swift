//
//  GraphNavigatorViewController.swift
//  Coronavirous Information
//
//  This view controller is navigation view controller for graph view controller.
//
//  Created by Runhai Lin on 5/1/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit

class GraphNavigatorViewController: UIViewController {
    
    let DL = DataLoader()
    @IBOutlet weak var worldbutton: UIButton!
    @IBOutlet weak var usbutton: UIButton!
    @IBOutlet weak var state: UIButton!
    @IBOutlet weak var rate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(historydataarr)
        //print(statedataarr)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ratebuttonclicked(_ sender: Any) {
        
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
        performSegue(withIdentifier: "graphtorate_segue", sender: rate_inf_arr)
    
    }
    
    
    @IBAction func statebuttonclicked(_ sender: Any) {
        let state_inf_arr = DL.statedataarr
        performSegue(withIdentifier: "graphtostate_segue", sender: state_inf_arr)
    }
    
    @IBAction func usbuttonclicked(_ sender: Any) {
        let us_inf_arr = DL.historydatadarr
        performSegue(withIdentifier: "graphtous_segue", sender: us_inf_arr)
    }
    
    @IBAction func worldbuttonclicked(_ sender: Any) {
        let world_inf_obj = DL.globaldataobj
        performSegue(withIdentifier: "graphtoworld_segue", sender: world_inf_obj)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "graphtorate_segue" ){
            let destinviewcontroller = segue.destination as!
            GraphRateViewController
           destinviewcontroller.inputgraphobj = sender as! [rate_inf]
        }
        
        else if (segue.identifier == "graphtostate_segue"){
            let destinviewcontroller = segue.destination as!
            GraphStateViewController
            destinviewcontroller.inputgraphobj =
                sender as! [StateData]
        }
        
        else if (segue.identifier == "graphtous_segue") {
            let destinviewcontroller = segue.destination as! GraphUSViewController
            destinviewcontroller.inputgraphobj = sender as! [HistoryData]
        }
        
        else if (segue.identifier == "graphtoworld_segue"){
            let destinviewcontroller = segue.destination as! GraphWorldViewController
            destinviewcontroller.inputgraphobj = sender as! globalData
        }
        else {
            
        }
    }
    


}
