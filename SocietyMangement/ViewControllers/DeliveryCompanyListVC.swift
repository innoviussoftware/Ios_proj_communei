//
//  DeliveryCompanyListVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 18/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

import Alamofire

protocol DeliveryCompanyListProtocol {
    
   // func deliveryList(name:String, selectNumber:Int)
    
    func deliveryList(name:String,VendorID:Int,IsPublic:Int, selectNumber:Int)

    
  //  func deliveryList(name:[String])
    
   // func deliveryList(ary:NSMutableArray,name:[String])

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
class DeliveryCompanyListVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var delegate:DeliveryCompanyListProtocol?
    
    var strlbl = String()
    
    var selectedindex:Int?
    
    var selectedindex1:Int?
    
    var visitorTypeID:Int?
    
    var arrFrequent_Deliveries = [DeliveryCompanySelect]()
            
  //  var isfromNumber: Bool?

    var entryary = [DeliveryCompanySelect]()
    
    var api_Company_Selection = "" // String()
    
    @IBOutlet weak var lblTitleName: UILabel!

    var strTitleName = String()

    //["Cab","Delivery","Visitor","Service provider"]
    
   // var alertGuardary = ["Emergency Alerts","Message Guard","Cab","Complaint Management","Visitor","Message Guard","Complaint Management"]
    
  //  var iconentryary = [UIImage(named:"ic_cab"),UIImage (named:"ic_delivery"),UIImage (named:"ic_user"),UIImage (named:"ic_domestic")]
    
 //   var iconalertGuardary = [UIImage(named:"ic_alerts"),UIImage (named:"ic_message"),UIImage (named:"ic_cab"),UIImage (named:"ic_complaint"),UIImage(named:"ic_user"),UIImage (named:"ic_message"),UIImage (named:"ic_complaint")]

    
    @IBOutlet weak var collectionFrequent_Deliveries: UICollectionView!

  //  @IBOutlet weak var collectionOther_Deliveries: UICollectionView!
    
    @IBOutlet weak var txtOtherName: UITextField!
    
    // MARK: - get DeliveryCompanyAdd

    
    func apicallDeliveryCompanyAdd()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
            
