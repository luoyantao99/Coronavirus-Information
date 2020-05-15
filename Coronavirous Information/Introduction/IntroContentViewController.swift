//
//  IntroContentViewController.swift
//  Coronavirous Information
//
//  IntroContentViewController.swift
//  IntroContentViewController is the displaying view controller for
//  the basic introduction of coronavirous.
//
//  Created by Runhai Lin on 4/15/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit

class IntroContentViewController: UIViewController {
    
    var inputintroobj = IntroductionData(question_id: 0, question: "", CDC: "", WHO: "")
        
    @IBOutlet weak var IntroTitle: UITextView!
    
    @IBOutlet weak var total: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Introduction"
        IntroTitle.text = inputintroobj.question
        IntroTitle.font = UIFont(name:"Georgia-Bold",size:23 )
        IntroTitle.textColor = UIColor.white
        
        total.isEditable = false;
        total.font = UIFont(name: "TimesNewRomanPSMT", size: 18)
        let String = "According to CDC\n\n" + inputintroobj.CDC + "\n\nAccording to  WHO\n\n" + inputintroobj.WHO
        total.text = String;
        total.textColor = UIColor.white
        IntroTitle.isEditable = false
      
    }
    

}
