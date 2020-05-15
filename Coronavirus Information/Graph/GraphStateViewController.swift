//
//  GraphStateViewController.swift
//  Coronavirous Information
//
//  This view controller is present the number of
//  confirmed cases in different states in United State.
//
//  Created by Runhai Lin on 5/2/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit
import Charts

class GraphStateViewController: UIViewController {
    
    var inputgraphobj = [StateData]()
    var pos_barChartEntry = [BarChartDataEntry]()
    var statenamearr = [String]()
    @IBOutlet weak var chart: HorizontalBarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "State"
        
        let length = inputgraphobj.count
        for i in 0...length-1{
            let statename = inputgraphobj[i].state
            statenamearr.append(statename)
            let statepos = inputgraphobj[i].positive
            
            let pos = BarChartDataEntry(x:Double(i),y:Double(statepos) )
            pos_barChartEntry.append(pos)
            
        }
        
        let pos_bar = BarChartDataSet(entries: pos_barChartEntry, label: "State" )
        
        let bcd = BarChartData(dataSet: pos_bar)
        
        chart.data = bcd
        chart.backgroundColor = UIColor.white
        chart.chartDescription?.text = "Chart for Confirmed Cases in different States"
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: statenamearr)
        chart.xAxis.labelCount = statenamearr.count
        chart.xAxis.labelWidth = CGFloat(1.0)
        chart.xAxis.labelFont = UIFont.systemFont(ofSize: 8)
        chart.xAxis.drawGridLinesEnabled = true
        
    }
    
}
