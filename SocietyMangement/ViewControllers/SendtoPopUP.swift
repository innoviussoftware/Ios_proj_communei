//
//  SendtoPopUP.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire

protocol  Buildings {
    
    func selectedbuildings(selectedary:NSMutableArray, nameary:NSMutableArray,selectedaryId:NSMutableArray)
}


class SendtoPopUP: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var viewinner: UIView!
    
    @IBOutlet weak var lblTitel: UILabel!

    var strlbl = String()

    var buidilgsary = [BuildingAdd]() // [Building]()
    var selectedary = NSMutableArray()
    
    var nameary = NSMutableArray()
    
    var selectedaryId = NSMutableArray()

    var delegate:Buildings?
    @IBAction func cancelaction(_ sender: Any) {
        self.removeAnimate()
    }
    
    @IBAction func saveaction(_ sender: Any) {
        
      //  var nameary = NSMutableArray()
        for dic in buidilgsary
        {
            if(selectedary.contains(dic.propertyID))
            {
                
                nameary.add(dic.propertyFullName)
                selectedaryId.add(dic.propertyID)

            }
            
        }
        
        delegate?.selectedbuildings(selectedary: selectedary , nameary:nameary,selectedaryId: selectedaryId)
        self.removeAnimate()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        lblTitel.text = strlbl

        apicallGetBuildings()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        // Do any additional setup after loading the view.
    }
    
    
   
    
    // MARK: - Tableview delegate and datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return buidilgsary.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : SendtoCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SendtoCell
        
      /*  cell.cb.borderStyle = .circle
        cell.cb.checkmarkStyle = .circle
        cell.cb.uncheckedBorderColor = AppColor.appcolor
        cell.cb.borderWidth = 1
        cell.cb.uncheckedBorderColor = AppColor.appcolor
        cell.cb.checkedBorderColor = AppColor.appcolor
        cell.cb.backgroundColor = .clear
        cell.cb.checkboxBackgroundColor = UIColor.clear
        cell.cb.checkmarkColor = AppColor.appcolor */
        
        if(indexPath.row == 0)
        {
            cell.lblname.text = "Select All"
            if(selectedary.count ==  buidilgsary.count)
            {
               // cell.cb.isChecked = true
                cell.imgview.image = UIImage(named: "ic_checked")
            }else
            {
               // cell.cb.isChecked = false
                cell.imgview.image = UIImage(named: "ic_unchecked")
            }
        }
        else
        {
        cell.lblname.text = buidilgsary[indexPath.row - 1].propertyFullName
        if(selectedary.contains(buidilgsary[indexPath.row - 1].propertyID))
            {
               // cell.cb.isChecked = true
                cell.imgview.image = UIImage(named: "ic_checked")
                
            }else
            {
               // cell.cb.isChecked = false
                cell.imgview.image = UIImage(named: "ic_unchecked")
            }
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            if(selectedary.count > 0)
            {
                selectedary.removeAllObjects()
                self.tblview.reloadData()
            }
            else{
                for dic in buidilgsary
                {
                    selectedary.add(dic.propertyID)
                }
                self.tblview.delegate = self
                self.tblview.dataSource = self
                
                self.tblview.reloadData()

             
            }
        }
        else
        {
            
            
          if (selectedary.contains(buidilgsary[indexPath.row - 1].propertyID))
          {
            
            selectedary.remove(buidilgsary[indexPath.row - 1].propertyID)
            self.tblview.reloadData()

            }
            else
            {
                
                selectedary.add(buidilgsary[indexPath.row - 1].propertyID)
                self.tblview.reloadData()

            }
        }
        
    }
    
    
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
  
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
           /* let strSocietyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
            
            webservices().StartSpinner()
        
                let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
            
                 let param : Parameters = [
                     "Phone" : mobile!,
                     "Secret" : secret,
                     "Society" : strSocietyId
                 ]
                
                        
                Apicallhandler.sharedInstance.GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, param: param) { JSON in */
        
            webservices().StartSpinner()

                let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int

                    let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                         let param : Parameters = [
                            "Society" : SociId,
                           // "Parent" : UsermeResponse!.data!.society!.societyID!
                         ]
        

                print("Parameters : ",param)
                                
                    //   Apicallhandler.sharedInstance.GetAllBuidldingSociety(URL: webservices().baseurl + API_GET_BUILDING,token: token as! String, param: param) { JSON in
                        
        Apicallhandler.sharedInstance.GetAllBuidldingSociety(token: token! as! String, param: param) { JSON in
                            
                                            
                
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(resp.status == 1)
                    {
                        self.buidilgsary = resp.data
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
    
    
    
    
    
   
}