        let strToken =  UserDefaults.standard.value(forKey:USER_TOKEN)
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "VendorName" : txtOtherName.text!,
            "VisitorEntryTypeID" : visitorTypeID!
         ]
        
        Apicallhandler.sharedInstance.ApiCallAddCompanyDetails(VendorName: txtOtherName.text!, VisitorEntryTypeID: visitorTypeID!, token: strToken as! String, param: param) { JSON in
                                     
                             let statusCode = JSON.response?.statusCode
                             
                             switch JSON.result{
                             case .success(let resp):
                                
                                print(resp)

                                 webservices().StopSpinner()
                                 
                                 if statusCode == 200{
                                  
                                   self.apicallDeliveryCompanySelect()
                                   
                                    self.btnAddSuccessfully()
                                
                                 }
                                
                                self.txtOtherName.text! = ""
                                 
                             case .failure(let err):
                                 webservices().StopSpinner()
                                 if statusCode == 401{
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
                                 print(err.asAFError as Any)
                                 
                             }
                         }
              
    }
    
    
    // MARK: - get DeliveryCompanySelect
    
    func apicallDeliveryCompanySelect()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
            
        let strToken =  UserDefaults.standard.value(forKey:USER_TOKEN)
        
        webservices().StartSpinner()
        
        // API_USER_COMPANY_SELECT
            
        Apicallhandler().GetAllCompanySelectDetails(URL: webservices().baseurl + api_Company_Selection ,token:strToken as! String) { JSON in

            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.entryary = resp.data!
                    
                    if(resp.data!.count == 0)
                    {
                        self.collectionFrequent_Deliveries.isHidden = true
                    }
                    else
                    {

                        self.collectionFrequent_Deliveries.delegate = self
                        self.collectionFrequent_Deliveries.dataSource = self
                        self.collectionFrequent_Deliveries.reloadData()
                        self.collectionFrequent_Deliveries.isHidden = false
                        
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
                        self.collectionFrequent_Deliveries.isHidden = true
                    }
                    else
                    {
                        self.collectionFrequent_Deliveries.isHidden = false
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
              //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
              //  self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
                
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setborders(textfield: txtOtherName)
        
        print("strlbl :- ",strlbl)
        
        txtOtherName.delegate = self
        
        lblTitleName.text = strTitleName

       // webservices.sharedInstance.PaddingTextfiled(textfield: txtOtherName)
        
        apicallDeliveryCompanySelect()

      //  collectionFrequent_Deliveries.reloadData()
       // collectionOther_Deliveries.reloadData()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backaction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }
    
    @IBAction func btnAddPressed(_ sender: UIButton) {
        if txtOtherName.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Company Name")
            self.present(alert, animated: true, completion: nil)
        }else{
            apicallDeliveryCompanyAdd()
        }
    }
       
    func btnAddSuccessfully() {
        
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                  avc?.titleStr = "Successfully added"
        
        avc?.isfrom = 4
                  avc?.subtitleStr = "Your delivery will be allowed"
                  avc?.yesAct = {
                    
                     let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
                                   
                    let navgitaionCon = UINavigationController(rootViewController: homeViewController!)

                    navgitaionCon.popViewController(animated: true)

                  }
                  avc?.noAct = {
                    
                  }
                  present(avc!, animated: true)
    }
    
    func setborders(textfield:UITextField) {
        textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
        textfield.layer.borderWidth = 1.0
    }
    
    // MARK: - Collectionview delegate and datasource methods
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       /* if(collectionView == collectionFrequent_Deliveries){
            return entryary.count
        } */
        
        return entryary.count

//        else{
//            return alertGuardary.count
//        }
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        // if(collectionView == collectionFrequent_Deliveries) {
             
             let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
            
            if entryary[indexPath.row].companyLogoURL != nil{
                  cell.imgview.sd_setImage(with: URL(string: entryary[indexPath.item].companyLogoURL!), placeholderImage: UIImage(named: ""))
            }
            
            cell.lblname.text = entryary[indexPath.row].companyName!
                        
            if(selectedindex == indexPath.row) &&  (cell.lblname.text!.contains(strlbl)) {
                
                cell.imgview.layer.borderColor = AppColor.orangeColor.cgColor
                //UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 1.0
            }else {
                cell.imgview.layer.borderColor = UIColor.clear.cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 0.0
            }
            
        
             return cell
             
        /* }
         else{

             let cell:ShortCutCells = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCells
                    
             cell.imgview.image = iconalertGuardary[indexPath.row]
             cell.lblname.text = alertGuardary[indexPath.row]
                
           if(selectedindex1 == indexPath.row)  &&  (cell.lblname.text!.contains(strlbl)) {
                                    
                cell.imgview.layer.borderColor = AppColor.orangeColor.cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 1.0
            }else {
                cell.imgview.layer.borderColor = UIColor.clear.cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 0.0
            }
            
             return cell
         } */
                 
     }
          
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      /*  let collectionViewWidth = self.view.bounds.width - 8
        return CGSize(width: collectionViewWidth/4 - 4, height: collectionViewWidth/4
                   + 4) */
        
            let noOfCellsInRow = 4

           let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

           let totalSpace = flowLayout.sectionInset.left
               + flowLayout.sectionInset.right
               + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

           let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

           return CGSize(width: size, height: size)
          
        /*  if(collectionView == collectionFrequent_Deliveries){
              return CGSize(width: 84, height: 92)
          }else{
              return CGSize(width: 84, height: 92)
          } */
                  
      }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == collectionFrequent_Deliveries){
            selectedindex = indexPath.row
        }else{
            selectedindex1 = indexPath.row
        }

        collectionView.reloadData()

        if(collectionView == collectionFrequent_Deliveries){
            
           // delegate?.deliveryList(name: entryary[indexPath.row].companyName!, selectNumber: selectedindex!)
            
            delegate?.deliveryList(name: entryary[indexPath.row].companyName!, VendorID: entryary[indexPath.row].vendorID!, IsPublic: entryary[indexPath.row].isPublic!, selectNumber: selectedindex!)
            
            strlbl = entryary[indexPath.row].companyName!
            print("strlbl : ",strlbl)
        }
       /* else{
            delegate?.deliveryList(name: alertGuardary[indexPath.row], selectNumber: selectedindex1!)
            strlbl = alertGuardary[indexPath.row]
            print("strlbl : ",strlbl)
        } */
        

        self.navigationController?.popViewController(animated: true)

    }

}
