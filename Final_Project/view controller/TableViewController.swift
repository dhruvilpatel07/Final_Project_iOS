//
//  TableViewController.swift
//  Final_Project
//
//  Created by Xcode User on 2020-04-18.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let mainDeligate = UIApplication.shared.delegate as! AppDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDeligate.dataObj.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell")
            as? SiteCellTableViewCell ?? SiteCellTableViewCell(style: .default, reuseIdentifier: "cell")
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDeligate.dataObj[rowNum].type
        tableCell.secondaryLabel.text = mainDeligate.dataObj[rowNum].date
        tableCell.descriptionLabel.text = mainDeligate.dataObj[rowNum].desc
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNum = indexPath.row
        let alertController = UIAlertController(title: mainDeligate.dataObj[rowNum].desc, message:mainDeligate.dataObj[rowNum].date, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,animated: true)
    }
    
    /*func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rowNum = indexPath.row
        let delete = UITableViewRowAction(style: .normal, title: "Delete")
        { (action , index) in
            
            let data : DataObj = DataObj.init()
            data.initWithData(theRow: self.mainDeligate.dataObj[rowNum].id!, theDesc: "This", theType: "sdgv", theDate: "12")
            let returnCode = self.mainDeligate.readDataFromDatabase(people:data)
            var returnMSG: String = "Reminder Deleted"
            if returnCode == false{
                returnMSG = "Can't Delete"
            }
            let alertController = UIAlertController(title: "SQLite Deleted", message: returnMSG, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel){
                (action: UIAlertAction) in
                self.mainDeligate.readDataFromDatabase()
                tableView.reloadData()
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
        delete.backgroundColor = .red
        return [delete]
    }*/
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
