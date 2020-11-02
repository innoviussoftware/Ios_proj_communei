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



@available(iOS 13.0, *)
class ComplaintManagementVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblComplaintManage: UITableView!

    var aryComplaintManage = ["Fire","Lift Service","Water leakage","Wrong Parking", "Common Area","Noise Pollution"]


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
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
        
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
