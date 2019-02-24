//
//  APIController.swift
//  testing
//
//  Created by squock on 13.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import UIKit


let api_auth = const + "auth" 
class APIController: UIViewController {
    
    var data: Data?
    let api_init = const + "init"
    
    func postData(api: String, jsonData: Data?, view: UIViewController)->Data?{
        var jsonReturn = [String: Any]()
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var request = URLRequest(url: URL(string: api)!)
        let semaphore = DispatchSemaphore(value: 0)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let send = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
        print("send", send)
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in guard let data = data, error == nil else {
            print("error!")
            print(error?.localizedDescription ?? "No data")
            let alertController = UIAlertController(title: "YES", message: " ", preferredStyle: .alert)
            alertController.show(view, sender: nil)
            return
            }
           
            let responceJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            self.data = data
            /*if let theJSONData = try? JSONSerialization.data(withJSONObject: responceJSON, options: []){
                let theJSONText = String(data: theJSONData,
                                         encoding: .utf8)
                //self.data = theJSONData
                //print("JSON string = \(theJSONText!)")

            }*/
            if let responceJSON = responceJSON as? [String: Any]{
                jsonReturn = responceJSON
                print("responce", jsonReturn)
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        /*if let theJSONData = try? JSONSerialization.data(
            withJSONObject: jsonReturn as? NSDictionary,
            options: []) {
            //self.data = theJSONData
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
            print("JSON string = \(theJSONText?.data(using: .utf8))")
            //self.data = theJSONText?.data(using: .utf8)
        }*/
        return data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
