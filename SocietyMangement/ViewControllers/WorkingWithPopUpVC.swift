//
//  WorkingWithPopUpVC.swift
//  SocietyMangement
//
//  Created by Innovius on 30/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class WorkingWithPopUpVC: UIViewController {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var arrWorkingWith = [Prop]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
    }
    

    @IBAction func actionClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension WorkingWithPopUpVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWorkingWith.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "WorkingWithPopUpCell") as! WorkingWithPopUpCell
           
        cell.lblFirstLetter.layer.cornerRadius = cell.lblFirstLetter.frame.size.height/2
        cell.lblFirstLetter.clipsToBounds = true
           
        
               cell.lblName.text = self.arrWorkingWith[indexPath.row].addedBy
              // cell.lblFlat.text = "\(self.arrWorkingWith[indexPath.row].buildingname!)-\(self.arrWorkingWith[indexPath.row].flatname!)"
        cell.lblFlat.text = self.arrWorkingWith[indexPath.row].propertyFullName

               let str = self.arrWorkingWith[indexPath.row].addedBy
               let firstChar = Array(str)[0]
               //str.substring(fromIndex: 0)
               cell.lblFirstLetter.text = "\(firstChar)"
               cell.lblFirstLetter.textColor = UIColor.white
        
           
           return cell
           
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
       }
       
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableViewAutomaticDimension
       }
    
    
}
