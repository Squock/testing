//
//  AuthInfoController.swift
//  testing
//
//  Created by squock on 24.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import UIKit

class AuthInfoController: UIViewController {
    @IBOutlet weak var viewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Переход после нажатия изображения
        for text in Singleton.shared.texts{
            if text.id == "registration"{
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(authView))
                view.isUserInteractionEnabled = true
                view.addGestureRecognizer(tapGestureRecognizer)
                viewImage.image = #imageLiteral(resourceName: "welcome")
            }
            
        }
        // Do any additional setup after loading the view.
    }
    @objc func authView(){
        performSegue(withIdentifier: "AuthController", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
