//
//  NotificationsVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 01/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var btnMenu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.separatorStyle = .none
        
        tblView.register(UINib(nibName: "NotificationsCell", bundle: nil), forCellReuseIdentifier: "NotificationsCell")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Tableview delegate and data source methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let  cell   = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
