//
//  MembersVC.swift
//  SocietyMangement
//
//  Created by MacMini on 30/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
import SDWebImage
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
class MembersVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate {
    
    @IBOutlet weak var collectionmembers: UICollectionView!
    
    @IBOutlet weak var collectionbuildings: UICollectionView!
    
    @IBOutlet weak var lblnoproperty: UILabel!
    
    @IBOutlet weak var txtbuilding: GBTextField!
    @IBOutlet var viewnoresult: UIView!
    
    @IBOutlet weak var btnadd: UIButton!
    
    @IBOutlet weak var btnMenu: UIButton!
    var searchActive = false
    
    var buildingary = [Building]()
    var membersary =  [Members]()
    var allmembersary =  [Members]()
    var Finalallmembersary =  [Members]()
    
    var pickerview = UIPickerView()
    var buildingid:Int? = 1
    
    var isFromDash = 0
    var selectedbuilding = 0
    var selectedbloodgrop = ""
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var hightcollectionbuilding: NSLayoutConstraint!
    
    
    @IBOutlet weak var filtrview: UIView!
    
    @IBOutlet weak var CollectionBloodGrp: UICollectionView!
    
    var arrBloodGrp = NSMutableArray()
    
    @IBOutlet weak var tblview: UITableView!
    @IBAction func backaction(_ sender: Any) {
        
        if isFromDash == 0{
            revealViewController()?.revealToggle(self)
        }else{
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    @IBAction func filteraction(_ sender: Any) {
        self.viewnoresult.isHidden = true
        setView(view: filtrview, hidden: false)

    }
    
    @IBAction func applyfilteraction(_ sender: Any) {
       
      
        filtrview.isHidden = false
        self.collectionmembers.reloadData()
        hightcollectionbuilding.constant = 0
        self.collectionbuildings.isHidden = true
            setView(view: filtrview, hidden: true)

        apicallGetAllMembers()
        self.searchActive = true
        
     
        
    }
    
    @IBAction func clearaction(_ sender: Any) {
        arrBloodGrp.removeAllObjects()
//        for i in 0..<bloodgroupary.count{
//            arrTemp.add("0")
//        }
        setUpView()
        selectedbloodgrop = ""
        searchActive = false
        apicallGetBuildings()
        CollectionBloodGrp.reloadData()
    }
    
    
    var bloodgroupary = ["A+","A-","B+","B-","AB+","AB-","O+","O-"]
    var arrTemp = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 0..<bloodgroupary.count{
//            arrTemp.add("0")
//        }
        
        setUpView()
        
        // 22/8/20.
        
       // apicallGetAllMembers()
        apicallGetBuildings()
        webservices.sharedInstance.setShadow(view: filtrview)
        setView(view: filtrview, hidden: true)
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                verticalAlignment: .center)
        
        collectionmembers.collectionViewLayout = alignedFlowLayout
        //
        //        lblnoproperty.text = "No Member Result Found"
        //         lblnoproperty.font =  UIFont(name:"Lato-Regular", size:20.0)!
        //        lblnoproperty.textColor = UIColor.darkGray
        //         lblnoproperty.textAlignment = .center
        //         lblnoproperty.isHidden = true
        //         lblnoproperty.frame = CGRect(x:0, y: self.view.frame.height, width: self.view.frame.width, height: 40)
        //         self.view.addSubview(lblnoproperty)
        //         self.view.bringSubview(toFront:lblnoproperty)
        
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        
        if isFromDash == 0{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }else{
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }
        
        
        viewnoresult.center = self.view.center
        self.view.addSubview(viewnoresult)
        viewnoresult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewnoresult.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        viewnoresult.heightAnchor.constraint(equalToConstant: 198).isActive = true
        
        viewnoresult.isHidden  = false
        
        
        if(revealViewController() != nil)
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        let alignedFlowLayout1 = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                 verticalAlignment: .center)
        
        CollectionBloodGrp.collectionViewLayout = alignedFlowLayout1
            
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    func setUpView() {
        
        
        let dict = NSMutableDictionary()
        dict.setValue("A+", forKey: "blood_grp")
        dict.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict)
        
        let dict1 = NSMutableDictionary()
        dict1.setValue("A-", forKey: "blood_grp")
        dict1.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict1)
        
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("B+", forKey: "blood_grp")
        dict2.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict2)
        
        
        
        let dict3 = NSMutableDictionary()
        dict3.setValue("B-", forKey: "blood_grp")
        dict3.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict3)
        
        let dict4 = NSMutableDictionary()
        dict4.setValue("AB+", forKey: "blood_grp")
        dict4.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict4)
        
        let dict5 = NSMutableDictionary()
        dict5.setValue("AB-", forKey: "blood_grp")
        dict5.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict5)
        
        let dict6 = NSMutableDictionary()
        dict6.setValue("O+", forKey: "blood_grp")
        dict6.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict6)
        
        let dict7 = NSMutableDictionary()
        dict7.setValue("O-", forKey: "blood_grp")
        dict7.setValue("0", forKey: "is_selected")
        arrBloodGrp.add(dict7)
        
        
        
    }
    
    
    @objc func AcceptRequest(notification: NSNotification) {
        
        let object = notification.object as! NSDictionary
        
        if let key = object.object(forKey: "notification_type")
        {
            let value = object.value(forKey: "notification_type") as! String
            
            if(value == "security")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GuestPopVC") as! GuestPopVC
                nextViewController.guestdic = object
                nextViewController.isfromnotification = 0
                navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            else if object.value(forKey: "notification_type") as! String == "Notice"{
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                nextViewController.isFrormDashboard = 0
                
                navigationController?.pushViewController(nextViewController, animated: true)
                
                
                
            }else if object.value(forKey: "notification_type") as! String == "Circular"{
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                nextViewController.isfrom = 2
                
                navigationController?.pushViewController(nextViewController, animated: true)
                
                
                
            }else if object.value(forKey: "notification_type") as! String == "Event"{
                
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                nextViewController.isfrom = 1
                
                navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(buildingary.count == 0)
        {
            textField.resignFirstResponder()
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No Buildings Found")
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionmembers)
        {
            if(searchActive == false)
            {
                return membersary.count
            }
            else
            {
                return allmembersary.count
                
            }
        }
        else if(collectionView == CollectionBloodGrp)
        {
            //return bloodgroupary.count
            return arrBloodGrp.count
            
        }
        else
        {
            return buildingary.count
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionmembers)
        {
            if(searchActive == false)
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! NewMemberCell
                
                if membersary[indexPath.item].member_status == 0 ||  membersary[indexPath.item].member_status == 2{
                    //  cell.lblContact.isHidden = true
                    cell.btnCall.isHidden = true
                    // cell.lblStatic.isHidden = true
                    
                }else{
                    // cell.lblContact.isHidden = false
                    cell.btnCall.isHidden = false
                    //  cell.lblStatic.isHidden = false
                    
                }
                
                webservices().setShadow(view: cell.innerview)
                
                print("------->>>>\(membersary[indexPath.item].name), \(membersary[indexPath.item].buildingname!)-\(membersary[indexPath.item].flatname!)")
                
                cell.lblStatic.text =  "\(membersary[indexPath.item].flatname!)" //\(membersary[indexPath.item].buildingname!)-
                // cell.lblContact.text = membersary[indexPath.item].phone
                // cell.btnedit.tag = indexPath.row
                cell.btnCall.tag = indexPath.item
                
                if membersary[indexPath.row].image != nil{
                    //  cell.imgMember.sd_setImage(with: URL(string: webservices().imgurl + membersary[indexPath.item].image!), placeholderImage: UIImage(named: "vendor-1"))
                }
                
                cell.lblName.text = membersary[indexPath.item].name
                cell.lblprofession.text = membersary[indexPath.item].profession
                cell.btnCall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
                
                if membersary[indexPath.item].bloodgroup != nil{
                    cell.lblBloodGroup.isHidden = false
                    cell.lblBloodGroup.text = String(format: "Blood Group: %@", membersary[indexPath.item].bloodgroup!)//"Blood Group: \(membersary[indexPath.item].bloodgroup!)"
                    }else{
                    cell.lblBloodGroup.isHidden = true
                }
                
                
                if(membersary[indexPath.row].flatType == "Renting the flat")
                {
                    
                    cell.innerview.layer.borderWidth = 1.0
                    cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                    cell.lblName.textColor = UIColor.orange
                    cell.lblStatic.textColor = UIColor.orange
                    
                    
                }
                
                if(membersary[indexPath.row].flatType == "Owner of flat")
                {
                    
                    cell.innerview.layer.borderWidth = 1.0
                    cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                    cell.lblName.textColor = UIColor.black
                    cell.lblStatic.textColor =  UIColor.black
                    
                }
                
                
                return cell
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! NewMemberCell
                
                if allmembersary[indexPath.item].member_status == 0 ||  allmembersary[indexPath.item].member_status == 2{
                    //  cell.lblContact.isHidden = true
                    cell.btnCall.isHidden = true
                    // cell.lblStatic.isHidden = true
                    
                }else{
                    // cell.lblContact.isHidden = false
                    cell.btnCall.isHidden = false
                    //  cell.lblStatic.isHidden = false
                    
                }
                
                if allmembersary[indexPath.item].bloodgroup != nil{
                                  cell.lblBloodGroup.isHidden = false
                                  cell.lblBloodGroup.text = String(format: "Blood Group: %@", allmembersary[indexPath.item].bloodgroup!)
                                   cell.lblBloodGroup.isHidden = false
                               }else{
                                   cell.lblBloodGroup.isHidden = true
                               }
                
                
                webservices().setShadow(view: cell.innerview)
                
                print("------->>>>\(allmembersary[indexPath.item].name), \(allmembersary[indexPath.item].buildingname!)-\(allmembersary[indexPath.item].flatname!)")
                
                cell.lblStatic.text =  "\(allmembersary[indexPath.item].flatname!)" //\(allmembersary[indexPath.item].buildingname!)-
                // cell.lblContact.text = membersary[indexPath.item].phone
                // cell.btnedit.tag = indexPath.row
                cell.btnCall.tag = indexPath.item
                
                if allmembersary[indexPath.row].image != nil{
                    //  cell.imgMember.sd_setImage(with: URL(string: webservices().imgurl + membersary[indexPath.item].image!), placeholderImage: UIImage(named: "vendor-1"))
                }
                
                cell.lblName.text = allmembersary[indexPath.item].name
                cell.lblprofession.text = allmembersary[indexPath.item].profession
                
                cell.btnCall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
                
                if(allmembersary[indexPath.row].flatType == "Renting the flat")
                {
                    
                    cell.innerview.layer.borderWidth = 1.0
                    cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                    cell.lblName.textColor = UIColor.orange
                    cell.lblStatic.textColor = UIColor.orange
                    
                }
                
                if(allmembersary[indexPath.row].flatType == "Owner of flat")
                {
                    
                    
                    cell.innerview.layer.borderWidth = 1.0
                    cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                    cell.lblName.textColor = UIColor.black
                    cell.lblStatic.textColor =  UIColor.black
                }
                
                return cell
               
            }
            
        }
        else  if(collectionView == CollectionBloodGrp)
        {
            let cell:UserCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! UserCell
            
            checkbox(cb: cell.cb)
            cell.cb.isUserInteractionEnabled = false
           // cell.lblname.text = bloodgroupary[indexPath.row]
            cell.lblname.text = (arrBloodGrp[indexPath.row] as! NSMutableDictionary).value(forKey: "blood_grp") as? String
            
//            if(selectedbloodgrop == bloodgroupary[indexPath.row])
//            {
//                cell.cb.isChecked = true
//
//            }else{
//
//                cell.cb.isChecked = false
//
//            }
            
            if((arrBloodGrp[indexPath.row] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1")
            {
                cell.cb.isChecked = true
                
            }else{
                
                cell.cb.isChecked = false
                
            }
            
            
            
            
            
            return cell
            
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! NewMemberCell
            
            cell.lblName.text = buildingary[indexPath.row].name
            if(buildingid == buildingary[indexPath.row].id)
            {
                cell.lblName.textColor = .white
                cell.lblName.backgroundColor = AppColor.appcolor
                
            }
            else
            {
                cell.lblName.textColor = .white
                cell.lblName.backgroundColor = UIColor(red:0.50, green:0.81, blue:0.89, alpha:1.0)
                
                
            }
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
    /* if(collectionView == collectionmembers)
        {

            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
               let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
               let size:CGFloat = (collectionmembers.frame.size.width - space) / 2.0
               return CGSize(width: size, height: size)
            
          /*  let numberOfSets = CGFloat(3.0)
            
            //let width = (self.view.frame.size.width - (numberOfSets * view.frame.size.width / 20))/numberOfSets
             let width = self.view.frame.size.width/2 - 20
            
            return CGSize(width:width,height: 177); */
            
        }
        else if(collectionView == CollectionBloodGrp)
        {
            let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
                 let contentNSString = bloodgroupary[indexPath.row]
                 let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15.0)], context: nil)
                 print("\(expectedLabelSize)")
                 return CGSize(width:expectedLabelSize.size.width + 50, height: expectedLabelSize.size.height + 31)
            
            
            
        }
        else
        { */
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionmembers.frame.size.width - space) / 2.0
            return CGSize(width: size, height: size)
            
           // return CGSize(width: 59, height:59)
            
      //  }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == collectionmembers)
        {
            if(searchActive == false)
            {
                if membersary[indexPath.item].member_status == 0 ||  membersary[indexPath.item].member_status == 2{
                    
                    let popup = self.storyboard?.instantiateViewController(withIdentifier: "OtherMemberPopUpVC") as! OtherMemberPopUpVC
                    popup.member = membersary[indexPath.item]
                    let navigationController = UINavigationController(rootViewController: popup)
                    navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    self.present(navigationController, animated: true)
                    
                    
                }else{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                    nextViewController.member = membersary[indexPath.item]
                    nextViewController.isfrom = 1
                    navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            else
            {
                if allmembersary[indexPath.item].member_status == 0 ||  allmembersary[indexPath.item].member_status == 2{
                    
                    let popup = self.storyboard?.instantiateViewController(withIdentifier: "OtherMemberPopUpVC") as! OtherMemberPopUpVC
                    popup.member = allmembersary[indexPath.item]
                    let navigationController = UINavigationController(rootViewController: popup)
                    navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    self.present(navigationController, animated: true)
                    
                    
                }else{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                    nextViewController.member = allmembersary[indexPath.item]
                    nextViewController.isfrom = 1
                    navigationController?.pushViewController(nextViewController, animated: true)
                }
                
            }
        }
        else if (collectionView == CollectionBloodGrp)
        {
            
            if (arrBloodGrp[indexPath.row] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "0"{
                
                let dict = arrBloodGrp[indexPath.row] as! NSMutableDictionary
                dict.setValue("1", forKey: "is_selected")
                arrBloodGrp.replaceObject(at: indexPath.row, with: dict)
                
            }else{
                
                let dict = arrBloodGrp[indexPath.row] as! NSMutableDictionary
                dict.setValue("0", forKey: "is_selected")
                arrBloodGrp.replaceObject(at: indexPath.row, with: dict)
                
            }
            
            //selectedbloodgrop = bloodgroupary[indexPath.row]
            CollectionBloodGrp.reloadData()
        }
            
        else
        {
            buildingid = buildingary[indexPath.item].id
            collectionbuildings.reloadData()
            apicallGetMembers()
            
            
        }
        
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        if collectionView == collectionbuildings{
//         let totalCellWidth = 59 * collectionView.numberOfItems(inSection: 0)
//         let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
//
//         let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//         let rightInset = leftInset
//
//         return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//        }else{
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
//    }

    
    
    
    
    @objc func callmember(sender:UIButton)
    {
        if(searchActive == false)
        {
            dialNumber(number:  membersary[sender.tag].phone)
        }
        else{
            
            dialNumber(number:  allmembersary[sender.tag].phone)
            
        }
    }
    func checkbox(cb:Checkbox)
    {
        cb.borderStyle = .circle
        cb.checkmarkStyle = .circle
        cb.uncheckedBorderColor = AppColor.appcolor
        cb.borderWidth = 1
        cb.uncheckedBorderColor = AppColor.appcolor
        cb.checkedBorderColor = AppColor.appcolor
        cb.backgroundColor = .clear
        cb.checkboxBackgroundColor = UIColor.clear
        cb.checkmarkColor = AppColor.appcolor
        
    }
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
        let strSociId  = (SociId as NSNumber).stringValue
        
        webservices().StartSpinner()
        Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, societyid:strSociId) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                var nameary = NSMutableArray()
                if(resp.status == 1)
                {
                    self.buildingary = resp.data
                    self.pickerview.reloadAllComponents()
                    if(resp.data.count > 0)
                    {
                        self.collectionbuildings.reloadData()
                        self.lblnoproperty.isHidden = true
                        //self.txtbuilding.text = resp.data[0].name
                        self.buildingid = resp.data[0].id
                        
                        // 22/8/20.
                        
                      //  self.apicallGetMembers()
                        
                    }else{
                        self.lblnoproperty.isHidden = false
                    }
                }
                    
                else
                {
                    
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
    
    
    // MARK: - get Members
    
    func apicallGetMembers()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
        let strSociId  = (SociId as NSNumber).stringValue
        
        let strToken =  UserDefaults.standard.value(forKey:USER_TOKEN)
        
        webservices().StartSpinner()
        Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST, societyid:strSociId, building_id: (self.buildingid! as! NSNumber).stringValue,token:strToken as! String) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.membersary = resp.data
                    
                    if(resp.data.count == 0)
                    {
                        self.collectionmembers.isHidden = true
                        self.viewnoresult.isHidden = false
                        
                        let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                        
                        if(str.contains("Secretory") || str.contains("Chairman"))
                        {
                            self.lblNoDataFound.isHidden = false
                        }else{
                            self.lblNoDataFound.isHidden = true
                        }
                        
                        
                    }
                    else
                    {
                        self.collectionmembers.delegate = self
                        self.collectionmembers.dataSource = self
                        self.collectionmembers.reloadData()
                        self.collectionbuildings.reloadData()
                        self.collectionmembers.isHidden = false
                        self.viewnoresult.isHidden = true
                        
                        // self.buildingid = resp.data[0].id
                        
                        
                    }
                }else if JSON.response?.statusCode == 401{
                    APPDELEGATE.ApiLogout(onCompletion: { int in
                        if int == 1{
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                            let navController = UINavigationController(rootViewController: aVC)
                            navController.isNavigationBarHidden = true
                            self.appDelegate.window!.rootViewController  = navController
                            
                        }
                    })
                    
                    return
                }
                else
                {
                    if(resp.data.count == 0)
                    {
                        self.collectionmembers.isHidden = true
                        self.viewnoresult.isHidden = false
                    }
                    else
                    {
                        self.collectionmembers.isHidden = false
                        self.viewnoresult.isHidden = true
                        
                    }
                    
                }
                
               //print(resp)
            case .failure(let err):
                webservices().StopSpinner()
                
                if JSON.response?.statusCode == 401{
                    APPDELEGATE.ApiLogout(onCompletion: { int in
                        if int == 1{
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                            let navController = UINavigationController(rootViewController: aVC)
                            navController.isNavigationBarHidden = true
                            self.appDelegate.window!.rootViewController  = navController
                            
                        }
                    })
                    
                    return
                }
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError)
                
                
            }
            
        }
        
        
        
    }
    
    func apicallGetAllMembers()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
         for i in 0..<self.arrBloodGrp.count{
            
            if (arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1"{
                self.selectedbloodgrop = ((arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "is_selected") as? String)!
                break
            }
        }
        
        
        
        let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
        let strSociId  = (SociId as NSNumber).stringValue
        
        let strToken =  UserDefaults.standard.value(forKey:USER_TOKEN)
        
        webservices().StartSpinner()
        Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST, societyid:strSociId, building_id:"0",token:strToken as! String) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    if(self.selectedbloodgrop == "")
                    {
                    self.allmembersary = resp.data
                    self.Finalallmembersary = resp.data
                        
                        self.hightcollectionbuilding.constant = 60
                        self.collectionbuildings.isHidden = false
                        
                    }
                    else
                    {
                        self.allmembersary.removeAll()
                        self.Finalallmembersary.removeAll()
                        for dic in resp.data
                        {
                            
                            for i in 0..<self.arrBloodGrp.count{
                               
                                if(dic.bloodgroup == (self.arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "blood_grp") as? String && (self.arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1")
                                {
                                    self.allmembersary.append(dic)
                                    self.Finalallmembersary.append(dic)

                                }
                                
                                
                            }
                            
                            
                      //      self.allmembersary  = self.Finalallmembersary
                        
                              
                            
                        }
                        self.collectionmembers.reloadData()
                                              self.hightcollectionbuilding.constant = 0
                                                
                                                
                                                self.collectionbuildings.isHidden = true
                    }
                    if(self.allmembersary.count == 0)
                    {
                        
                        self.lblnoproperty.isHidden = true
                        self.lblnoproperty.text  = "No Members Found"
                        
                    }
                    else
                    {
                        self.lblnoproperty.isHidden = true
                        self.lblnoproperty.text  = "No Members Found"
                        
                    }
                    
                    self.collectionmembers.reloadData()
                    
                }
                    
                else
                {
                    if(resp.data.count == 0)
                    {
                        self.collectionmembers.isHidden = true
                        self.viewnoresult.isHidden = false
                    }
                    else
                    {
                        self.collectionmembers.isHidden = false
                        self.viewnoresult.isHidden = true
                        
                    }
                    
                }
                
            case .failure(let err):
                webservices().StopSpinner()
                
                if JSON.response?.statusCode == 401{
                    APPDELEGATE.ApiLogout(onCompletion: { int in
                        if int == 1{
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                            let navController = UINavigationController(rootViewController: aVC)
                            navController.isNavigationBarHidden = true
                            self.appDelegate.window!.rootViewController  = navController
                            
                        }
                    })
                    
                    return
                }
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError)
                
                
            }
            
        }
        
        
        
    }
   
}

