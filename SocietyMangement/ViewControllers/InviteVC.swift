//
//  InviteVC.swift
//  SocietyMangement
//
//  Created by MacMini on 02/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import ScrollPager
import ContactsUI
import Contacts

class manuallycell:UITableViewCell
{
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var btndelete: UIButton!
    
    
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
@available(iOS 13.0, *)
class InviteVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate,ScrollPagerDelegate {
    
//Manish
    
    
    var contacts = [CNContact]()
    var contactsWithSections = [[CNContact]]()
    let collation = UILocalizedIndexedCollation.current() // create a locale collation object, by which we can get section index titles of current locale. (locale = local contry/language)
    var sectionTitles = [String]()

    
    @IBOutlet weak var lblTodayData: UILabel!
    @IBOutlet weak var lbltodayContact: UILabel!
    @IBOutlet weak var hightcontactview: NSLayoutConstraint!
    
    @IBOutlet weak var lblStaticAllowUser: UILabel!
    @IBOutlet weak var txtcontact: UITextField!
    @IBOutlet weak var txtname: UITextField!
    
    @IBOutlet weak var tblmanually: UITableView!
    
    @IBOutlet weak var tblcontact: UITableView!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var viewbottom: UIView!
    
    @IBOutlet var ViewContact: UIView!
    
    @IBOutlet var viewmanual: UIView!
    
    @IBOutlet weak var btncancel: UIButton!
    
    var selectedindex = NSMutableArray()
    
    @IBOutlet weak var pager: ScrollPager!
    
    var arrContactName = NSMutableArray()
    
    var results =  [CNContact]()
    var finalresults =  [CNContact]()
    var isfrom = ""
    
    
    //Manish
    var arrCotact = NSMutableArray()
    var arrFinal = NSMutableArray()
    
    
    
    var manuallyary = NSMutableArray()
    @IBAction func saveaction(_ sender: Any) {
        
        if(txtname.text!.isEmpty)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if(txtcontact.text!.isEmpty)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter contact")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            let dic = NSMutableDictionary()
            dic.setValue(txtname.text!, forKey: "name")
            dic.setValue(txtcontact.text!, forKey: "contact")
            
            manuallyary.add(dic)
            tblmanually.reloadData()
            let nameary = NSMutableArray()
            
            
            if(selectedindex.count > 0)
            {
                
//                        for dic in finalresults
//                           {
//                            let namenew = dic.givenName + " " + dic.familyName
//
//                               if(selectedindex.contains(namenew))
//                               {
//                                let dict = NSMutableDictionary()
//                                dict.setValue(namenew, forKey: "name")
//                                for phoneNumber in dic.phoneNumbers {
//                                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
//                                        let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
//                                        var mobile = number.stringValue
//                                        mobile = mobile.replacingOccurrences(of: " ", with: "")
//                                       dict.setValue(mobile, forKey: "contact")
//
//                                    }
//                                }
//
//
//                                nameary.add(namenew)
//                                lblname.text = nameary.componentsJoined(by:", ")
//
//                                arrContactName.add(dict)
//                               }
//
//                           }
                
                
                
                
                for i in 0...arrFinal.count - 1{
                      let dicc = (arrFinal[i] as! NSMutableDictionary)
                      let namenew = dicc.value(forKey: "name")
                    if(selectedindex.contains(namenew))
                    {
                        let dict = NSMutableDictionary()
                        dict.setValue(namenew, forKey: "name")
                        dict.setValue(dicc.value(forKey: "mobile"), forKey: "contact")
                        
                        nameary.add(namenew)
                        lblname.text = nameary.componentsJoined(by:", ")
                        
                        arrContactName.add(dict)
                        
                    }
                    
                }
                
            }
            
            if(manuallyary.count > 0)
            {
                for i in 0...manuallyary.count-1
                {
                    let dic = manuallyary.object(at:i) as! NSMutableDictionary
                    nameary.add(dic.value(forKey:"name") as! String)
                    lblname.text = nameary.componentsJoined(by:", ")
                 
                    let dict = NSMutableDictionary()
                    dict.setValue(dic.value(forKey:"name") as! String, forKey: "name")
                     dict.setValue(dic.value(forKey:"contact") as! String, forKey: "contact")
                    arrContactName.add(dict)
                    
                }
                
                
            }
           if(nameary.count > 6)
                 {
                      hightcontactview.constant = 202
                      
                 }
                  else if(nameary.count > 3)
                 {
                     hightcontactview.constant = 152

                     
                 }
                 else if(nameary.count > 0)
                 {
                     let top = CGAffineTransform(translationX: 0, y: 0)
                     
                     UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
                         // Add the transformation in this block
                         // self.container is your view that you want to animate
                         self.viewbottom.transform = top
                         self.viewbottom.isHidden = false
                     }, completion: nil)
                     hightcontactview.constant = 102
                 }
                
