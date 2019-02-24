//
//  Singleton.swift
//  testing
//
//  Created by squock on 22.02.19.
//  Copyright © 2019 squock. All rights reserved.
//
import Foundation
import SystemConfiguration
var test: Bool = false
//Singleton собирает данные при успешном init. К сожалению ничего дельного еще не придумал ;(
final class Singleton {
    private init() {
        //var data = [(id: String, token: String)]()
        let semaphore = DispatchSemaphore(value: 0)
        //let token = String(describing: UserDefaults.standard.value(forKey: "token"))
        //let json: [String: Any] = ["token": UserDefaults.standard.string(forKey: "token"), "id":UserDefaults.standard.integer(forKey: "id"), "pin": UserDefaults.standard.string(forKey: "pin")]
        let json: [String: Any] = ["token": "dwoGahGOKV2p3JQITiyJyTQnxrG5D6X79PuBIH6C7CB0MfeRzm3MqnYMzrJtJLfZ_VDAuuYQ4G42tugVlJ2ogSOV_pgxqcv3s5bR", "id": 15]
        print(json)
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var request = URLRequest(url: URL(string: APIController().api_init)!)
        //var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task1 = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("this error1", error)
                DispatchQueue.main.async {
                    //Singleton.shared.showAlertView(title: "Sample", message: "Sample", preferredStyle: UIAlertControllerStyle.alert, okLabel: "OK", cancelLabel: "Cancel", targetViewController: self, okHandler: {(action) -> Void in print("is okay")}, cancelHandler: {(action) -> Void in print("is not okay")})
                    //alertController.show()
                    //self.present(alertController, animated: true, completion: nil)
                }
                //ConnectError.myAlert()
                //test = true
                //self.connect = true
                //let view = InitController()
                //let alert = UIAlertController(title: "Ошибка интернет соединения", message: "Проверьте ваше соединение", preferredStyle: UIAlertControllerStyle.alert)
                //alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {Void in self.view?.viewDidLoad()}))
                //self.view?.present(alert, animated: true, completion: nil)
                semaphore.signal()
            } else{
                let responceJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let responceJSON = responceJSON as? [String: Any]{
                    let specialities = responceJSON["specialities"] as? NSDictionary
                    print("specila", responceJSON)
                    let items = specialities?["items"] as! NSArray
                    for item in items{
                        let special = item as! NSDictionary
                        if let specialist = special["id"] as? String{
                             self.speciality.append((id: Int(specialist), name: special["name"] as? String, spec_info:  special["spec_info"] as? String))
                        }
                        let fetchservices = special["services"] as! NSArray
                        for itemservices in fetchservices{
                            let service = itemservices as! NSDictionary
                            if let id = special["id"] as? String, let servId = service["id"] as? String, let specialityId = service["speciality_id"] as? String, let parentId = service["parent_id"] as? String, let order = service["order"] as? String, let level = service["level"] as? String, let childrenCount = service["children_count"] as? String{
                                self.services.append((id_spec: Int(id), id: Int(servId), speciality_id: Int(specialityId), parent_id: Int(parentId), name: service["name"] as? String, order: Int(order), level: Int(level), children_count: Int(childrenCount)))
                            }
                        }
                    }
                    let fetchhospitals = responceJSON["hospitals"] as? NSDictionary
                    let itemsHospitals = fetchhospitals?["items"] as! NSArray
                    for itemHospital in itemsHospitals{
                        let hospital = itemHospital as! NSDictionary
                        if let hospitalId = hospital["id"] as? String{
                            self.hospitals.append((id: Int(hospitalId), name: hospital["name"] as? String))
                        }
                    }
                    let fetchsituations = responceJSON["situation"] as? NSDictionary
                    let itemsSituations = fetchsituations?["items"] as! NSArray
                    for itemSituate in itemsSituations{
                        let situate = itemSituate as! NSDictionary
                        if let situationId = situate["id"] as? String
                        {
                            self.situations.append((id: Int(situationId), name: situate["name"] as? String))
                        }
                    }
                    self.authorized = responceJSON["authorized"] as? Bool
                    self.pin =  responceJSON["pin"] as? String
                    let fetchcities = responceJSON["cities"] as? NSDictionary
                    let itemsCities = fetchcities?["items"] as! NSArray
                    for itemCity in itemsCities{
                        let city = itemCity as! NSDictionary
                        if let cityId = city["id"] as? String{
                             self.cities.append((id: Int(cityId), name: city["name"] as? String))
                        }
                    }
                    let fetchstreets = responceJSON["streets"] as? NSDictionary
                    let itemsStreets = fetchstreets?["items"] as! NSArray
                    for itemStreet in itemsStreets{
                        let street = itemStreet as! NSDictionary
                        if let streetId = street["id"] as? String, let cityId = street["cityId"] as? String{
                            self.streets.append((id: Int(streetId), name: street["name"] as? String, cityId: Int(cityId)))
                        }
                    }
                    let texts = responceJSON["texts"] as? NSDictionary
                    let itemsTexts = texts?["items"] as! NSArray
                    for itemText in itemsTexts{
                        let text = itemText as! NSDictionary
                        if let id = text["id"] as? String, let title = text["title"] as? String, let html = text["html"] as? String{
                            self.texts.append((id: id, title: title, html: html))

                        }
                    }
                    self.ads = responceJSON["ads"] as? String
                    let fetchdoc = responceJSON["doctors"] as? NSDictionary
                    let itemsDoc = fetchdoc?["items"] as! NSArray
                    for itemDoc in itemsDoc{
                        let doc = itemDoc as! NSDictionary
                        if let doctorId = doc["id"] as? String{
                            self.doctors.append((id: Int(doctorId), fio: doc["fio"] as? String, spec_id: doc["spec_id"] as? Int, hospital_id: doc["hospital_id"] as? Int))
                        }
                    }
                    let fetchCallDoc = responceJSON["callDoctorActivityList"] as? NSDictionary
                    let itemsCallDoc = fetchCallDoc?["items"] as! NSArray
                    for itemCallDoc in itemsCallDoc{
                        let callDoc = itemCallDoc as! NSDictionary
                        self.callDoctorActivityList.append((id: Int((callDoc["id"] as? String)!), name: callDoc["name"] as! String))
                    }
                    let fetchRequest = responceJSON["requestsActivityList"] as? NSDictionary
                    let itemsRequest = fetchRequest?["items"] as! NSArray
                    for itemRequest in itemsRequest{
                        let request = itemRequest as! NSDictionary
                        self.request.append((id: Int((request["id"] as? String)!), name: request["name"] as? String))
                    }
                    let fetchHome = responceJSON["home"] as? NSDictionary
                    let itemsHome = fetchHome?["items"] as! NSArray
                    for itemHome in itemsHome{
                        let home = itemHome as! NSDictionary
                        self.home.append((id: Int((home["id"] as? String)!), info: home["info"] as? String, name: home["name"] as! String))
                    }
                    semaphore.signal()
                }
            }
        }
        task1.resume()
        semaphore.wait()
    }
    /*func showAlertView(title alertTitle: String, message alertMessage: String, preferredStyle style: UIAlertControllerStyle, okLabel: String, cancelLabel: String, targetViewController: UIViewController, okHandler: ((UIAlertAction?) -> Void)!, cancelHandler: ((UIAlertAction?) -> Void)!){
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: style)
        let okAction = UIAlertAction(title: okLabel, style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: cancelLabel, style: .default, handler: cancelHandler)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        targetViewController.present(alertController, animated: true, completion: nil)
    }*/
    static let shared = Singleton()
    var speciality = [(id: Int?, name: String?, spec_info: String?)]()
    var services = [(id_spec: Int?, id: Int?, speciality_id: Int?, parent_id: Int?, name: String?, order: Int?, level: Int?, children_count: Int?)]()
    var hospitals = [(id: Int?, name: String?)]()
    var situations = [(id: Int?, name: String?)]()
    var cities = [(id: Int?, name: String?)]()
    var streets = [(id: Int?, name: String?, cityId: Int?)]()
    var texts = [(id: String, title: String, html: String)]()
    var doctors = [(id: Int?, fio: String?, spec_id: Int?, hospital_id: Int?)]()
    var callDoctorActivityList = [(id: Int?, name: String)]()
    var home = [(id: Int?, info: String?, name: String)]()
    var request = [(id: Int?, name: String?)]()
    var ads: String? = ""
    var offer = [String]()
    var name = "Test"
    var authorized: Bool?
    var pin: String? = ""
    //var view: UIViewController?
}
