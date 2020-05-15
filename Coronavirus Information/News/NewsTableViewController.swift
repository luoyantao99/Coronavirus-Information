//
//  NewsTableViewController.swift
//  Coronavirous Information
//
//  This view controller includes links to different websites.
//
//  Created by Runhai on 5/15/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let DL = DataLoader()
    
    // newsinfoarr contains a data structure of news information with title and url
    var newsinfoarr = [news_info]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DL.load_news_report()
        self.newsinfoarr = DL.newsinfoarr
        self.title = "News"

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsinfoarr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newscell", for: indexPath)

        // Configure the cell...
        cell.backgroundColor = UIColor(displayP3Red: CGFloat(62.0/255), green: CGFloat(67.0/255), blue: CGFloat(100.0/255), alpha: 0.0)
        cell.textLabel?.text = newsinfoarr[indexPath.row].title
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        cell.textLabel?.textColor = UIColor .white
        return cell
    }
    
    // open url when the cell is clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        UIApplication.shared.open(URL(string: self.newsinfoarr[indexPath.row].webUrl)! as URL, options: [:], completionHandler: nil)
    }
    
    //setting the size of cell
    override func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 160
    }

}
