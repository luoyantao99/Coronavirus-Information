//
//  IntroTableViewController.swift
//  Coronavirous Information
//
//  IntroTableViewController.swift
//  IntroTableViewController is the navigation bar for the basic
//  introduction of coronavirous.
//
//  Created by Runhai Lin on 4/15/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit

class IntroTableViewController: UITableViewController {
    
    let DL = DataLoader()

    var introdataarr = [IntroductionData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DL.load_intro()
        self.introdataarr = DL.introductiondataarr
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return introdataarr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        

        // Configure the cell...
        cell.backgroundColor = UIColor(displayP3Red: CGFloat(62.0/255), green: CGFloat(67.0/255), blue: CGFloat(100.0/255), alpha: 0.0)
        cell.textLabel?.text = introdataarr[indexPath.row].question
        cell.textLabel?.textColor = UIColor .white
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "intro_segue", sender: introdataarr[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       
     
          return 80
      
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let contentviewcontroller = segue.destination as! IntroContentViewController
        contentviewcontroller.inputintroobj = sender as! IntroductionData
        
    }
  

}
