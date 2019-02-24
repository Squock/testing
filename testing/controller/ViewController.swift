//
//  ViewController.swift
//  testing
//
//  Created by squock on 13.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //registration()
        //init_data()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func registration(){
        //let registrationObject = Registration(firstName: "Родион", lastName: "Наумов", secondName: "Владимирович", phone: "+79644264635", birthDate: "24.10.1995",  cityId: 1, sex: 1, osCode: 1)
        //print("json", registrationObject)
        //let encodedData = try? JSONEncoder().encode(registrationObject)
        //APIController().postData(api: api_auth, jsonData: encodedData, view: ViewController())
        /*
        guard let data = APIController().init_auth(api: api_auth, jsonData: encodedData, view: ViewController()) else {
            print("Error: No data to decode")
            return
        }
        guard let date = try? JSONDecoder().decode(InitData.self, from: data) else{
            print("Error: No data to decode1")
            return
        }
        print("json", encodedData)*/
    }
    /*
    func init_data(){
        let json: [String: Any] = ["id": 15, "token": "dwoGahGOKV2p3JQITiyJyTQnxrG5D6X79PuBIH6C7CB0MfeRzm3MqnYMzrJtJLfZ_VDAuuYQ4G42tugVlJ2ogSOV_pgxqcv3s5bR"]
        /*
        guard let data = APIController().init_auth(api: api_init, json: json, view: ViewController()) else {
            print("Error: No data to decode")
            return
        }
        guard let date = try? JSONDecoder().decode(InitData.self, from: data) else{
            print("Error: No data to decode1")
            return
        }
        for specialities in date.specialities.items{
            for services in specialities.services{
                print("speciality title", services.name, specialities.name)
            }
            
        }*/
    }*/
    

}

