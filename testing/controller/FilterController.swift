//
//  FilterController.swift
//  testing
//
//  Created by squock on 20.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import UIKit

class FilterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fioTextFieldFilter(clientfio1: UITextField, current1: String)->String{
        var current1 = current1
        let regexFIO = try! NSRegularExpression(pattern: "^([а-яА-Я])+(-)?([а-яА-Я ])*$", options: [])
        let stringFIO =  clientfio1.text
        let isMatchFio = regexFIO.firstMatch(in: stringFIO!, options: [], range: NSMakeRange(0, (stringFIO?.utf16.count)!)) != nil
        current1 = stringFIO!
        var curr = [String]()
        if isMatchFio == true || (stringFIO?.isEmpty)!{
            clientfio1.text = current1
        }
        else{
            let str = String(current1.characters.dropLast())
            clientfio1.text = String(current1.characters.dropLast())
            
        }
        return clientfio1.text!
    }
    func streetTextFieldFilter(streets: UITextField, currentStreet: String)->String{
        var currentStreet = currentStreet
        let regexStreet = try! NSRegularExpression(pattern: "^([а-яА-Я1-9])+([а-яА-Я0-9/. -])*$", options: [])
        let stringStreet = streets.text
        
        let isMatchStreet = regexStreet.firstMatch(in: stringStreet!, options: [], range: NSMakeRange(0, (stringStreet?.utf16.count)!)) != nil
        currentStreet = stringStreet!
        
        if isMatchStreet == true || (stringStreet?.isEmpty)!{
            streets.text = currentStreet
        }
        else{
            streets.text = String(currentStreet.characters.dropLast())
        }
        return streets.text!
    }
    func buildingTextFieldFilter(building: UITextField, currentBuilding: String)->String{
        var currentBuilding = currentBuilding
        let regexBuilding = try! NSRegularExpression(pattern: "^([а-яА-Я1-9])+([а-яА-Я0-9/. -])*$", options: [])
        let stringBuilding = building.text
        
        let isMatchBuilding = regexBuilding.firstMatch(in: stringBuilding!, options: [], range: NSMakeRange(0, (stringBuilding?.utf16.count)!)) != nil
        currentBuilding = stringBuilding!
        
        if isMatchBuilding == true || (stringBuilding?.isEmpty)!{
            building.text = currentBuilding
        }
        else{
            building.text = String(currentBuilding.characters.dropLast())
        }
        return building.text!
    }
    func apartamentTextFieldFilter(apartament: UITextField, currentApartment: String)->String{
        var currentApartment = currentApartment
        let regexApartment = try! NSRegularExpression(pattern: "^([1-9])+[0-9]*([а-яА-Я])?$", options: [])
        let stringApartment =  apartament.text
        let isMatchApartment = regexApartment.firstMatch(in: stringApartment!, options: [], range: NSMakeRange(0, (stringApartment?.utf16.count)!)) != nil
        currentApartment = stringApartment!
        if isMatchApartment == true || (stringApartment?.isEmpty)!{
            apartament.text = currentApartment
        }
        else{
            apartament.text =  String(currentApartment.characters.dropLast())
            
        }
        return apartament.text!
    }
    func complaintsTextFieldFilter(complaints: UITextField, currentComplaints: String)->String{
        
        var currentComplaints = currentComplaints
        let regexComplaints = try! NSRegularExpression(pattern: "^([а-яА-Я0-9])+([а-яА-Я0-9 .,])*$", options: [])
        let stringComplaints =  complaints.text
        let isMatchComplaints = regexComplaints.firstMatch(in: stringComplaints!, options: [], range: NSMakeRange(0, (stringComplaints?.utf16.count)!)) != nil
        currentComplaints = stringComplaints!
        if isMatchComplaints == true || (stringComplaints?.isEmpty)!{
            complaints.text = currentComplaints
        }
        else{
            complaints.text =  String(currentComplaints.characters.dropLast())
        }
        return complaints.text!
    }
    func fioFormTextFieldFilter(textField: UITextField)->String{
        
        var currentConst = ""
        let regexConst = try! NSRegularExpression(pattern: "^([а-яА-Я])+(-)?([а-яА-Я])*$", options: [])
        let stringConst =  textField.text
        let isMatchConst = regexConst.firstMatch(in: stringConst!, options: [], range: NSMakeRange(0, (stringConst?.utf16.count)!)) != nil
        currentConst = stringConst!
        if isMatchConst == true || (stringConst?.isEmpty)!{
            textField.text = currentConst
        }
        else{
            textField.text =  String(currentConst.characters.dropLast())
        }
        return textField.text!
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
