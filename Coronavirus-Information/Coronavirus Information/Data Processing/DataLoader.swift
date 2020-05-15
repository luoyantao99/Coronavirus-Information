//
//  DataLoader.swift
//  Coronavirous Information
//
//  DataLoader.swift
//  DataLoader.swift includes a class DataLoader to load data
//  from local json file and from Internet so that users can
//  get access to the first hand coronavirous information.
//
//
//  Created by Runhai Lin on 4/15/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import Foundation

public class DataLoader {
    @Published var introductiondataarr = [IntroductionData]()
    @Published var historydatadarr = [HistoryData]()
    @Published var statedataarr = [StateData]()
    @Published var globaldataobj = globalData()
    @Published var countryinfoarr = [country_info]()
    @Published var countrydatearr = [String]()
    @Published var newsinfoobj = news_obj()
    @Published var newsinfoarr = [news_info]()
    
    init() {
        
    }
    
    //load_intro helps load data from introduction.json
    
    func load_intro(){
        if let fileLocation = Bundle.main.url(forResource: "introduction", withExtension: "json"){
            do {
                let introdata = try Data(contentsOf: fileLocation)
                
                let decoder = JSONDecoder()
                
                //create a data object
                let introdata_dec = try decoder.decode([IntroductionData].self, from: introdata)
                
                self.introductiondataarr = introdata_dec;
            } catch{
                print(error)
            }
        }
    }
    
    //load_country_info helps load data from country.json
    
    func load_country_info(){
        if let fileLocation = Bundle.main.url(forResource: "country", withExtension: "json"){
            do {
                let countrydata = try Data(contentsOf: fileLocation)
                
                let decoder = JSONDecoder()
                
                //create a data object
                let countrydata_dec = try decoder.decode([country_info].self, from: countrydata)
                
                self.countryinfoarr = countrydata_dec;
                
            } catch{
                print(error)
            }
        }
    }
    
    //load_newest_data helps load graph data from Internet
    
    func load_newest_data(){
        
         let sem = DispatchSemaphore.init(value: 0)
        
        if let url1 = URL(string: "https://covidtracking.com/api/v1/us/daily.json"){
        let task1 = URLSession.shared.dataTask(with: url1){data,response,error in
            defer {sem.signal()}
            
                if let data = data{
                    
                    do {
                        let decoder = JSONDecoder();
                        let historydata_dec = try decoder.decode([HistoryData].self, from: data)
                        
                        self.historydatadarr = historydata_dec
                    } catch let error {
                            print(error)
                    }
                }
            }
            task1.resume()
        }
        
        sem.wait();
        
        if let url2 = URL(string:"https://covidtracking.com/api/v1/states/current.json"){
            let task2 = URLSession.shared.dataTask(with:url2){
                data,response,error in
                defer {sem.signal()}
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder();
                        let statedata_dec = try
                            decoder.decode([StateData].self, from: data)
                        self.statedataarr = statedata_dec;
                       
                    } catch let error {
                        print(error)
                    }
                }
                
            }
            
            task2.resume()
            sem.wait()
            
        }
        
        if let url3 = URL(string: "https://pomber.github.io/covid19/timeseries.json") {
            let task3 = URLSession.shared.dataTask(with: url3){
                data,response,error in
                defer {sem.signal()}
                
                if let data = data{
                    do {
                        let decoder = JSONDecoder();
                        let globaldata_dec = try decoder.decode(globalData.self, from: data)
                        self.globaldataobj = globaldata_dec
                        
                    
                        
                    }
                    catch let error {
                    print(error)
                    }
                }
            }
            task3.resume()
            sem.wait()
            
            //generate the date array
            
            for q in 0...self.globaldataobj.US.count-1{
                let date = self.globaldataobj.US[q].date
                self.countrydatearr.append(date)
            }
            
            //generate the array for confirmed case by different country
            
            let globdataMirror = Mirror(reflecting: globaldataobj)
            
     
            for (label,value) in globdataMirror.children{
                guard let  label = label else {
                    continue
                }
                
              
                
                var index = 0
                
                for i in 0...self.countryinfoarr.count{
                    if countryinfoarr[i].name == label{
                        index = i
                        break
                    }
                }

                
                
                if let ref = value as? [dayData]{
                    
                    
                    for j in 0...ref.count-1{
                    
                        countryinfoarr[index].confirmed.append(ref[j].confirmed)
                    }
                    
                } else {
                     countryinfoarr[index].confirmed.append(0)
                }
 
        }
         
        
        }
        
    }
    
    // loading news report obj with its title and url
    func load_news_report(){
        let sem = DispatchSemaphore.init(value: 0)
        
        if let url4 = URL(string: "https://api.smartable.ai/coronavirus/news/US"){
            var request = URLRequest(url: url4)
            request.httpMethod = "GET"
            request.addValue("3009d4ccc29e4808af1ccc25c69b4d5d", forHTTPHeaderField: "Subscription-Key")
            
            let task4 = URLSession.shared.dataTask(with: request){
                data,response,error in
                defer {sem.signal()}
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder();
                        let newsinfo_dec = try decoder.decode(news_obj.self,from: data)
                        self.newsinfoobj = newsinfo_dec
                        self.newsinfoarr = self.newsinfoobj.news

                    } catch let error{
                        print(error)
                    }
                }
            }
            task4.resume()
            sem.wait()
        }
        
    }

}
