//
//  GraphRateViewController.swift
//  Coronavirous Information
//
//  This view controller is present the recovered
//  rate and death rate of COVID19
//
//  Created by Runhai Lin on 5/2/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit
import Charts

class GraphRateViewController: UIViewController {
    
    var inputgraphobj = [rate_inf]()
    
    @IBOutlet weak var rate_slider: UISlider!
    @IBOutlet weak var chart: LineChartView!
    
    @IBOutlet weak var Num: UILabel!
    
    var rec_lineChartEntry = [ChartDataEntry]()
    var dea_lineChartEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Rate"
        // Do any additional setup after loading the view.
        
        //inputing data from the input obj
        let length = inputgraphobj.count
        for i in 1...length-1{
            let current_rec = inputgraphobj[i].rec_rate
            let current_dea = inputgraphobj[i].dea_rate
            
            
            let rec = ChartDataEntry(x: Double(i), y: Double(current_rec))
            rec_lineChartEntry.append(rec)
            let dea = ChartDataEntry(x:Double(i),y:Double(current_dea))
            dea_lineChartEntry.append(dea)
        }
       
        //add lines to dataset
        let rec_line = LineChartDataSet(entries: rec_lineChartEntry,label :"Recovered Rate")
        rec_line.colors = [NSUIColor .green]
        rec_line.drawCirclesEnabled = false
        rec_line.lineWidth = 2.0
        let dea_line = LineChartDataSet(entries: dea_lineChartEntry,label : "Death Rate")
        dea_line.colors = [NSUIColor .red]
        dea_line.drawCirclesEnabled = false
        dea_line.lineWidth = 2.0
        let data = LineChartData()
        data.addDataSet(rec_line)
        data.addDataSet(dea_line)
        chart.data = data
        chart.chartDescription?.text = "Chart for death rate and recovered rate"
        chart.backgroundColor = UIColor.white
        
        //reflecting information
        var date = Int(rate_slider.value*Float(length))
        if (date == length){
            date = date - 1
        }
        let today_rec = NSString(format:"Recovered:%.2f",inputgraphobj[date].rec_rate*100) as String+"%"
        let today_dea = NSString(format:"Death:%.2f",inputgraphobj[date].dea_rate*100) as String+"%"
        
        let today_date = inputgraphobj[date].date
        let today_month_date = today_date%10000
        let montharr = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        let today_month_str = montharr[today_month_date/100-1]
        let today_day_str = String(today_month_date%100)
        let today_date_str = today_month_str+"-"+today_day_str
        
        Num.text = today_date_str+"\t"+today_rec+"\t"+today_dea
        
    }
    @IBAction func sliderslided(_ sender: Any) {
        let length = inputgraphobj.count
        var date = Int(rate_slider.value*Float(length))
         if (date == length){
             date = date - 1
         }
         let today_rec = NSString(format:"Recovered:%.2f",inputgraphobj[date].rec_rate*100) as String+"%"
         let today_dea = NSString(format:"Death:%.2f",inputgraphobj[date].dea_rate*100) as String+"%"
         
         let today_date = inputgraphobj[date].date
         let today_month_date = today_date%10000
         let montharr = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
         let today_month_str = montharr[today_month_date/100-1]
         let today_day_str = String(today_month_date%100)
         let today_date_str = today_month_str+"-"+today_day_str
         
         Num.text = today_date_str+"\t"+today_rec+"\t"+today_dea
    }


}
