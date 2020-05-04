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
    
    var inputintroobj = IntroductionData(question_id: -1, question: "", CDC: "", WHO: "")
        
    @IBOutlet weak var IntroTitle: UITextView!
    
    @IBOutlet weak var total: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        IntroTitle.text = inputintroobj.question
        IntroTitle.font = UIFont(name:"Georgia-Bold",size:23 )
        
        total.isEditable = false;
        total.font = UIFont(name: "TimesNewRomanPSMT", size: 18)
        let String = "According to CDC\n\n" + inputintroobj.CDC + "\n\nAccording to  WHO\n\n" + inputintroobj.WHO
        total.text = String;
        IntroTitle.isEditable = false
      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