@available(iOS 13.0, *)
extension MembersVC : UISearchBarDelegate
{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.collectionmembers.reloadData()
        hightcollectionbuilding.constant = 0
        allmembersary  = Finalallmembersary
        self.collectionmembers.reloadData()
        self.collectionbuildings.isHidden = true
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        allmembersary  = Finalallmembersary
        self.collectionmembers.reloadData()
        hightcollectionbuilding.constant = 0
        
        
        self.collectionbuildings.isHidden = true
        
        searchBar.resignFirstResponder()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText != "")
        {
            
            allmembersary.removeAll()
            
            for dic in Finalallmembersary
            {
                var profession = ""
                if(dic.profession?.lowercased() != nil)
                {
                    profession = (dic.profession?.lowercased())!
                }
                if(dic.name.lowercased().contains(searchText.lowercased()) || (profession.contains(searchText.lowercased())))
                {
                    
                    allmembersary.append(dic)
                    
                    
                }
                if (allmembersary.count == 0){
                    // searchActive = false
                    
                    lblnoproperty.isHidden = false
                    lblnoproperty.text  = "No Members Found for \(searchText)"
                }
                else{
                    searchActive = true
                    
                    lblnoproperty.isHidden = true
                    
                }
                self.collectionmembers.reloadData()
                
            }
            
        }
        else
        {
            
            //          allmembersary  = Finalallmembersary
            //            self.collectionmembers.reloadData()
            //                            hightcollectionbuilding.constant = 0
            //
            //
            //            self.collectionbuildings.isHidden = true
            
            searchActive = false
            collectionmembers.reloadData()
            hightcollectionbuilding.constant = 60
            
            self.collectionbuildings.isHidden = false
            searchBar.resignFirstResponder()
            lblnoproperty.isHidden = true
            lblnoproperty.isHidden = true
            
            
            
            
        }
        
        
        
        
        
    }
}

