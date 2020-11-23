//
//  SearchMemberVC.swift
//  SocietyMangement
//
//  Created by MacMini on 04/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

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
class SearchMemberVC: UIViewController , UISearchBarDelegate , UITableViewDelegate , UITableViewDataSource{

    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet var viewnoresult: UIView!
    @IBOutlet weak var tblview: UITableView!

    var membersary = [Members]()
    var newmembersary = [Members]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        

        apicallGetMembers()
        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        membersary.removeAll()
        if(searchText != nil)
        {
       /* for dic in newmembersary
        {
           if(dic.name.lowercased().contains(searchText.lowercased()))
           {
            membersary.append(dic)
            }
            tblview.reloadData()
        } */
        }
        else
        {
            membersary = newmembersary
            tblview.reloadData()

            
        }
        
    }
    
    // MARK: - Tableview delegate and data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return membersary.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SocietyEventcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocietyEventcell
        
   /*     cell.lblname.text = "Name :\(membersary[indexPath.row].name)"
        cell.lblcontact.text = "Contact No :\(membersary[indexPath.row].phone)"
        cell.lblflatno.text = "Flat No :\(membersary[indexPath.row].gender!)"
        cell.lblflattype.text = "Flat Type :\(membersary[indexPath.row].flatType!)"
        
        cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + membersary[indexPath.row].image!), placeholderImage: UIImage(named: "img_default")) */
        
        webservices.sharedInstance.setShadow(view:cell.innerview)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MemberdetailVC") as! MemberdetailVC
        nextViewController.dic = membersary[indexPath.row]
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    // MARK: - get Members
    
    func apicallGetMembers()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
        let strToken =  UserDefaults.standard.value(forKey:USER_TOKEN)

        let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
        
        let id = String(format: "%d",SociId)


        
          //  Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST, societyid:UserDefaults.standard.value(forKey:"societyid")! as! String, building_id:"", token: "") { JSON in
                
                Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST + id ,token:strToken as! String) { JSON in

                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.membersary = resp.data!
                        self.newmembersary = resp.data!
                        self.tblview.reloadData()
                        self.tblview.isHidden = false
                        self.viewnoresult.isHidden = true
                    }
                        
                    else
                    {
                        if(resp.data!.count == 0)
                        {
                            self.tblview.isHidden = true
                            self.viewnoresult.isHidden = false
                        }
                        else
                        {
                            self.tblview.isHidden = false
                            self.viewnoresult.isHidden = true
                            
                            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message!)
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
