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

import Alamofire

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
class MembersVC: BaseVC , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tblMembers: UITableView!

    @IBOutlet weak var searchbar: UISearchBar!
        
    @IBOutlet weak var collectionbuildings: UICollectionView!
    
    @IBOutlet weak var lblnoproperty: UILabel!
    
    @IBOutlet weak var lblTitleName: UILabel!

    @IBOutlet weak var txtSearchbar: UITextField!

    
    @IBOutlet weak var txtbuilding: GBTextField!
    
    @IBOutlet var viewnoresult: UIView!
    
    @IBOutlet weak var btnadd: UIButton!
    
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var btnFilter: UIButton!

    var searchActive = false
    
    var buildingary = [BuildingAdd]()
    var membersary =  [Members]()
    var allmembersary =  [Members]()
    var Finalallmembersary =  [Members]()
    
    var arrProfessionList = [Profession]()

    var arrSelectionCheck = NSMutableArray()

    
    @IBOutlet weak var imgBlodUpDown: UIImageView!
    
    @IBOutlet weak var imgUpDownProfession: UIImageView!
    
    @IBOutlet weak var imgUpDownAge: UIImageView!

    
    @IBOutlet weak var btnByProfession: UIButton!
    
    @IBOutlet weak var btnByBlod: UIButton!
    
    @IBOutlet weak var btnByAge: UIButton!


    @IBOutlet weak var lblBlod: UILabel!
    
    @IBOutlet weak var lblProfession: UILabel!

    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var lblBlodShow: UILabel!
    
    @IBOutlet weak var lblProfessionShow: UILabel!

    @IBOutlet weak var lblAgeShow: UILabel!
    
    @IBOutlet weak var constraintHightlblBlodShow: NSLayoutConstraint!
       
    @IBOutlet weak var constraintHightlblProfessionShow: NSLayoutConstraint!
    
    @IBOutlet weak var constraintHightlblAgeShow: NSLayoutConstraint!

    
    var pickerview = UIPickerView()
    var buildingid:Int? = 1
    
    var isFromDash = 0
    var selectedbuilding = 0
    var selectedbloodgrop = ""
   // @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var hightcollectionbuilding: NSLayoutConstraint!
    
    @IBOutlet weak var constraintHightBLodGroupCollection: NSLayoutConstraint!
       
       @IBOutlet weak var constraintHightCollecProfession: NSLayoutConstraint!
    
    @IBOutlet weak var constraintHightAgeCollection: NSLayoutConstraint!

    
    @IBOutlet weak var filtrview: UIView!
    
    @IBOutlet weak var CollectionBloodGrp: UICollectionView!
    
    @IBOutlet weak var collectionProfession: UICollectionView!

    @IBOutlet weak var collectionAge: UICollectionView!

    
    var arrBloodGrp = NSMutableArray()
    
    var arrAge = NSMutableArray()

    
 //  @IBOutlet weak var tblview: UITableView!
    
    @IBAction func backaction(_ sender: Any) {
        
        if isFromDash == 0{
            revealViewController()?.revealToggle(self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    @IBAction func actionBlodGroup(_ sender: UIButton) {
           
           if btnByBlod.isSelected == false{
               btnByBlod.isSelected = true
            
            lblBlodShow.isHidden = false
            lblProfessionShow.isHidden = true
            lblAgeShow.isHidden = true

              lblBlod.textColor = AppColor.lblFilterSelect
              
               imgBlodUpDown.image = UIImage(named: "ic_downarrow")
            
               imgUpDownProfession.image = UIImage(named: "ic_nxt_click")
           
               imgUpDownAge.image = UIImage(named: "ic_nxt_click")

               constraintHightBLodGroupCollection.constant = 100
               constraintHightCollecProfession.constant = 0
               constraintHightAgeCollection.constant = 0
            
            constraintHightlblBlodShow.constant = 25
            constraintHightlblProfessionShow.constant = 0
            constraintHightlblAgeShow.constant = 0

           }else{
               btnByBlod.isSelected = false
            
            lblBlodShow.isHidden = true
            lblProfessionShow.isHidden = true
            lblAgeShow.isHidden = true
            
                lblBlod.textColor = AppColor.lblFilterUnselect
            
                imgBlodUpDown.image = UIImage(named: "ic_nxt_click")

               constraintHightBLodGroupCollection.constant = 0
               constraintHightCollecProfession.constant = 0
               constraintHightAgeCollection.constant = 0
            
            constraintHightlblBlodShow.constant = 0
            constraintHightlblProfessionShow.constant = 0
            constraintHightlblAgeShow.constant = 0


           }
           lblProfession.textColor = AppColor.lblFilterUnselect
            lblAge.textColor = AppColor.lblFilterUnselect
       }
    
    @IBAction func actionByProfession(_ sender: UIButton) {
        
        if btnByProfession.isSelected == false{
            btnByProfession.isSelected = true
            
            lblBlodShow.isHidden = true
            lblProfessionShow.isHidden = false
            lblAgeShow.isHidden = true
            
            lblProfession.textColor = AppColor.lblFilterSelect
            
            imgUpDownProfession.image = UIImage(named: "ic_downarrow")
            
            imgBlodUpDown.image = UIImage(named: "ic_nxt_click")
            
            imgUpDownAge.image = UIImage(named: "ic_nxt_click")

            constraintHightBLodGroupCollection.constant = 0
            constraintHightCollecProfession.constant = 100
            constraintHightAgeCollection.constant = 0
            
            constraintHightlblBlodShow.constant = 0
            constraintHightlblProfessionShow.constant = 25
            constraintHightlblAgeShow.constant = 0


        }else{
            
            btnByProfession.isSelected = false
            
            lblBlodShow.isHidden = true
            lblProfessionShow.isHidden = true
            lblAgeShow.isHidden = true
            
            lblProfession.textColor = AppColor.lblFilterUnselect
            
            imgUpDownProfession.image = UIImage(named: "ic_nxt_click")
            
            constraintHightBLodGroupCollection.constant = 0
            constraintHightCollecProfession.constant = 0
            constraintHightAgeCollection.constant = 0
            
            constraintHightlblBlodShow.constant = 0
            constraintHightlblProfessionShow.constant = 0
            constraintHightlblAgeShow.constant = 0

        }
        lblBlod.textColor = AppColor.lblFilterUnselect
        lblAge.textColor = AppColor.lblFilterUnselect
    }
    
    @IBAction func actionAge(_ sender: UIButton) {
        
        if btnByAge.isSelected == false{
            btnByAge.isSelected = true
            
            lblBlodShow.isHidden = true
            lblProfessionShow.isHidden = true
            lblAgeShow.isHidden = false
            
            lblAge.textColor = AppColor.lblFilterSelect
            
            imgUpDownAge.image = UIImage(named: "ic_downarrow")
            
            imgUpDownProfession.image = UIImage(named: "ic_nxt_click")

            imgBlodUpDown.image = UIImage(named: "ic_nxt_click")

            constraintHightBLodGroupCollection.constant = 0
            constraintHightCollecProfession.constant = 0

            constraintHightAgeCollection.constant = 100
            
            constraintHightlblBlodShow.constant = 0
            constraintHightlblProfessionShow.constant = 0
            constraintHightlblAgeShow.constant = 25
            
        }else{
            
            btnByAge.isSelected = false
            
            lblBlodShow.isHidden = true
            lblProfessionShow.isHidden = true
            lblAgeShow.isHidden = true
            
            lblAge.textColor = AppColor.lblFilterUnselect
            
            imgUpDownAge.image = UIImage(named: "ic_nxt_click")
            constraintHightBLodGroupCollection.constant = 0
            constraintHightCollecProfession.constant = 0
            constraintHightAgeCollection.constant = 0
            
            constraintHightlblBlodShow.constant = 0
            constraintHightlblProfessionShow.constant = 0
            constraintHightlblAgeShow.constant = 0

            
        }
        lblBlod.textColor = AppColor.lblFilterUnselect
        lblProfession.textColor = AppColor.lblFilterUnselect
    }
    
    @IBAction func btn_close_filter(_ sender: UIButton) {
        
        constraintHightBLodGroupCollection.constant = 0
        constraintHightCollecProfession.constant = 0
        constraintHightAgeCollection.constant = 0
        
        constraintHightlblBlodShow.constant = 0
        constraintHightlblProfessionShow.constant = 0
        constraintHightlblAgeShow.constant = 0
        
        btnFilter.setImage(UIImage(named: "ic_filter"), for: .normal)
        btnFilter.isSelected = false

               imgUpDownProfession.image = UIImage(named: "ic_nxt_click")
               imgBlodUpDown.image = UIImage(named: "ic_nxt_click")
        imgUpDownAge.image = UIImage(named: "ic_nxt_click")

               arrBloodGrp.removeAllObjects()
               arrSelectionCheck.removeAllObjects()
               
        arrAge.removeAllObjects()

        clearlbl()

        filtrview.isHidden = true

        setUpView()
        selectedbloodgrop = ""
        
        setUpAgeView()
        searchActive = false
        
    }

    
    @IBAction func filteraction(_ sender: Any) {
       
        self.viewnoresult.isHidden = true
        setView(view: filtrview, hidden: false)
        
        clearlbl()
        
// 31/10/20. temp comment
     //   searchbar.text = ""
        
        apicallGetAllMembers()

        
        if btnFilter.isSelected == false {
            btnFilter.setImage(UIImage(named: "ic_filter_select"), for: .normal)
            btnFilter.isSelected = true
        }else{
            btnFilter.setImage(UIImage(named: "ic_filter"), for: .normal)
            btnFilter.isSelected = false
            setView(view: filtrview, hidden: true)
        }
        
        self.view.endEditing(true)

    }
    
    @IBAction func applyfilteraction(_ sender: Any) {
       
        constraintHightBLodGroupCollection.constant = 0
        constraintHightCollecProfession.constant = 0
        constraintHightAgeCollection.constant = 0

        constraintHightlblBlodShow.constant = 0
        constraintHightlblProfessionShow.constant = 0
        constraintHightlblAgeShow.constant = 0
        
      imgUpDownProfession.image = UIImage(named: "ic_nxt_click")
      imgBlodUpDown.image = UIImage(named: "ic_nxt_click")
        imgUpDownAge.image = UIImage(named: "ic_nxt_click")

        btnFilter.setImage(UIImage(named: "ic_filter"), for: .normal)
        btnFilter.isSelected = false
        clearlbl()

        filtrview.isHidden = false
       // self.collectionmembers.reloadData()
                
        self.tblMembers.reloadData()

       // hightcollectionbuilding.constant = 0
        self.collectionbuildings.isHidden = true
            
        setView(view: filtrview, hidden: true)

        apicallGetAllMembers()
        self.searchActive = true
        
     
        
    }
    
    func clearlbl() {
    
        lblBlod.textColor = AppColor.lblFilterUnselect
        lblProfession.textColor = AppColor.lblFilterUnselect
        lblAge.textColor = AppColor.lblFilterUnselect
        
        lblBlodShow.isHidden = true
        lblProfessionShow.isHidden = true
        lblAgeShow.isHidden = true

    }
    
    @IBAction func clearaction(_ sender: Any) {
    //    arrBloodGrp.removeAllObjects()
//        for i in 0..<bloodgroupary.count{
//            arrTemp.add("0")
//        }
        
        constraintHightBLodGroupCollection.constant = 0
        constraintHightCollecProfession.constant = 0
        constraintHightAgeCollection.constant = 0
        
        constraintHightlblBlodShow.constant = 0
        constraintHightlblProfessionShow.constant = 0
        constraintHightlblAgeShow.constant = 0

        btnFilter.setImage(UIImage(named: "ic_filter"), for: .normal)
        btnFilter.isSelected = false
               imgUpDownProfession.image = UIImage(named: "ic_nxt_click")
               imgBlodUpDown.image = UIImage(named: "ic_nxt_click")
        imgUpDownAge.image = UIImage(named: "ic_nxt_click")

               arrBloodGrp.removeAllObjects()
               arrSelectionCheck.removeAllObjects()
               
        arrAge.removeAllObjects()
        
        filtrview.isHidden = true
        
        clearlbl()
        setUpView()
        selectedbloodgrop = ""
        setUpAgeView()

        searchActive = false

    }
    
    
    var bloodgroupary = [BloodGroup]()
       // ["A+","A-","B+","B-","AB+","AB-","O+","O-"]
    
    var agegroupary = ["0-10 Age","10-20 Age","20-30 Age","30-40 Age","40-50 Age","60-70 Age","Above 70 Age"]
    
  

    var arrTemp = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 0..<bloodgroupary.count{
//            arrTemp.add("0")
//        }
        
        lblTitleName.text = "Community Residents"
        
        setUpView()
        setUpAgeView()

        btnFilter.setImage(UIImage(named: "ic_filter"), for: .normal)
        btnFilter.isSelected = false
        
        // 22/8/20.
        
        apicallGetAllMembers()
        apicallGetBuildings()
        
        ApiCallGetProfession()
        
        ApiCallGetBlood()

        webservices.sharedInstance.setShadow(view: filtrview)
        setView(view: filtrview, hidden: true)
        
        
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
        
        tblMembers.register(UINib(nibName: "MembersCell", bundle: nil), forCellReuseIdentifier: "MembersCell")
        
        tblMembers.separatorStyle = .none
        
        tblMembers.isHidden = true

        lblBlodShow.isHidden = true
        lblProfessionShow.isHidden = true
        lblAgeShow.isHidden = true
        
        lblBlodShow.font = UIFont(name: "Gotham-Book", size: 16)
        lblProfessionShow.font = UIFont(name: "Gotham-Book", size: 16)
        lblAgeShow.font = UIFont(name: "Gotham-Book", size: 16)

        
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
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                verticalAlignment: .center)
        
        collectionProfession.collectionViewLayout = alignedFlowLayout
        
        
        let alignedFlowLayout1 = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                 verticalAlignment: .center)
        
        CollectionBloodGrp.collectionViewLayout = alignedFlowLayout1
        
        let alignedFlowLayout2 = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                        verticalAlignment: .center)
               
       collectionAge.collectionViewLayout = alignedFlowLayout2
               
        txtSearchbar.layer.borderColor = UIColor.clear.cgColor
        
        txtSearchbar.borderStyle = .none


        // 30/10/20.
        
       /* if let textfield = searchbar.value(forKey: "searchField") as? UITextField {
            textfield.frame = CGRect(x: 0, y: 0, width: searchbar.frame.size.width, height: searchbar.frame.size.height)
            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "Search by name or profession", attributes: [NSAttributedStringKey.foregroundColor : AppColor.lblFilterUnselect])
            
            textfield.layer.cornerRadius = 10.0
            textfield.layer.borderWidth = 1.0
            textfield.layer.borderColor = AppColor.txtbgColor.cgColor

            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = AppColor.lblFilterSelect
            }

        } */
        
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
        
        
        constraintHightCollecProfession.constant = 0
        constraintHightBLodGroupCollection.constant = 0
        constraintHightAgeCollection.constant = 0
        
        constraintHightlblBlodShow.constant = 0
        constraintHightlblProfessionShow.constant = 0
        constraintHightlblAgeShow.constant = 0

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
    
    func setUpAgeView() {
        
        
        constraintHightCollecProfession.constant = 0
        constraintHightBLodGroupCollection.constant = 0
        constraintHightAgeCollection.constant = 0
        
        constraintHightlblBlodShow.constant = 0
        constraintHightlblProfessionShow.constant = 0
        constraintHightlblAgeShow.constant = 0

        let dict = NSMutableDictionary()
        dict.setValue("0-10 Age", forKey: "age_grp")
        dict.setValue("0", forKey: "is_selected")
        arrAge.add(dict)
        
        let dict1 = NSMutableDictionary()
        dict1.setValue("10-20 Age", forKey: "age_grp")
        dict1.setValue("0", forKey: "is_selected")
        arrAge.add(dict1)
        
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("20-30 Age", forKey: "age_grp")
        dict2.setValue("0", forKey: "is_selected")
        arrAge.add(dict2)
        
        
        let dict3 = NSMutableDictionary()
        dict3.setValue("30-40 Age", forKey: "age_grp")
        dict3.setValue("0", forKey: "is_selected")
        arrAge.add(dict3)
        
        let dict4 = NSMutableDictionary()
        dict4.setValue("40-50 Age", forKey: "age_grp")
        dict4.setValue("0", forKey: "is_selected")
        arrAge.add(dict4)
        
        let dict5 = NSMutableDictionary()
        dict5.setValue("60-70 Age", forKey: "age_grp")
        dict5.setValue("0", forKey: "is_selected")
        arrAge.add(dict5)
        
        let dict6 = NSMutableDictionary()
        dict6.setValue("Above 70 Age", forKey: "age_grp")
        dict6.setValue("0", forKey: "is_selected")
        arrAge.add(dict6)
        
        
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
                nextViewController.isFrormDashboard = 1
               // nextViewController.isfrom = 0

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
    
    @IBAction func btnOpenQRCodePressed(_ sender: Any) {
        let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
        vc.isfrom = 0
    }
    
    // MARK: - get Blood
       
       func ApiCallGetBlood()
       {
             if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
               webservices().StartSpinner()
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        print("token : ",token as! String)

        Apicallhandler().ApiCallGetBlood(URL: webservices().baseurl + "communei/blood-groups", token: token as! String) { JSON in
           
                   switch JSON.result{
                   case .success(let resp):
                       
                       webservices().StopSpinner()
                       if(JSON.response?.statusCode == 200)
                       {
                           
                           self.bloodgroupary = resp.data
                           
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
                    print(err.asAFError!)
                       webservices().StopSpinner()
                       
                   }
                   
               }
               
           
       }
    
    // MARK: - get Professsion
    
    func ApiCallGetProfession()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        // webservices().StartSpinner()
       // Apicallhandler().ApiGetProfession(URL: webservices().baseurl + "communei/professions") { JSON in
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        print("token : ",token as! String)

        Apicallhandler().ApiGetProfession(URL: webservices().baseurl + "communei/professions", token: token as! String) { JSON in
           
            switch JSON.result{
            case .success(let resp):
                
                // webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.arrProfessionList = resp.data
                    
                    if self.arrProfessionList.count > 0{
                        self.collectionProfession.dataSource = self
                        self.collectionProfession.delegate = self
                        self.collectionProfession.reloadData()
                        
                    }else{
                        
                    }
                    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(buildingary.count == 0)
        {
            textField.resignFirstResponder()
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No Buildings Found")
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == CollectionBloodGrp)
        {
            //return bloodgroupary.count
            return arrBloodGrp.count
            
        } else if(collectionView == collectionProfession)
        {
            //return bloodgroupary.count
            return arrProfessionList.count
            
        } else if(collectionView == collectionAge)
        {
            // return agegroupary.count
            return arrAge.count
        }
        else
        {
            return buildingary.count
            
        }
        
      
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        if(collectionView == CollectionBloodGrp)
        {
            let cell:UserCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! UserCell
            
           // checkbox(cb: cell.cb)
          //  cell.cb.isUserInteractionEnabled = false
            
           // cell.lblname.text = bloodgroupary[indexPath.row]
          //  cell.lblname.text = (arrBloodGrp[indexPath.row] as! NSMutableDictionary).value(forKey: "blood_grp") as? String
            
            cell.lblname.text = (arrBloodGrp[indexPath.row] as! NSMutableDictionary).value(forKey: "blood_grp") as? String

            
            //
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
                cell.bgViw.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 1/255, alpha: 1.0)

            }else{
                cell.bgViw.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
            }
            
            
            return cell
            
        }
        else if(collectionView == collectionProfession) {
            let cell:UserCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! UserCell
            
          //  checkbox(cb: cell.cb)
           // cell.cb.isUserInteractionEnabled = false
            // cell.lblname.text = bloodgroupary[indexPath.row]
            cell.lblname.text = arrProfessionList[indexPath.row].name
            
            if(arrSelectionCheck.contains(arrProfessionList[indexPath.row].name))
            {
                cell.bgViw.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 1/255, alpha: 1.0)
            }else{
                cell.bgViw.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
            }
            
            
            return cell
            
            
        }
        else if(collectionView == collectionAge)
                {
                    let cell:UserCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! UserCell
                    
                   // checkbox(cb: cell.cb)
                  //  cell.cb.isUserInteractionEnabled = false
                    
                   // cell.lblname.text = bloodgroupary[indexPath.row]
                  //  cell.lblname.text = (arrBloodGrp[indexPath.row] as! NSMutableDictionary).value(forKey: "blood_grp") as? String
                    
                    cell.lblname.text = (arrAge[indexPath.row] as! NSMutableDictionary).value(forKey: "age_grp") as? String

                    
                    //
        //            if(selectedbloodgrop == bloodgroupary[indexPath.row])
        //            {
        //                cell.cb.isChecked = true
        //
        //            }else{
        //
        //                cell.cb.isChecked = false
        //
        //            }
                    
                    if((arrAge[indexPath.row] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1")
                    {
                        cell.bgViw.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 1/255, alpha: 1.0)

                    }else{
                        cell.bgViw.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
                    }
                    
                    
                    return cell
                    
                }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! NewMemberCell
            
            cell.layer.shadowColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.16).cgColor
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 1.0
            cell.layer.shadowOffset = CGSize(width:0, height: 1)

            cell.lblName.text = buildingary[indexPath.row].propertyFullName
            if(buildingid == buildingary[indexPath.row].propertyID)
            {
              //  cell.lblName.textColor = .white
             //   cell.lblName.backgroundColor = AppColor.appcolor
                
            }
            else
            {
              //  cell.lblName.textColor = .white
             //   cell.lblName.backgroundColor = UIColor(red:0.50, green:0.81, blue:0.89, alpha:1.0)
                
                
            }
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
    
         if(collectionView == collectionProfession)
        {
            let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
            let contentNSString = arrProfessionList[indexPath.row].name
            let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15.0)], context: nil)

            print("\(expectedLabelSize)")
            
            print("collectionProfession expectedLabelSize height :- \(expectedLabelSize.size.height) expectedLabelSize 12 height  :- \(expectedLabelSize.size.height + 12) expectedLabelSize width :- \(expectedLabelSize.size.width) expectedLabelSize 35 width :- \(expectedLabelSize.size.width + 35)")

            return CGSize(width:expectedLabelSize.size.width + 35, height: expectedLabelSize.size.height + 12)
            
        }
        else if(collectionView == CollectionBloodGrp)
        {
          /*  let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
            let contentNSString = bloodgroupary[indexPath.row]
            let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:14.0)], context: nil)
            
            print("expectedLabelSize :- \(expectedLabelSize)")
            
            print("CollectionBloodGrp expectedLabelSize height :- \(expectedLabelSize.size.height) expectedLabelSize 12 height  :- \(expectedLabelSize.size.height + 12) expectedLabelSize width :- \(expectedLabelSize.size.width) expectedLabelSize 35 width :- \(expectedLabelSize.size.width + 25)")

            return CGSize(width:expectedLabelSize.size.width + 25, height: expectedLabelSize.size.height + 12) //31 */
            
            let numberOfSets = CGFloat(4.0)
             
             let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 45))/numberOfSets
             
             return CGSize(width:width,height: 31)
            
        }
            else if(collectionView == collectionAge)
            {
                let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
                let contentNSString = agegroupary[indexPath.row]
                let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15.0)], context: nil)
                
                print("\(expectedLabelSize)")
                
                print("collectionAge expectedLabelSize height :- \(expectedLabelSize.size.height) expectedLabelSize 12 height  :- \(expectedLabelSize.size.height + 12) expectedLabelSize width :- \(expectedLabelSize.size.width) expectedLabelSize 25 width :- \(expectedLabelSize.size.width + 25)")

                return CGSize(width:expectedLabelSize.size.width + 25, height: expectedLabelSize.size.height + 12) //31
                
            }
         else {
        
            let collectionViewWidth = self.view.bounds.width - 10
                
            return CGSize(width: collectionViewWidth/2 - 2, height: collectionViewWidth/2 + 2)
            
           // return CGSize(width: 59, height:59)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == collectionbuildings) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MembersDetailsVC") as! MembersDetailsVC
            
            buildingid = buildingary[indexPath.item].propertyID

            nextViewController.buildingid = buildingid
            
            let str = "Resident of \(buildingary[indexPath.row].propertyFullName)"
            
          //  lblTitleName.text = "Resident of \(buildingary[indexPath.row].name)"
            
            nextViewController.strlbl = str // lblTitleName.text!
          //  nextViewController.guestdic = object
            nextViewController.isFromDash = 1
            navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        else if (collectionView == CollectionBloodGrp)
        {
            arrSelectionCheck.removeAllObjects()
            collectionProfession.reloadData()
            
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
        else if collectionView == collectionProfession{
            
            for i in 0..<self.arrBloodGrp.count{
                           if (arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1"{
                               let dict = arrBloodGrp[i] as! NSMutableDictionary
                               dict.setValue("0", forKey: "is_selected")
                               arrBloodGrp.replaceObject(at: i, with: dict)
                           }
                       }
                       CollectionBloodGrp.reloadData()
            
            if arrSelectionCheck.contains(arrProfessionList[indexPath.row].name){
                arrSelectionCheck.remove(arrProfessionList[indexPath.row].name)
            }else{
                arrSelectionCheck.add(arrProfessionList[indexPath.row].name)
            }
            collectionProfession.reloadData()
        }
         
            else if (collectionView == collectionAge)
            {
                arrSelectionCheck.removeAllObjects()
               // collectionProfession.reloadData()
                
                if (arrAge[indexPath.row] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "0"{
                    
                    let dict = arrAge[indexPath.row] as! NSMutableDictionary
                    dict.setValue("1", forKey: "is_selected")
                    arrAge.replaceObject(at: indexPath.row, with: dict)
                    
                }else{
                    
                    let dict = arrAge[indexPath.row] as! NSMutableDictionary
                    dict.setValue("0", forKey: "is_selected")
                    arrAge.replaceObject(at: indexPath.row, with: dict)
                    
                }
                
                //selectedbloodgrop = bloodgroupary[indexPath.row]
                collectionAge.reloadData()
            }
        else
        {
            buildingid = buildingary[indexPath.item].propertyID
            
           // lblTitleName.text = "Resident of \(buildingary[indexPath.row].name)"

            // 3/9/20.
            
           // collectionbuildings.reloadData()
            tblMembers.reloadData()
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

    
    // 2/9/20.
    

    
    
     //MARK:- tableview delegate
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           // if(tableView == tblMembers)
          //  {
                if(searchActive == false)
                {
                    return membersary.count
                }
                else
                {
                    return allmembersary.count
                    
                }
           // }
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                    if(searchActive == false)
                    {
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "MembersCell") as! MembersCell

                      //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! NewMemberCell
                        
                        if membersary[indexPath.item].memberStatus == 0 ||  membersary[indexPath.item].memberStatus == 2{
                            //  cell.lblContact.isHidden = true
                            cell.btnCall.isHidden = true
                            // cell.lblStatic.isHidden = true
                            
                        }else{
                            // cell.lblContact.isHidden = false
                            cell.btnCall.isHidden = false
                            //  cell.lblStatic.isHidden = false
                            
                        }
                        
                        webservices().setShadow(view: cell.innerview)
                        
                            //   print("------->>>>\(membersary[indexPath.item].name), \(membersary[indexPath.item].buildingname!)-\(membersary[indexPath.item].flatname!)")
                        
                        if membersary[indexPath.item].userTypeName == nil {
                                    cell.lblSelfs.text = ""
                        }else{
                            cell.lblSelfs.text = "\(membersary[indexPath.item].userTypeName!)"
                        }
                        

                        
                        cell.lblStatic.text =   "\(membersary[indexPath.item].society?.parentProperty! ?? "") - \(membersary[indexPath.item].society?.property! ?? "")"
                        
                      //  cell.lblStatic.text =  "\(membersary[indexPath.item].flatname!)" //\(membersary[indexPath.item].buildingname!)-
                        // cell.lblContact.text = membersary[indexPath.item].phone
                        // cell.btnedit.tag = indexPath.row
                        cell.btnCall.tag = indexPath.item
                        
                        if membersary[indexPath.row].profilePhotoPath != nil{
                              cell.imgMember.sd_setImage(with: URL(string: membersary[indexPath.item].profilePhotoPath!), placeholderImage: UIImage(named: "vendor-1"))
                        }
                        
                        cell.lblName.text = membersary[indexPath.item].name
                        cell.lblprofession.text = membersary[indexPath.item].professionName
                        cell.btnCall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
                        
                        if membersary[indexPath.item].bloodGroupName != nil{
                            cell.lblBloodGroup.isHidden = false
                           // cell.lblBloodGroup.text = String(format: "Blood Group: %@", membersary[indexPath.item].bloodgroup!)//"Blood Group: \(membersary[indexPath.item].bloodgroup!)"
                            cell.lblBloodGroupName.isHidden = false

                            cell.lblBloodGroupName.text = membersary[indexPath.item].bloodGroupName!
                            }else{
                            cell.lblBloodGroup.isHidden = true
                            cell.lblBloodGroupName.isHidden = true

                        }
                        
                        
                     /*   if(membersary[indexPath.row].flatType == "Renting the flat")
                        {
                            
                           // cell.innerview.layer.borderWidth = 1.0
                          //  cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                            cell.lblName.textColor = UIColor.orange
                            cell.lblStatic.textColor = UIColor.orange
                            
                            
                        }
                        
                        if(membersary[indexPath.row].flatType == "Owner of flat")
                        {
                            
                          //  cell.innerview.layer.borderWidth = 1.0
                         //   cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                            cell.lblName.textColor = UIColor.black
                            cell.lblStatic.textColor =  UIColor.black
                            
                        } */
                        
                        
                        return cell
                    }
                    else
                    {
                       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! NewMemberCell
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "MembersCell") as! MembersCell

                        
                        if allmembersary[indexPath.item].memberStatus == 0 ||  allmembersary[indexPath.item].memberStatus == 2{
                            //  cell.lblContact.isHidden = true
                            cell.btnCall.isHidden = true
                            // cell.lblStatic.isHidden = true
                            
                        }else{
                            // cell.lblContact.isHidden = false
                            cell.btnCall.isHidden = false
                            //  cell.lblStatic.isHidden = false
                            
                        }
                        
                        if allmembersary[indexPath.item].bloodGroupName != nil{
                                          cell.lblBloodGroup.isHidden = false
                                         // cell.lblBloodGroup.text = String(format: "Blood Group: %@", allmembersary[indexPath.item].bloodgroup!)
                            
                            cell.lblBloodGroupName.isHidden = false

                            cell.lblBloodGroupName.text = allmembersary[indexPath.item].bloodGroupName!
                                       }else{
                                           cell.lblBloodGroup.isHidden = true
                                            cell.lblBloodGroupName.isHidden = true

                                       }
                        
                        
                        webservices().setShadow(view: cell.innerview)
                        
                      //  print("------->>>>\(allmembersary[indexPath.item].name), \(allmembersary[indexPath.item].buildingname!)-\(allmembersary[indexPath.item].flatname!)") //-\(allmembersary[indexPath.item].flatType!)")
                        
                        if allmembersary[indexPath.item].userTypeName == nil {
                                                          cell.lblSelfs.text = ""
                                              }else{
                                                  cell.lblSelfs.text = "\(allmembersary[indexPath.item].userTypeName!)"
                                              }
                                                
                        cell.lblStatic.text =   "\(allmembersary[indexPath.item].society?.parentProperty! ?? "") - \(allmembersary[indexPath.item].society?.property! ?? "")"

                      //  cell.lblStatic.text =  "\(allmembersary[indexPath.item].flatname!)" //\(allmembersary[indexPath.item].buildingname!)-
                        // cell.lblContact.text = membersary[indexPath.item].phone
                        // cell.btnedit.tag = indexPath.row
                        cell.btnCall.tag = indexPath.item
                        
                        if allmembersary[indexPath.row].profilePhotoPath != nil{
                            // 3/9/20.
                              cell.imgMember.sd_setImage(with: URL(string: allmembersary[indexPath.item].profilePhotoPath!), placeholderImage: UIImage(named: "vendor profile"))
                        }
                        
                        cell.lblName.text = allmembersary[indexPath.item].name
                        cell.lblprofession.text = allmembersary[indexPath.item].professionName
                        
                        cell.btnCall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
                        
                        // 3/9/20.
                      /*  if(allmembersary[indexPath.row].flatType == "Renting the flat")
                        {
                            
                          //  cell.innerview.layer.borderWidth = 1.0
                          //  cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                            cell.lblName.textColor = UIColor.orange
                            cell.lblStatic.textColor = UIColor.orange
                            
                        }
                        
                        if(allmembersary[indexPath.row].flatType == "Owner of flat")
                        {
                            
                            
                           // cell.innerview.layer.borderWidth = 1.0
                          //  cell.innerview.layer.borderColor = AppColor.appcolor.cgColor
                            cell.lblName.textColor = UIColor.black
                            cell.lblStatic.textColor =  UIColor.black
                        } */
                        
                        return cell
                       
                    }
                    
                
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
              if tableView == tblMembers{
                
                print("dfvf")
                
                    if(searchActive == false)
                    {
                        if membersary[indexPath.item].memberStatus == 0 ||  membersary[indexPath.item].memberStatus == 2{
                            
                            let popup = self.storyboard?.instantiateViewController(withIdentifier: "OtherMemberPopUpVC") as! OtherMemberPopUpVC
                            popup.member = membersary[indexPath.item]
                            let navigationController = UINavigationController(rootViewController: popup)
                            navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            self.present(navigationController, animated: true)
                            
                            
                        }else{
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                            nextViewController.member = membersary//[indexPath.item]
                            
                            nextViewController.indexMember = indexPath.item

                            nextViewController.isfrom = 1
                            navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }
                    else
                    {
                        if allmembersary[indexPath.item].memberStatus == 0 ||  allmembersary[indexPath.item].memberStatus == 2{
                            
                            let popup = self.storyboard?.instantiateViewController(withIdentifier: "OtherMemberPopUpVC") as! OtherMemberPopUpVC
                            popup.member = allmembersary[indexPath.item]
                            let navigationController = UINavigationController(rootViewController: popup)
                            navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            self.present(navigationController, animated: true)
                            
                            
                        }else{
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                            nextViewController.member = allmembersary//[indexPath.item]
                            nextViewController.indexMember = indexPath.item

                            nextViewController.isfrom = 1
                            navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        
                    }
                
                
              //  let vc = self.storyboard?.instantiateViewController(withIdentifier: "AmenitiesClenderBookVC") as! AmenitiesClenderBookVC
               // self.present(vc, animated: true, completion: nil)
            }
            
        }
        
//        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//           // return UITableViewAutomaticDimension
//
//            return tableView.estimatedRowHeight
//
//            // return 190
//       }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableViewAutomaticDimension
           // return 150
        }
    
    
    
    ////////////////////////////////// //////////
    
    
    @objc func callmember(sender:UIButton)
    {
        
       // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                          
        if(searchActive == false)
        {
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                       avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
                                       avc?.subtitleStr = "Are you sure you want to call: \(membersary[sender.tag].phone)"
            avc?.isfrom = 3

                                       avc?.yesAct = {
                                         self.dialNumber(number:  self.membersary[sender.tag].phone!)

                                                }
            
                                       avc?.noAct = {
                                         
                                       }
                                       present(avc!, animated: true)
            
        }
        else{
            
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                       avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
                                       avc?.subtitleStr = "Are you sure you want to call: \(allmembersary[sender.tag].phone)"
            avc?.isfrom = 3

                                       avc?.yesAct = {
                                        
                                        self.dialNumber(number:  self.allmembersary[sender.tag].phone!)

                                                }
            
                                       avc?.noAct = {
                                         
                                       }
                                       present(avc!, animated: true)
            
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
      //  let strSociId  = (SociId as NSNumber).stringValue
        
        webservices().StartSpinner()
       // Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, societyid:strSociId) { JSON in
            
          //  let secret = UserDefaults.standard.string(forKey: USER_SECRET)
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)

             let param : Parameters = [
                 "Society" : SociId,
               // "Parent" : UsermeResponse!.data!.society!.societyID!
             ]
            
           print("Parameters : ",param)
                    
         //   Apicallhandler.sharedInstance.GetAllBuidldingSociety(URL: webservices().baseurl + API_GET_BUILDING_SOCIETY,token: token as! String, param: param) { JSON in
                
        Apicallhandler.sharedInstance.GetAllBuidldingSociety(token: token as! String, param: param) { JSON in
            
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
              //  var nameary = NSMutableArray()
                if(resp.status == 1)
                {
                    
                    self.buildingary = resp.data
                    
                    self.pickerview.reloadAllComponents()
                     
                    // 27/10/20. temp comment
                    
                    if(resp.data.count > 0)
                    {
                        self.collectionbuildings.reloadData()
                        self.lblnoproperty.isHidden = true
                        //self.txtbuilding.text = resp.data[0].name
                        self.buildingid = resp.data[0].propertyID
                        
                        self.viewnoresult.isHidden = true
                        
                        // 22/8/20.
                        
                      //  self.apicallGetMembers()
                        
                    }else{
                        self.lblnoproperty.isHidden = false
                        
                        self.viewnoresult.isHidden = false

                    }
                }
                    
                else
                {
                    
                }
                
                print("resp buildingary : ",resp)
            case .failure(let err):
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError ?? "")
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
        let building_id =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
       // let strSociId  = (building_id as NSNumber).stringValue
        
        let id = String(format: "%d",building_id)

        
        let strToken =  UserDefaults.standard.value(forKey:USER_TOKEN)
        
        webservices().StartSpinner()
        
       // Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST, societyid:strSociId, building_id: (self.buildingid! as! NSNumber).stringValue,token:strToken as! String) { JSON in
            
            Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST + id,token:strToken as! String) { JSON in

            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.membersary = resp.data!
                    
                    if(resp.data!.count == 0)
                    {
                       // self.collectionmembers.isHidden = true
                        
                        self.tblMembers.isHidden = true
                        
                        self.collectionbuildings.isHidden = true
                        
                        self.viewnoresult.isHidden = false
                        
                        let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                        
                        if(str.contains("Secretory") || str.contains("Chairman"))
                        {
                           // self.lblNoDataFound.isHidden = false
                        }else{
                          //  self.lblNoDataFound.isHidden = true
                        }
                        
                        
                    }
                    else
                    {
//                        self.collectionmembers.delegate = self
//                        self.collectionmembers.dataSource = self
//                        self.collectionmembers.reloadData()
                       self.collectionbuildings.reloadData()
//                        self.collectionmembers.isHidden = false
                        
                        self.tblMembers.delegate = self
                        self.tblMembers.dataSource = self
                        self.tblMembers.reloadData()
                        self.tblMembers.isHidden = false
                        
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
                    if(resp.data!.count == 0)
                    {
                       // self.collectionmembers.isHidden = true
                        
                        self.tblMembers.isHidden = true

                        self.viewnoresult.isHidden = false
                    }
                    else
                    {
                        //self.collectionmembers.isHidden = false
                        
                        self.tblMembers.isHidden = false

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
        
        
        
        let building_id =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
      //  let strSociId  = (building_id as NSNumber).stringValue
        
        let id = String(format: "%d",building_id)

        
        let strToken =  UserDefaults.standard.value(forKey:USER_TOKEN)
        
        webservices().StartSpinner()
      
        //Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST, societyid:strSociId, building_id:"0",token:strToken as! String) { JSON in
        
        Apicallhandler().GetAllMembers(URL: webservices().baseurl + API_MEMBER_LIST + id ,token:strToken as! String) { JSON in

            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    if(self.selectedbloodgrop == "" && self.arrSelectionCheck.count == 0)
                    {
                        self.allmembersary = resp.data!
                        self.Finalallmembersary = resp.data!
                        
                      //  self.hightcollectionbuilding.constant = 60
                        self.collectionbuildings.isHidden = false
                        
                    }
                    else
                    {
                        self.allmembersary.removeAll()
                        self.Finalallmembersary.removeAll()
                        for dic in resp.data!
                        {
                            
                            if self.selectedbloodgrop != ""{
                                for i in 0..<self.arrBloodGrp.count{
                                    
                                    if(dic.bloodGroupName == (self.arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "blood_grp") as? String && (self.arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1")
                                    {
                                        self.allmembersary.append(dic)
                                        self.Finalallmembersary.append(dic)
                                        
                                    }
                                }
                            }
                            
                            
                            //for profession
                            
                            if self.arrSelectionCheck.count > 0{
                                if dic.professionName != nil {
                                    if(self.arrSelectionCheck.contains(dic.professionName!))
                                    {
                                        self.allmembersary.append(dic)
                                        self.Finalallmembersary.append(dic)
                                    }
                                }
                                
                            }
                            
                            
                            //      self.allmembersary  = self.Finalallmembersary
                            
                            
                            
                        }
                        
                        if(self.allmembersary.count == 0)
                        {
                            self.lblnoproperty.isHidden = false
                            self.lblnoproperty.text  = "No Members Found"
                            
                        }
                        else
                        {
                            self.lblnoproperty.isHidden = true
                            self.lblnoproperty.text  = "No Members Found"
                            
                        }
                        
                        self.tblMembers.isHidden = false

                        self.tblMembers.reloadData()
                     //   self.hightcollectionbuilding.constant = 0
                        
                        
                        self.collectionbuildings.isHidden = true
                    }
                  
                    
                }
                    
                else
                {
                    if(resp.data!.count == 0)
                    {
                        self.tblMembers.isHidden = true
                        self.viewnoresult.isHidden = false
                    }
                    else
                    {
                        self.tblMembers.isHidden = false
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
                print(err.asAFError!)
                
                
            }
            
        }
        
        
        
    }
   
}

@available(iOS 13.0, *)
extension MembersVC : UISearchBarDelegate
{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        constraintHightBLodGroupCollection.constant = 0
        constraintHightCollecProfession.constant = 0
        constraintHightAgeCollection.constant = 0
        
        constraintHightlblBlodShow.constant = 0
        constraintHightlblProfessionShow.constant = 0
        constraintHightlblAgeShow.constant = 0

               imgUpDownProfession.image = UIImage(named: "ic_nxt_click")
               imgBlodUpDown.image = UIImage(named: "ic_nxt_click")
               
        imgUpDownAge.image = UIImage(named: "ic_nxt_click")

               arrSelectionCheck.removeAllObjects()
               collectionProfession.reloadData()
        
               
                
               
               for i in 0..<self.arrBloodGrp.count{
                   if (arrBloodGrp[i] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1"{
                       let dict = arrBloodGrp[i] as! NSMutableDictionary
                       dict.setValue("0", forKey: "is_selected")
                       arrBloodGrp.replaceObject(at: i, with: dict)
                   }
               }
               ////
        
              
            CollectionBloodGrp.reloadData()
        
        self.collectionbuildings.isHidden = false
        self.collectionbuildings.reloadData()
        
        
        searchActive = true
//        self.collectionmembers.reloadData()
//        hightcollectionbuilding.constant = 0
//        allmembersary  = Finalallmembersary
//        self.collectionmembers.reloadData()
//        self.collectionbuildings.isHidden = true
        
       // self.tblMembers.reloadData()
            //   hightcollectionbuilding.constant = 0
               allmembersary  = Finalallmembersary
        
               self.tblMembers.reloadData()
            //   self.collectionbuildings.isHidden = true
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        //searchActive = false
       // searchBar.becomeFirstResponder()

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        allmembersary  = Finalallmembersary
       // self.collectionmembers.reloadData()
        
        self.tblMembers.reloadData()

     //   hightcollectionbuilding.constant = 0
        
        
        self.collectionbuildings.isHidden = true
        
       // searchBar.resignFirstResponder()
       
        searchBar.becomeFirstResponder()

        
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
                if(dic.professionName?.lowercased() != nil)
                {
                    profession = (dic.professionName?.lowercased())!
                }
                if(dic.name!.lowercased().contains(searchText.lowercased()) || (profession.contains(searchText.lowercased())))
                {
                    
                    allmembersary.append(dic)
                    
                    
                }
                if (allmembersary.count == 0){
                    // searchActive = false
                    
                    lblnoproperty.isHidden = false
                    
                    lblnoproperty.text  = "Member List is empty \(searchText)"
                }
                else{
                    searchActive = true
                    
                    lblnoproperty.isHidden = true
                    
                }
                
                self.tblMembers.isHidden = false

                self.tblMembers.reloadData()
                
                self.collectionbuildings.isHidden = true

              //  self.collectionmembers.reloadData()
                
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
            
           // collectionmembers.reloadData()

            // 6/10/20.
            
            // tblMembers.reloadData()  //
            
          //  hightcollectionbuilding.constant = 60
            
            tblMembers.isHidden = true

            apicallGetBuildings()
            

            self.collectionbuildings.isHidden = false
            self.collectionbuildings.reloadData()

            searchBar.resignFirstResponder()
            lblnoproperty.isHidden = true
                        
            
        }
        
        
    }
    
}


extension NSMutableAttributedString {
        func attribute() {
        
                let yourAttributes : [NSAttributedStringKey: Any] = [
                    NSAttributedStringKey.font : UIFont(name: "Gotham-Light", size:13.0) as Any,
                NSAttributedStringKey.foregroundColor :UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.00)]
                
                let combionation = NSMutableAttributedString()
                let attributeString = NSMutableAttributedString(string: "Blood Group:",attributes: yourAttributes)
                
                let yourAttributes1 : [NSAttributedStringKey: Any] = [
                    NSAttributedStringKey.font : UIFont(name: "Gotham-Book", size:13.0) as Any,
                NSAttributedStringKey.foregroundColor :UIColor(red: 246.0/255.0, green: 10.0/255.0, blue: 32.0/255.0, alpha: 1.00)]
                
                let attributeString1 = NSMutableAttributedString(string: "",attributes: yourAttributes1)
                combionation.append(attributeString)
                combionation.append(attributeString1)
                
        
        }
    
    func setColor(color: UIColor, forText stringValue: String) {
          let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
          self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
       }
    

}
