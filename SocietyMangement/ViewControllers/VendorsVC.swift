//
//  VendorsVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
class VendorsVC: UIViewController, UITableViewDelegate , UITableViewDataSource {

    
    @IBOutlet weak var tblview: UITableView!

    @IBOutlet var viewnoresult: UIView!

    var vendorsary = [Vendor]()
    
    @IBAction func backaction(_ sender: Any) {
     
        
        revealViewController()?.revealToggle(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        viewnoresult.center = self.view.center
        self.view.addSubview(viewnoresult)
        viewnoresult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewnoresult.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        viewnoresult.heightAnchor.constraint(equalToConstant: 198).isActive = true
        
        viewnoresult.isHidden  = true
        if(revealViewController() != nil)
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        apicallVednors()

    }
    // MARK: - Tableview delegate and data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vendorsary.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SocietyEventcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocietyEventcell
        
        cell.lblname.text = "Profession :\(vendorsary[indexPath.row].vendorProfession)"
        cell.lblcontact.text = "Name :\(vendorsary[indexPath.row].vendorName)"
        cell.lblflatno.text = "Contact No :\(vendorsary[indexPath.row].vendorPhone)"
        cell.lblflattype.text = "Email :\(vendorsary[indexPath.row].vendorEmail)"
        
        cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + vendorsary[indexPath.row].vendorProfile), placeholderImage: UIImage(named: "img_default"))
        
        cell.btnedit.addTarget(self, action:#selector(editvendor), for: .touchUpInside)
        cell.btndelete.addTarget(self, action:#selector(deleteVendor), for: .touchUpInside)

        cell.btnedit.tag = indexPath.row
        cell.btndelete.tag = indexPath.row
        
        
        webservices.sharedInstance.setShadow(view:cell.innerview)
        return cell
        
    }
    @objc func deleteVendor(sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
        avc?.subtitleStr = "Are you sure you want to delete \(self.vendorsary[sender.tag].vendorName)?"
        avc?.yesAct = {
              
                 self.apicallDeleteVendor(id: self.vendorsary[sender.tag].id)

            }
        avc?.noAct = {
          
        }
        present(avc!, animated: true)
        
//
//        let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to delete \(self.vendorsary[sender.tag].vendorName)?", preferredStyle: UIAlertControllerStyle.alert)
//
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//            self.apicallDeleteVendor(id: self.vendorsary[sender.tag].id)
//
//            print("Handle Ok logic here")
//        }))
//
//        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("Handle Cancel Logic here")
//        }))
//
//        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    @objc func editvendor(sender:UIButton)
    {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddVendorVC") as! AddVendorVC
        nextViewController.isfrom = 1
        nextViewController.dic = self.vendorsary[sender.tag]
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - get Vendors
    
    func apicallVednors()
    {
        if(webservices().isConnectedToNetwork())
        {
            webservices().StartSpinner()
            Apicallhandler().GetAllVedors(URL: webservices().baseurl + "getVendor", societyid:UserDefaults.standard.value(forKey:"societyid")! as! String) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(resp.errorCode == 0)
                    {
                        self.vendorsary = resp.data
                        
                        self.tblview.reloadData()
                        self.tblview.isHidden = false
                        self.viewnoresult.isHidden = true
                    }
                        
                    else
                    {
                        if(resp.data.count == 0)
                        {
                            self.tblview.isHidden = true
                            self.viewnoresult.isHidden = false
                        }
                        else
                        {
                            self.tblview.isHidden = false
                            self.viewnoresult.isHidden = true
                            
                            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
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
        else
        {
          //  webservices.sharedInstance.nointernetconnection()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                                                                                                                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoInternetVC") as! NoInternetVC
                                                                                                                                                             nextViewController.TryAgian = {
                                                                                                                                                               
                                                                                                                                                              self.apicallVednors()

                                                                                                                              }
                                                                                                                                                             self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
            
        }
        
    }
    
    
    
    
    // MARK: - Delete Vendor
    
    func apicallDeleteVendor(id:String)
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().DeleteVendor(URL: webservices().baseurl + "deleteVendor", id:id) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        self.apicallVednors()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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
