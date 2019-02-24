//
//  InitController.swift
//  testing
//
//  Created by squock on 22.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import UIKit

class InitController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "token") == nil{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "AuthInfoController", sender: self)
            }
        }
        else{
            //performSegue(withIdentifier: "AuthInfoController", sender: self)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "PinController", sender: self)
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AuthController"{
            if let destination = segue.destination as? NavigateViewController{
              
            }
        }
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
