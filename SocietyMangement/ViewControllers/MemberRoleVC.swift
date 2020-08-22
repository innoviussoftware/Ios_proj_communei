//
//  MemberRoleVC.swift
//  SocietyMangement
//
//  Created by MacMini on 05/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
protocol memberrole {
    
    func displarrole(ary:NSMutableArray,name:[String])
}


class MemberRoleVC: UIViewController  , UITableViewDataSource , UITableViewDelegate{

    
    
    var Roleary  = [Role]()

    var selectedary = NSMutableArray()
     var selectedrole = [String]()
    
    var delegate:memberrole?
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var viewinner: UIView!

    @IBAction func saveaction(_ sender: Any) {
        
        self.removeAnimate()
        
        for dic in Roleary
        {
            if(selectedary.contains(dic.id))
            {
                
                selectedrole.append(dic.name)
            }
            
        }
        
        delegate?.displarrole(ary:selectedary, name: selectedrole)

        
    }
    @IBAction func cancelaction(_ sender: Any) {
        self.removeAnimate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
         ApiCallGetRoles()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Tableview delegate and datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Roleary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : SendtoCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SendtoCell
        
        cell.cb.borderStyle = .circle
        cell.cb.checkmarkStyle = .circle
        cell.cb.uncheckedBorderColor = AppColor.appcolor
        cell.cb.borderWidth = 1
        cell.cb.uncheckedBorderColor = AppColor.appcolor
        cell.cb.checkedBorderColor = AppColor.appcolor
        cell.cb.backgroundColor = .clear
        cell.cb.checkboxBackgroundColor = UIColor.clear
        cell.cb.checkmarkColor = AppColor.appcolor
        cell.lblname.text  = Roleary[indexPath.row].name
        if(selectedary.contains(Roleary[indexPath.row].id))
        {
            cell.cb.isChecked = true
            
        }
        else
        {
            cell.cb.isChecked = false

            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (selectedary.contains(Roleary[indexPath.row].id))
        {
            
            selectedary.remove(Roleary[indexPath.row].id)
            self.tblview.reloadData()
            
        }
        else
        {
            
            selectedary.add(Roleary[indexPath.row].id)
            self.tblview.reloadData()
            
        }
    }
  
    
    // MARK: - User define Functions

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                
            }
        });
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
    }

    
    // MARK: - get roles
    
    func ApiCallGetRoles()
    {
       if !NetworkState().isInternetAvailable {
                        ShowNoInternetAlert()
                        return
                    }
            webservices().StartSpinner()
            Apicallhandler().ApiGetRole(URL: webservices().baseurl + "Auth/getRoleList") { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.errorCode == 0)
                    {
                    
                        self.Roleary = resp.data
                        self.tblview.reloadData()
                     
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
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
