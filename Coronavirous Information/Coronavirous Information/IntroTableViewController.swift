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
    
    let introdataarr = DataLoader().introductiondataarr
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let contentviewcontroller = segue.destination as! IntroContentViewController
        contentviewcontroller.inputintroobj = sender as! IntroductionData
        
    }
  

}
