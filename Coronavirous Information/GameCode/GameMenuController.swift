//
//  GameMenuController.swift
//  Coronavirous Information
//
//  Created by Yantao Luo on 5/6/20.
//  Copyright © 2020 Runhai Lin. All rights reserved.
//

import UIKit

class GameMenuController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
