//
//  AuthController.swift
//  testing
//
//  Created by squock on 15.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import UIKit

class AuthController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var sendRegistration: UIButton!
    @IBOutlet weak var agreeOffer: UIButton!
    var ms: getRegistration! //Ответ при пост запросе
    var tfClear:Int = 0 //Счетчик для проверки заполнения всех textField
    var thePicker = UIPickerView()
    var cityId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        filterText()
        birthDate.delegate = self
        city.delegate = self
        phone.delegate = self
        phone.keyboardType = .numberPad
        thePicker.delegate = self
        thePicker.dataSource = self
        city.inputView = thePicker
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (phone.text?.isEmpty)!, let text = phone.text {
            phone.text = "+7" + text
        }
    }
    //Максимальное значение номера телефона
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return true}
        var limit = 1000
        if textField == phone{
            limit = 12
        }
        let newLength = text.count + string.count - range.length
        if newLength > limit {
            return false
        }
        return newLength <= limit
    }
    //Функция заполнения городов
    func cityList()->[(id: Int, name: String)]{
        var citiesList = [(id: Int, name: String)]()
        for curCity in Singleton.shared.cities{
            if let name = curCity.name, let id = curCity.id{
                citiesList.append((id: id, name: name))
            }
        }
        
        return citiesList
    }
   // Выбор даты рождения пользователя
    @IBAction func chooseBirthDate(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        let currentCalendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = -120
        let minDate = currentCalendar.date(byAdding: dateComponents, to: Date())
        datePickerView.minimumDate = minDate
        datePickerView.maximumDate = Date()
        datePickerView.locale = Locale(identifier: "ru_RU")
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        let doneButton = UIBarButtonItem(title: "Выбрать", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        doneButton.tintColor = UIColor.black
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        addDoneButtonToDatePickers(doneButton: toolBar)
    }
    
    func addDoneButtonToDatePickers(doneButton: UIToolbar){
       birthDate.inputAccessoryView = doneButton
    }
    
    @objc func doneTapped(){
        self.view.endEditing(true)
        phone.becomeFirstResponder()
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        birthDate.text = dateFormatter.string(from: sender.date)
    }
    //Нажатие кнопки регистрация
    @IBAction func sendAuth(_ sender: Any) {
        checkTextField(textField: firstName)
        checkTextField(textField: lastName)
        checkTextField(textField: secondName)
        checkTextField(textField: phone)
        checkTextField(textField: birthDate)
        checkTextField(textField: city)
        if tfClear < 6{
            textFieldAlert()
        }
        if tfClear == 6{
            postRegistration()
            if ms.success == 0{
                let alert = UIAlertController(title: "Ошибка", message: ms.msg, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            if ms.success == 1{
                performSegue(withIdentifier: "PinController", sender: self)
            }
        }
        tfClear = 0
        
    }
    //Проверка textField все ли заполнены
    func checkTextField(textField: UITextField){
        guard let text = textField.text, !text.isEmpty else {
            textField.backgroundColor = UIColor.red
            return
        }
        if text.isEmpty == false{
            textField.backgroundColor = UIColor.clear
            tfClear += 1
        }
    }
    //Вывод ошибки заполнения данных textAlert
    func textFieldAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //Переход к следующему textField при нажатии кнопки ввод
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
            if nextField.tag == 5{
                city.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //Добавление таргета для текст филда
    func filterText(){
        lastName.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: UIControlEvents.editingChanged)
        firstName.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: UIControlEvents.editingChanged)
        secondName.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: UIControlEvents.editingChanged)
    }
    //Фильтрация текста
    @objc func textFieldDidChange(_ textField: UITextField){
        FilterController().fioFormTextFieldFilter(textField: textField)
    }
    //Отправка POST запроса при регистрации и получение ответа и запись в ms
    func postRegistration(){
        let registrationObject = Registration(firstName: firstName.text, lastName: lastName.text, secondName: secondName.text, phone: phone.text, birthDate: birthDate.text,  cityId: cityId, sex: sex.selectedSegmentIndex, osCode: 1, id: nil, msg: nil, success: nil, token: nil)
        let encodedData = try? JSONEncoder().encode(registrationObject)
        guard let data = APIController().postData(api: api_auth, jsonData: encodedData, view: ViewController()) else {
            print("Error: No data to decode")
            return
        }
        guard let date = try? JSONDecoder().decode(Registration.self, from: data) else{
            print("Error: No data to decode1")
            return
        }
        let model = getRegistration(cityId: date.cityId, id: date.id, token: date.token, phone: date.phone, lastName: date.lastName, firstName: date.firstName, secondName: date.secondName, success: date.success!, msg: date.msg)
        ms = model
        UserDefaults.standard.set(ms.id, forKey: "id")
        UserDefaults.standard.set(ms.token, forKey: "token")
    }
    @IBAction func agreeOfferTapped(_ sender: Any) {
        for text in Singleton.shared.texts{
            if text.id == "agreement"{
                do{
                    let offerText = UILabel()
                    let attrStr = try NSAttributedString(data: text.html.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil)
                    let alert = UIAlertController(title: text.title, message: "", preferredStyle: UIAlertControllerStyle.alert)
                    offerText.attributedText = attrStr
                    alert.setValue(offerText.attributedText, forKey: "attributedMessage")
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                catch let error{
                    print("something wrong:", error)
                }
            }
        }
    }
    
    @IBAction func agreeSwitch(_ sender: UISwitch) {
        if sender.isOn{
            sendRegistration.isEnabled = true
        }
        else{
            sendRegistration.isEnabled = false
        }
    }
}
extension AuthController: UIPickerViewDelegate, UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList()[row].name
    }
    public func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        city.text = cityList()[row].name
        cityId = cityList()[row].id
        self.view.endEditing(false)
    }
}
