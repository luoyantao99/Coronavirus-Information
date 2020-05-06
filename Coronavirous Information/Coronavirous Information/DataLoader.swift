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
    
    init() {
        load_intro()
        load_newest_data()
       
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
    
    //load_newest_data helps load data from Internet
    
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
        
        
        }
        
    }
    

}
