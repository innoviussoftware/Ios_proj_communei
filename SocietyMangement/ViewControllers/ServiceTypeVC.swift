//
//  ServiceTypeVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 10/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

protocol ServiceTypeListProtocol {
    func serviceTypeList(name:String,vendorServiceTypeID:Int, selectNumber:Int)
    
    func serviceTypeList1(name1:String,vendorServiceTypeID1:Int, selectNumber1:Int)

}

class ServiceTypecell:UITableViewCell
{
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgselectmark: UIImageView!

}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ServiceTypeVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tblServiceType: UITableView!
    
  //  var data = ["Ac Service", "Business Events", "Carpenter", "Caterers", "Civil Work", "Cleaning Services", "Cleaning Services Office", "Computer/Laptop Repair", "Curtains & Blinds", "Driver", "Electrician", "Elevator Services", "Fabrication Service", "Flourmill Repair", "Gardening", "Geyser", "Glass Works", "Home Appliances", "Interior Designer_Office", "Interior Designers", "Lcd/Led Repair", "Maid Services", "Microwaves/Ovens Repair", "Movers & Packers", "Overseas Visa Services", "Painting", "Party & Event Mgmt", "Passport Services", "Pest Control", "Photographers", "Plumber", "Refrigerator Repair", "Ro Services", "Security Services", "Security Services_Office", "Water Cooler"]

    var serviceArry = [ServiceType]()
    
    var selectedindex:Int?
    
    var selectedindex1:Int?
    
    var isfrom = ""
    
    var delegate:ServiceTypeListProtocol?
    
    
    func apiCallServiceType() {
        if !NetworkState().isInternetAvailable {
                        ShowNoInternetAlert()
                        return
                    }
           let token = UserDefaults.standard.value(forKey: USER_TOKEN) as! String
           webservices().StartSpinner()
       
       Apicallhandler().GetAllServiceType(URL: webservices().baseurl + API_SERVICE_TYPES, token: token) { JSON in

               switch JSON.result{
               case .success(let resp):
                   webservices().StopSpinner()
                   if(JSON.response?.statusCode == 200)
                   {
                       self.serviceArry = resp.data!

                       self.tblServiceType.reloadData()
                       
                       if(resp.data!.count == 0)
                       {
                           self.tblServiceType.isHidden = true
                       }
                       else
                       {
                           self.tblServiceType.isHidden = false
                       }
                       
                   }
                   else if(JSON.response?.statusCode == 401)
                   {
                       APPDELEGATE.ApiLogout(onCompletion: { int in
                           if int == 1{
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                             let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                          let navController = UINavigationController(rootViewController: aVC)
                                                                          navController.isNavigationBarHidden = true
                                                             self.appDelegate.window!.rootViewController  = navController
                                                             
                           }
                       })
                       
                       
                   }
                   else
                   {
                       
                   }
                   
                   print(resp)
               case .failure(let err):

                   webservices().StopSpinner()
                   if JSON.response?.statusCode == 401{
                    if #available(iOS 13.0, *) {
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                let navController = UINavigationController(rootViewController: aVC)
                                navController.isNavigationBarHidden = true
                                self.appDelegate.window!.rootViewController  = navController
                                
                            }
                        })
                    } else {
                        // Fallback on earlier versions
                    }
                       
                       return
                   }
                  // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                 //  self.present(alert, animated: true, completion: nil)
                   print(err.asAFError!)
                   
                   
               }
               
           }
     
   }

    override func viewDidLoad() {
        super.viewDidLoad()

        apiCallServiceType()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- tableview delegate
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceArry.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell: ServiceTypecell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! ServiceTypecell
        
        cell.lblname.text = serviceArry[indexPath.row].type

        if(isfrom == "Single") {
            if(selectedindex == indexPath.row) {
                cell.imgselectmark.image = UIImage(named: "ic_tick_mark")
            }else {
                cell.imgselectmark.image = UIImage(named: "")
            }
        }else if(isfrom == "Multiple") {
            if(selectedindex1 == indexPath.row) {
                cell.imgselectmark.image = UIImage(named: "ic_tick_mark")
            }else {
                cell.imgselectmark.image = UIImage(named: "")
            }
        }else{
            if(selectedindex == indexPath.row) {
                cell.imgselectmark.image = UIImage(named: "ic_tick_mark")
            }else {
                cell.imgselectmark.image = UIImage(named: "")
            }
        }
                             
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(isfrom == "Single") {
            selectedindex = indexPath.row
        
            tblServiceType.reloadData()
        
            delegate?.serviceTypeList(name: serviceArry[indexPath.row].type!, vendorServiceTypeID: serviceArry[indexPath.row].vendorServiceTypeID!, selectNumber: selectedindex!)
        }else if(isfrom == "Multiple") {
            selectedindex1 = indexPath.row
        
            tblServiceType.reloadData()
        
            delegate?.serviceTypeList1(name1: serviceArry[indexPath.row].type!, vendorServiceTypeID1: serviceArry[indexPath.row].vendorServiceTypeID!, selectNumber1: selectedindex1!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