                 else{
                     self.viewbottom.isHidden = true
                     
                 }
                 pager.setSelectedIndex(index: 0, animated: true)
                 txtname.text = ""
                 txtcontact.text = ""
            
            if arrContactName.count > 1{
                lblStaticAllowUser.text = "Allow to enter"
            }else{
                lblStaticAllowUser.text = "Allow to enter"
            }
            
        }

    }
    
    @IBAction func cancelaction(_ sender: Any) {
        
        txtname.text = ""
        txtcontact.text = ""
    }
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionNext(_ sender: Any) {
         
                   let nameary = NSMutableArray()
                   arrContactName.removeAllObjects()
                    
                    if(selectedindex.count > 0)
                    {
                        
//                                for dic in results
//                                   {
//                                    let namenew = dic.givenName + " " + dic.familyName
//
//                                       if(selectedindex.contains(namenew))
//                                       {
//                                        let dict = NSMutableDictionary()
//                                        dict.setValue(namenew, forKey: "name")
//                                        for phoneNumber in dic.phoneNumbers {
//                                            if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
//                                                let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
//                                                var mobile = number.stringValue
//                                                mobile = mobile.replacingOccurrences(of: " ", with: "")
//                                               dict.setValue(mobile, forKey: "contact")
//
//                                            }
//                                        }
//
//
//                                        nameary.add(namenew)
//                                        lblname.text = nameary.componentsJoined(by:", ")
//
//                                        arrContactName.add(dict)
//                                       }
//
//                                   }
                        
                        
                        
                        for i in 0 ..< arrCotact.count
                        {
                                             let dicc = (arrCotact[i] as! NSMutableDictionary)
                                             let namenew = dicc.value(forKey: "name") as! String
                                           if(selectedindex.contains(namenew))
                                           {
                                               let dict = NSMutableDictionary()
                                               dict.setValue(namenew, forKey: "name")
                                               dict.setValue(dicc.value(forKey: "mobile"), forKey: "contact")
                                               
                                               nameary.add(namenew)
                                               lblname.text = nameary.componentsJoined(by:", ")
                                               
                                               arrContactName.add(dict)
                                               
                                           }
                                           
                                    }
                        
         
                    }
                    
                    if(manuallyary.count > 0)
                    {
                        for i in 0...manuallyary.count-1
                        {
                            let dic = manuallyary.object(at:i) as! NSMutableDictionary
                            nameary.add(dic.value(forKey:"name") as! String)
                            lblname.text = nameary.componentsJoined(by:", ")
                         
                            let dict = NSMutableDictionary()
                            dict.setValue(dic.value(forKey:"name") as! String, forKey: "name")
                             dict.setValue(dic.value(forKey:"contact") as! String, forKey: "contact")
                            arrContactName.add(dict)
                        }
                    }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditGuestVC") as! EditGuestVC
        vc.arrInvitedmember = arrContactName
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func strChangeDateFormate(strDateeee:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let strDate = formatter.date(from: strDateeee)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "yyyy-MM-dd"
            str = formatter.string(from: strDate!)
        }else{
            str = strDateeee
        }
        
        
        return str
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        
        self.fetchContacts()
        
        var strDateee = ""
               var endDate = ""
                   
                   if frequencyType == "once"{
                   }else{
                       strDateee = strChangeDateFormate(strDateeee: startdate)
                       endDate = strChangeDateFormate(strDateeee: enddate)
                   }
               
        
        if frequencyType == "once"{
             lblTodayData.text = "\(date),\(time),\(validtill)"
             lbltodayContact.text = "\(date),\(time),\(validtill)"
        }else{
            
            lblTodayData.text = "\(strDateee) to \(endDate)"
            lbltodayContact.text = "\(strDateee) to \(endDate)"

           // lblTodayData.text = "\(startdate) to \(enddate)"
           // lbltodayContact.text = "\(startdate) to \(enddate)"
        }
        
        btncancel.layer.borderColor = AppColor.borderColor.cgColor
        btncancel.layer.borderWidth = 1.0
        
        viewbottom.isHidden = true
        webservices.sharedInstance.setShadow(view: viewbottom)
        let contactStore = CNContactStore()
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request) {
                contact, _ in
                // Array containing all unified contacts from everywhere
                self.results.append(contact)
                self.finalresults.append(contact)
                
                
                
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                        let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                        
                        // Get The Name
                        let name = contact.givenName + " " + contact.familyName
                        print(name)
                        
                        // Get The Mobile Number
                        var mobile = number.stringValue
                        mobile = mobile.replacingOccurrences(of: " ", with: "")
                        
                        var email: String
                        for mail in contact.emailAddresses {
                            email = mail.value as String
                            print(email)
                        }
                    }
                }
            }
            
        } catch {
            print("unable to fetch contacts")
        }        
        
        
        pager.addSegmentsWithTitlesAndViews(segments: [
            ("Contact", ViewContact),
            ("Manual",viewmanual)
        ])
        if(isfrom == "")
        {
            
            pager.setSelectedIndex(index: 0, animated: true)
        }
        if(isfrom == "conatct")
        {
            
            pager.setSelectedIndex(index: 0, animated: true)
        }
        if(isfrom == "manually")
        {
            
            pager.setSelectedIndex(index: 1, animated: false)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == tblcontact)
        {
            return arrCotact.count
        }
        else
        {
            
            return manuallyary.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblcontact)
        {
            let cell: SidemenuCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SidemenuCell
            
            cell.lblcontact.text = (arrCotact[indexPath.row] as! NSMutableDictionary).value(forKey: "mobile") as? String
            cell.lblname.text = (arrCotact[indexPath.row] as! NSMutableDictionary).value(forKey: "name") as? String
            
            // Get The Name
                                let name = (arrCotact[indexPath.row] as! NSMutableDictionary).value(forKey: "name") as? String
                                print(name)
                                if(selectedindex.contains(name))
                                {
                                    cell.imagview.image = #imageLiteral(resourceName: "ic_checked")
                                }
                                else{
            
                                    cell.imagview.image = #imageLiteral(resourceName: "ic_unchecked")
            
                                }
            
            
            
            
            
//            for phoneNumber in results[indexPath.row].phoneNumbers {
//                if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
//                    let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
//
//                    // Get The Name
//                    let name = results[indexPath.row].givenName + " " + results[indexPath.row].familyName
//                    print(name)
//
//
//                    if(selectedindex.contains(name))
//                    {
//                        cell.imagview.image = #imageLiteral(resourceName: "ic_checked")
//
//
//                    }
//                    else{
//
//                        cell.imagview.image = #imageLiteral(resourceName: "ic_unchecked")
//
//                    }
//                    cell.lblname.text = name
//                    // Get The Mobile Number
//                    var mobile = number.stringValue
//                    mobile = mobile.replacingOccurrences(of: " ", with: "")
//                    cell.lblcontact.text = mobile
//
//                    var email: String
//                    for mail in results[indexPath.row].emailAddresses {
//                        email = mail.value as String
//                        print(email)
//
//                    }
//                }
//            }
            
            
            return cell
        }
        else
        {
            let cell: manuallycell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! manuallycell
            
            let dic = manuallyary.object(at: indexPath.row) as! NSMutableDictionary
            
            cell.lblname.text = dic.value(forKey:"name") as? String
            cell.lblcontact.text = dic.value(forKey: "contact") as? String
            cell.btndelete.tag = indexPath.row
            cell.btndelete.addTarget(self, action: #selector(deleteaction), for: .touchUpInside)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let namenew = results[indexPath.row].givenName + " " + results[indexPath.row].familyName
        let namenew = (arrCotact[indexPath.row] as! NSMutableDictionary).value(forKey: "name") as? String
        
        if(selectedindex.contains(namenew!))
        {
            selectedindex.remove(namenew)
        }
        else
        {
            selectedindex.add(namenew)
        }
        
        // Get The Name
        
        let nameary = NSMutableArray()
        
        if(selectedindex.count > 0)
        {
//            for dic in finalresults
//            {
//                let namenew = dic.givenName + " " + dic.familyName
//                if(selectedindex.contains(namenew))
//                {
//                 nameary.add(namenew)
//                 lblname.text = nameary.componentsJoined(by:", ")
//                }
//
//            }
            
            //Manish
            
            for i in 0 ..< arrFinal.count
            {
                let dict = arrFinal[i] as! NSMutableDictionary
                let namenew = dict.value(forKey: "name") as! String
                if(selectedindex.contains(namenew))
                {
                 nameary.add(namenew)
                 lblname.text = nameary.componentsJoined(by:", ")
                }
                
            }
            
            
            
        }
        
      
        if(manuallyary.count > 0)
        {
            for i in 0...manuallyary.count-1
            {
                
                let dic = manuallyary.object(at:i) as! NSMutableDictionary
                nameary.add(dic.value(forKey:"name") as! String)
                lblname.text = nameary.componentsJoined(by:", ")
                
            }
            
            
        }
        if(nameary.count > 6)
        {
             hightcontactview.constant = 202

             
        }
         else if(nameary.count > 3)
        {
            hightcontactview.constant = 152

            
        }
        else if(nameary.count > 0)
        {
            let top = CGAffineTransform(translationX: 0, y: 0)
            
            UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
                // Add the transformation in this block
                // self.container is your view that you want to animate
                self.viewbottom.transform = top
                self.viewbottom.isHidden = false
            }, completion: nil)
            hightcontactview.constant = 102
        }
       
        else{
            self.viewbottom.isHidden = true
            
        }
        
        if nameary.count > 1{
            lblStaticAllowUser.text = "Allow to enter"
        }else{
            lblStaticAllowUser.text = "Allow to enter"
        }
        
        tableView.reloadData()
        
        
    }
    
    // MARK: - ScrollPagerDelegate -
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        print("scrollPager index changed: \(changedIndex)")
       // pager.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)

       /* if changedIndex == 0 {
         pager.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        }else{
            pager.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: 60)
        } */

    }
    
    @objc func deleteaction(sender:UIButton)
    {
        
        manuallyary.removeObject(at: sender.tag)
        
        let nameary = NSMutableArray()
                   
                   
                   if(selectedindex.count > 0)
                   {
                       for i in 0...selectedindex.count-1
                       {
                           
//                           let new = finalresults[i]
//                           let name = new.givenName + " " + new.familyName
                         
                          let dict = arrFinal[i] as! NSMutableDictionary
                          let name = dict.value(forKey: "name") as! String
                          let mobile = dict.value(forKey: "mobile") as! String
                        
                           nameary.add(name)
                           
                           let dic = NSMutableDictionary()
                           dic.setValue(name, forKey: "name")
                           dic.setValue(mobile, forKey: "contact")
                           
//                           for phoneNumber in new.phoneNumbers {
//                                          if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
//                                              let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
//                                              var mobile = number.stringValue
//                                              mobile = mobile.replacingOccurrences(of: " ", with: "")
//                                             dict.setValue(mobile, forKey: "contact")
//
//                                          }
//                                      }
                                      
                          // arrContactName.add(dic)
                           arrContactName.add(dic)
                       }
                       
                       
                   }
                   
                   if(manuallyary.count > 0)
                   {
                       for i in 0...manuallyary.count-1
                       {
                           let dic = manuallyary.object(at:i) as! NSMutableDictionary
                           nameary.add(dic.value(forKey:"name") as! String)
                           lblname.text = nameary.componentsJoined(by:", ")
                        
                           let dict = NSMutableDictionary()
                           dict.setValue(dic.value(forKey:"name") as! String, forKey: "name")
                            dict.setValue(dic.value(forKey:"contact") as! String, forKey: "contact")
                           arrContactName.add(dict)
                           
                       }
                       
                       
                   }
                     if(nameary.count > 6)
                           {
                                hightcontactview.constant = 202

                                
                           }
                            else if(nameary.count > 3)
                           {
                               hightcontactview.constant = 152

                               
                           }
                           else if(nameary.count > 0)
                           {
                               let top = CGAffineTransform(translationX: 0, y: 0)
                               
                               UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
                                   // Add the transformation in this block
                                   // self.container is your view that you want to animate
                                   self.viewbottom.transform = top
                                   self.viewbottom.isHidden = false
                               }, completion: nil)
                               hightcontactview.constant = 102
                           }
                          
                           else{
                               self.viewbottom.isHidden = true
                               
                           }
                           
        
        tblmanually.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if(searchText != "")
        {
            arrCotact.removeAllObjects()
            
            for i in 0 ..< arrFinal.count
            {
                let dict = arrFinal[i] as! NSMutableDictionary
                let namenew = dict.value(forKey: "name") as! String
                        if(namenew.lowercased().contains(searchText.lowercased()))
                        {
                            arrCotact.add(dict)
                        }
                        
                        tblcontact.reloadData()
                
            }
            
//
//
//            for dic in finalresults
//            {
//                var strMobile = ""
//                let namenew = dic.givenName + " " + dic.familyName
////                for phoneNumber in dic.phoneNumbers {
////                                                   if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
////                                                       let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
////                                                       var mobile = number.stringValue
////                                                       strMobile = mobile.replacingOccurrences(of: " ", with: "")
////
////                                                   }
////                                               }
//
//             //   || strMobile.contains(searchText.lowercased())
//
//                if(namenew.lowercased().contains(searchText.lowercased()))
//                {
//                    results.append(dic)
//
//                }
//
//                tblcontact.reloadData()
//            }
            
        }
        else
        {
            //results = finalresults
            arrCotact = arrFinal.mutableCopy() as! NSMutableArray
            //arrCotact = arrFinal
            tblcontact.reloadData()
            
        }
        
        
        self.tblcontact.reloadData()
    }
    
  
    
    
    private func fetchContacts(){

        let store = CNContactStore()

        store.requestAccess(for: (.contacts)) { (granted, err) in
            if let err = err{
                print("Failed to request access",err)
                return
            }

            if granted {
                print("Access granted")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

                fetchRequest.sortOrder = CNContactSortOrder.userDefault

                do {
                    try store.enumerateContacts(with: fetchRequest, usingBlock: { ( contact, error) -> Void in

                        guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else {return}
                        //self.contactst(givenName: contact.givenName, familyName: contact.familyName, mobile: phoneNumber))
                        
                        let strs = contact.givenName + contact.familyName
                        
                        let dict = NSMutableDictionary()
                        dict.setValue(strs, forKey: "name")
                        dict.setValue(phoneNumber, forKey: "mobile")
                        self.arrCotact.add(dict)
                        self.arrFinal.add(dict)
                    })
                    
                    DispatchQueue.main.async {
                        self.tblcontact.reloadData()
                    }
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }


            }else{
                print("Access denied")
            }
        }

    }

  
}




