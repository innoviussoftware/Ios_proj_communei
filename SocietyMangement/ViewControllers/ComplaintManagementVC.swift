//
//  ComplaintManagementVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 30/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class complaintManagementcell:UITableViewCell
{
    @IBOutlet weak var lblname: UILabel!
}



class ComplaintManagementVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblComplaintManage: UITableView!

    var aryComplaintManage = ["Fire","Lift","Animal","Human","Accident","Medical","Water","SOS", "Common Area","Noise Pollution","Wrong Parking","Others"]

    var aryComplaintManageNumber = ["1","2","3","4","5","6","7","8", "9","10","11","12"]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Tableview delegate and datasource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryComplaintManage.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell: complaintManagementcell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! complaintManagementcell
                
        cell.lblname.text = aryComplaintManage[indexPath.row]
               
        return cell
         
    }
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ComplaintManagementMessageVC") as! ComplaintManagementMessageVC

        vc.strlbl = aryComplaintManage[indexPath.row]
                
        vc.alertTypeID = (aryComplaintManageNumber[indexPath.row] as NSString).integerValue

        print("alertTypeID ",vc.alertTypeID!)
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
        
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
