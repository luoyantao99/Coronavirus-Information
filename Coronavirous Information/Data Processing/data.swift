//
//  Introductiondata.swift
//  Coronavirous Information
//
//  Data.swift
//  Data.swift file records the data structure of object used in this app
//
//  Created by Runhai Lin on 4/15/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import Foundation

//IntroductionData is the data structure for basic information of COVID19

struct IntroductionData: Decodable {
    var question_id:Int
    var question:String
    var CDC:String
    var WHO:String
    
}

struct HistoryData: Decodable {
    var date: Int
    var positive:Int
    var recovered: Int?
    var death: Int? 
    
}

struct StateData: Decodable {
    var state: String
    var positive: Int
}

struct dayData: Decodable {
    var date: String
    var confirmed: Int
    var deaths:Int
    var recovered:Int
}

struct globalData: Decodable{
    var US:[dayData]
    var Spain:[dayData]
    var Italy:[dayData]
    var United_Kingdom:[dayData]
    var France:[dayData]
    var Germany:[dayData]
    var Russia:[dayData]
    var Turkey:[dayData]
    var Brazil:[dayData]
    var Iran:[dayData]
    var China:[dayData]
    var Canada:[dayData]
    var Belgium:[dayData]
    var Peru:[dayData]
    var India:[dayData]
    var Netherlands:[dayData]
    var Switzerland:[dayData]
    var Ecuador:[dayData]
    var Saudi_Arabia:[dayData]
    var Portugal:[dayData]
    var Sweden:[dayData]
    var Mexico:[dayData]
    var Ireland:[dayData]
    var Pakistan:[dayData]
    var Chile:[dayData]
    var Singapore:[dayData]
    var Belarus:[dayData]
    var Israel:[dayData]
    var Austria:[dayData]
    var Qatar:[dayData]
    var Japan:[dayData]
    var United_Arab_Emirates:[dayData]
    var Poland:[dayData]
    var Romania:[dayData]
    var Ukraine:[dayData]
    var Indonesia:[dayData]
    var Korea_South:[dayData]
    var Denmark:[dayData]
    
    init() {
        self.US = []
        self.Spain = []
        self.Italy = []
        self.United_Kingdom = []
        self.France = []
        self.Germany = []
        self.Russia = []
        self.Turkey = []
        self.Brazil = []
        self.Iran = []
        self.China = []
        self.Canada = []
        self.Belgium = []
        self.Peru = []
        self.India = []
        self.Netherlands = []
        self.Switzerland = []
        self.Ecuador = []
        self.Saudi_Arabia = []
        self.Portugal = []
        self.Sweden = []
        self.Mexico = []
        self.Ireland = []
        self.Pakistan = []
        self.Chile = []
        self.Singapore = []
        self.Belarus = []
        self.Israel = []
        self.Austria = []
        self.Qatar = []
        self.Japan = []
        self.United_Arab_Emirates = []
        self.Poland = []
        self.Romania = []
        self.Ukraine = []
        self.Indonesia = []
        self.Korea_South = []
        self.Denmark = []
    }
    
    private enum CodingKeys : String, CodingKey {
        
        case US,Spain,Italy,United_Kingdom = "United Kingdom",France,Germany,Russia,Turkey,Brazil,Iran,China,Canada,Belgium,Peru,India,Netherlands,Switzerland,Ecuador,Saudi_Arabia = "Saudi Arabia",Portugal,Sweden,Mexico,Ireland,Pakistan,Chile,Singapore,Belarus,Israel,Austria,Qatar,Japan,United_Arab_Emirates = "United Arab Emirates",Poland,Romania,Ukraine,Indonesia,Korea_South = "Korea, South",Denmark
    }

}

struct rate_inf:Codable  {
    var date: Int
    var rec_rate: Double
    var dea_rate: Double
}



struct country_info: Codable{
    var name:String
    var x:Int
    var y:Int
    var confirmed:[Int]
}

struct news_info: Codable {
    var title:String
    var webUrl:String
}

struct news_obj:Codable{
    var news: [news_info]
    
    init() {
        self.news = []
    }
}
