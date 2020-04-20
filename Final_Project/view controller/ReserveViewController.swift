//
//  ReserveViewController.swift
//  CapstonePrototypeCustomer
//
//  Created by Dhruvil Patel on 2020-04-09.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import MessageUI
class ReserveViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //@IBOutlet weak var txtName: UITextField!
    //@IBOutlet weak var txtPhoneNumber: UITextField!
    
    //@IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnReservation: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var pickerData: [String] = [String]()
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["Financial","Birth Day","Family","Grocery","Other"]
        //lblError.alpha = 0
        setUpElements()
    }
    
    func setUpElements(){
        // hide the lable
        //lblError.alpha = 0
        // Style the elements
       // Utilities.styleTextField(txtName)
       // Utilities.styleTextField(txtPhoneNumber)
        Utilities.styleFilledButton(btnReservation)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        //let a:Int? = Int(firstText.text)
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print(pickerData[row])
       // numberOfPeople = Int(pickerData[row])!
        print(type)
    }
    
    func setUpLocalNotification(){
        
        //Setting a day back
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder!"
        let formatter = DateFormatter()
         formatter.calendar = datePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from:datePicker.date)
        content.body = "You have reminder"
        content.sound = UNNotificationSound.default
        let trig = UNCalendarNotificationTrigger(dateMatching: datePicker.calendar.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date), repeats: false)
        //unique string identifier
        let uuid = UUID().uuidString
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trig)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func clearForm(){
        //txtName.text = ""
        //txtPhoneNumber.text = ""
        picker.selectRow(0, inComponent: 0, animated: true)
        datePicker.setDate(Date.init(), animated: true)
       // lblError.alpha = 0
        
    }
   /* func validateField() -> String? {
        
        //Check that all fileds are filled
        if txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all field"
        }
        return nil
    }
    
    func showError(_ message:String){
        lblError.text = message
        lblError.alpha = 1
    }*/
    
   /* @IBAction func makeReservationTapped(_ sender: Any) {
        //Validate the field
        let error = validateField()
        
        if error != nil {
            showError(error!)
        }
        else{
            //Create cleaned version of data
            let name = txtName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNum = txtPhoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
                // User was stored successfully
                let db = Firestore.firestore()
            db.collection("reservations").addDocument(data: ["phoneNumber":phoneNum, "name":name, "uid":mainDelegate.userId, "numberOfPeople":numberOfPeople, "dateAndTime":datePicker.date], completion: { (error) in
                    if error != nil {
                        self.showError("Error saving user data ")
                    }else{
                        print("successful")
                        self.setUpLocalNotification()
                        let alertController = UIAlertController(title: "Confirmation", message: "Successfuly Reserved", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel){ (action: UIAlertAction) in
                            self.clearForm()
                        }
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true)
                        
                }
                })
        }
    }*/
    
    /*func sendEmail(){
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            mail.setToRecipients(["dhruvilpatel07@icloud.com", "dhruvilpatel07@yahoo.ca"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
            
        }else{
            
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
        
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

