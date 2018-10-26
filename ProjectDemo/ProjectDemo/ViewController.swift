//
//  ViewController.swift
//  ProjectDemo
//
//  Created by TOPS on 10/15/18.
//  Copyright © 2018 TOPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var time = Timer()
    var a = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.isHidden = true
       
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.test), userInfo: nil, repeats: true)
    
    }
    
    func test(sender:Timer) {
        
        if a <= 1
        {
            a = a + 1
        }
        else
        {
            let stb = self.storyboard?.instantiateViewController(withIdentifier: "login")
            
            self.navigationController?.pushViewController(stb!, animated: true)
            
            time.invalidate()
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

