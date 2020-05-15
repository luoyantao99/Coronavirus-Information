//
//  GraphUSViewController.swift
//  Coronavirous Information
//
//  This view controller is present the number of
//  confirmed cases in United State.
//
//  Created by Runhai Lin on 5/2/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit
import Charts


class GraphUSViewController: UIViewController {

    var inputgraphobj = [HistoryData]()
    
    var rec_lineChartEntry = [ChartDataEntry]()
    var dea_lineChartEntry = [ChartDataEntry]()
    var pos_lineChartEntry = [ChartDataEntry]()
    
    @IBOutlet weak var Basic: UILabel!
    @IBOutlet weak var Num: UILabel!
    @IBOutlet weak var chart: LineChartView!
    

    @IBOutlet weak var us_slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "US"
        
        // Do any additional setup after loading the view.
        
        //input data
        
        let length = inputgraphobj.count
        
        for i in 1...length{
            let current = length-i
            let current_pos = inputgraphobj[current].positive
            let current_rec = inputgraphobj[current].recovered ?? 0
            let current_dea = inputgraphobj[current].death ?? 0
            
       
            
            let rec = ChartDataEntry(x: Double(i), y: Double(current_rec))
            rec_lineChartEntry.append(rec)
            
            let dea = ChartDataEntry(x:Double(i),y:Double(current_dea))
            dea_lineChartEntry.append(dea)
            
            let pos = ChartDataEntry(x: Double(i), y: Double(current_pos))
            pos_lineChartEntry.append(pos)
            
        }
          
        //add to dataset
        let rec_line = LineChartDataSet(entries: rec_lineChartEntry, label: "Recovered")
        rec_line.colors = [NSUIColor .green]
        rec_line.drawCirclesEnabled = false
        rec_line.lineWidth = 2.0
        let dea_line = LineChartDataSet(entries: dea_lineChartEntry,label : "Death")
        dea_line.colors = [NSUIColor .red]
        dea_line.drawCirclesEnabled = false
        dea_line.lineWidth = 2.0
        let pos_line = LineChartDataSet(entries: pos_lineChartEntry, label: "Confirmed Case")
        pos_line.colors = [NSUIColor.blue]
        pos_line.drawCirclesEnabled = false
        pos_line.lineWidth = 2.0
        let lcd = LineChartData()
        lcd.addDataSet(rec_line)
        lcd.addDataSet(dea_line)
        lcd.addDataSet(pos_line)
      
        chart.data = lcd
        chart.backgroundColor = UIColor.white
        chart.chartDescription?.text = "Chart for Confirmed Cases in US"

        //reflecting information
        var date = length - Int(us_slider.value*Float(length))
        if (date == length){
            date = date - 1
        }
 
        let today_date = inputgraphobj[date].date
        let today_month_date = today_date%10000
        let montharr = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        let today_month_str = montharr[today_month_date/100-1]
        let today_day_str = String(today_month_date%100)
        let today_date_str = today_month_str+"-"+today_day_str
        let today_total = "Total:"+String(inputgraphobj[date].positive)
        let today_rec = "Recovered:"+String(inputgraphobj[date].recovered ?? 0)
        let today_dea = "Death:" + String(inputgraphobj[date].death ?? 0)
        
        Basic.text = today_date_str+"\t"+today_total
        Num.text = today_rec+"\t"+today_dea
        
        
    }
    
    @IBAction func sliderslided(_ sender: Any) {
        let length = inputgraphobj.count
        var date = length - Int(us_slider.value*Float(length))
               if (date == length){
                   date = date - 1
               }
        
               let today_date = inputgraphobj[date].date
               let today_month_date = today_date%10000
               let montharr = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
               let today_month_str = montharr[today_month_date/100-1]
               let today_day_str = String(today_month_date%100)
               let today_date_str = today_month_str+"-"+today_day_str
               let today_total = "Total:"+String(inputgraphobj[date].positive)
               let today_rec = "Recovered:"+String(inputgraphobj[date].recovered ?? 0)
               let today_dea = "Death:" + String(inputgraphobj[date].death ?? 0)
               
               Basic.text = today_date_str+"\t"+today_total
               Num.text = today_rec+"\t"+today_dea
    }
    

}
