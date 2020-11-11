//
//  BuySellVC.swift
//  SocietyMangement
//
//  Created by Innovius on 03/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
import Alamofire
import ScrollPager


@available(iOS 13.0, *)
class BuySellVC: BaseVC ,ScrollPagerDelegate{
    
    @IBOutlet weak var btnNotification: UIButton!
    
    @IBOutlet var viewSell: UIView!
    @IBOutlet var viewBuy: UIView!
    @IBOutlet weak var pager: ScrollPager!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var btnSell: UIButton!
    @IBOutlet weak var lblBottomBuy: UILabel!
    @IBOutlet weak var lblBottomSell: UILabel!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    
   
    @IBOutlet weak var collectionBuyCategory: UICollectionView!
    
    @IBOutlet weak var tblBuyRecommendation: UITableView!
    
    @IBOutlet weak var tblMyListing: UITableView!


   // @IBOutlet weak var collectionBuyRecommendation: UICollectionView!
    
    @IBOutlet weak var collectionSellCategory: UICollectionView!
    
  //  @IBOutlet weak var CollectionMyListing: UICollectionView!
    
    var arrCategory = [BuySellCategoryData]()
    var arrRecommend = [BuySellProductListData]()
    var arrSellData = [BuySellProductListData]()
    
    var strType = "1"
    
    var isfrom = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pager.delegate = self
        pager.tintColor  = AppColor.appcolor
        pager.addSegmentsWithTitlesAndViews(segments: [
            ("Buy", viewBuy),("Sell", viewSell)])
        
        pager.font = UIFont(name: "GothamMedium", size: 16)!

        collectionBuyCategory.register(UINib(nibName: "categoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        collectionSellCategory.register(UINib(nibName: "categoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
        tblBuyRecommendation.register(UINib(nibName: "BuycategoryCell", bundle: nil), forCellReuseIdentifier: "BuycategoryCell")
        tblBuyRecommendation.separatorStyle = .none
        
        tblMyListing.register(UINib(nibName: "BuycategoryCell", bundle: nil), forCellReuseIdentifier: "BuycategoryCell")
         tblMyListing.separatorStyle = .none
        
      //  collectionBuyRecommendation.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCell")
       // CollectionMyListing.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCell")
        
        if isfrom == 0 {
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)

        }else{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        
            if(revealViewController() != nil)
            {
                btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
            
        }
        
       // setUpViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViewData()
        pager.setSelectedIndex(index: 0, animated: true)
    }
    
    
    func setUpViewData() {
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        apiBuySellList()
        apiProductList(type: "1")//default Buy
        
        //        let dict = NSMutableDictionary()
        //        dict.setValue("Furniture", forKey: "cat_name")
        //        dict.setValue("furniture", forKey: "cat_img")
        //        arrCategory.add(dict)
        //
        //        let dict1 = NSMutableDictionary()
        //        dict1.setValue("Electronic", forKey: "cat_name")
        //        dict1.setValue("electronic", forKey: "cat_img")
        //        arrCategory.add(dict1)
        //
        //
        //        let dict2 = NSMutableDictionary()
        //        dict2.setValue("Cars", forKey: "cat_name")
        //        dict2.setValue("cars", forKey: "cat_img")
        //        arrCategory.add(dict2)
        //
        //        let dict3 = NSMutableDictionary()
        //        dict3.setValue("Mobile", forKey: "cat_name")
        //        dict3.setValue("Mobile", forKey: "cat_img")
        //        arrCategory.add(dict3)
        //
        //        let dict4 = NSMutableDictionary()
        //        dict4.setValue("Bikes", forKey: "cat_name")
        //        dict4.setValue("bikes", forKey: "cat_img")
        //        arrCategory.add(dict4)
        //
        //
        //
        //
        //        let dict5 = NSMutableDictionary()
        //        dict5.setValue("Sports", forKey: "cat_name")
        //        dict5.setValue("Sports", forKey: "cat_img")
        //        arrCategory.add(dict5)
        //
        //        let dict6 = NSMutableDictionary()
        //        dict6.setValue("Music", forKey: "cat_name")
        //        dict6.setValue("Music", forKey: "cat_img")
        //        arrCategory.add(dict6)
        //
        //        let dict7 = NSMutableDictionary()
        //        dict7.setValue("Toys", forKey: "cat_name")
        //        dict7.setValue("Toys", forKey: "cat_img")
        //        arrCategory.add(dict7)
        //
        //        let dict8 = NSMutableDictionary()
        //        dict8.setValue("Fashion", forKey: "cat_name")
        //        dict8.setValue("Fashion", forKey: "cat_img")
        //        arrCategory.add(dict8)
        //
        //        collectionCategory.dataSource = self
        //        collectionCategory.delegate = self
        //        collectionCategory.reloadData()
        
    }
    
    //MARK:- action method
    @IBAction func actionMenu(_ sender: Any) {
        
        if isfrom == 0 {
            self.navigationController?.popViewController(animated: true)
        }else{
            print("revealViewController")
        }
       // revealViewController()?.revealToggle(self)
    }
    @IBAction func actionBuy(_ sender: Any) {
        
        lblBottomSell.isHidden = true
        lblBottomBuy.isHidden = false
    }
    @IBAction func actionSell(_ sender: Any) {
        
        lblBottomSell.isHidden = false
        lblBottomBuy.isHidden = true
    }
    @IBAction func actionViewAll(_ sender: Any) {
        
        print("actionViewAll")
    }
    
    
    @IBAction func actionNotification(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
            vc.isfrom = 0

            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            vc.isfrom = 0

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    //MARK:- webservices
    
    func apiBuySellList() {
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
        
        print("SociId : ",SociId)
        
        //let strSociId  = (SociId as NSNumber).stringValue
        
        webservices().StartSpinner()
        Apicallhandler().GetBuySellList(URL: webservices().baseurl + API_BUY_SELL_LIST, societyid:"") { JSON in
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.arrCategory = resp.data!
                    
                    if self.arrCategory.count > 0{
                        
                        self.collectionBuyCategory.delegate = self
                        self.collectionBuyCategory.dataSource = self
                        self.collectionBuyCategory.reloadData()
                        
                        self.collectionSellCategory.delegate = self
                        self.collectionSellCategory.dataSource = self
                        self.collectionSellCategory.reloadData()
                        
                    }else{
                        
                    }
                    
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
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
    
    
    
    func apiProductList(type:String)
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
        let strSociId  = (SociId as NSNumber).stringValue
        
        let pram:Parameters = [
            "category_id":"0",
            "society_id" : strSociId,
            "type":type
        ]
        
        webservices().StartSpinner()
        Apicallhandler().GetProductList(URL: webservices().baseurl + API_BUY_SELL_PRODUCT, param:pram, token: token as! String) { JSON in
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.arrRecommend.removeAll()
                    self.arrRecommend = resp.data!
                    if type == "1"{
                        if self.arrRecommend.count > 0{
                        
                           //   collectionBuyRecommendation
                            self.tblBuyRecommendation.isHidden = false
                            self.lblNoDataFound.isHidden = true
                            

                            self.tblBuyRecommendation.delegate = self
                            self.tblBuyRecommendation.dataSource = self
                            self.tblBuyRecommendation.reloadData()
                            
                        }else{
                            self.tblBuyRecommendation.isHidden = true
                            self.lblNoDataFound.isHidden = false
                            
                        }
                        
                    }else{
                        if self.arrRecommend.count > 0{
                            // CollectionMyListing
                            self.tblMyListing.isHidden = false
                            self.lblNoDataFound.isHidden = true
                            
                            
                            self.tblMyListing.delegate = self
                            self.tblMyListing.dataSource = self
                            self.tblMyListing.reloadData()
                            
                        }else{
                            self.tblMyListing.isHidden = true
                            self.lblNoDataFound.isHidden = false
                            
                        }
                    }
                    
                    
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
                
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
    
    
    func apiProductDelete(id:String)
       {
           if !NetworkState().isInternetAvailable {
               ShowNoInternetAlert()
               return
           }
           let token = UserDefaults.standard.value(forKey: USER_TOKEN)
           
           let pram:Parameters = [
               "id":id
           ]
           
           webservices().StartSpinner()
           Apicallhandler().BuySellProductDelete(URL: webservices().baseurl + API_BUY_SELL_PRODUCT_DELETE, param:pram, token: token as! String) { JSON in
               switch JSON.result{
               case .success(let resp):
                   //webservices().StopSpinner()
                   if(JSON.response?.statusCode == 200)
                   {
                      
                    if self.strType == "1"{
                        self.apiProductList(type: "1")
                       }else{
                          self.apiProductList(type: "2")
                       }
                   }
                   else
                   {
                       let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                       self.present(alert, animated: true, completion: nil)
                   }
                   
                   print(resp)
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
    
    
    
    
    
    
    //MARK:- action Delete/Edit
    @objc func actionDelete(sender:UIButton) {
        let strId = (arrRecommend[sender.tag].id! as NSNumber).stringValue
        
        let _ : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.isfrom = 2
        avc?.titleStr = "Listing"
        avc?.subtitleStr = "Are you sure you want to delete this product?"
        avc?.yesAct = {
            self.apiProductDelete(id: strId)
        }
        avc?.noAct = {
          
        }
        present(avc!, animated: true)
        
    }
    
    @objc func actionEdit(sender:UIButton) {
           
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "AddEditBuySellProductVC") as! AddEditBuySellProductVC
            vc.arrRecommendData = arrRecommend[sender.tag]
            vc.isEditProdcut = true
            vc.strCategoryID = (arrRecommend[sender.tag].categoryID! as NSNumber).stringValue
            vc.strProductId = (arrRecommend[sender.tag].id! as NSNumber).stringValue
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddEditBuySellProductVC") as! AddEditBuySellProductVC
            vc.arrRecommendData = arrRecommend[sender.tag]
            vc.strCategoryID = (arrRecommend[sender.tag].categoryID! as NSNumber).stringValue
            vc.isEditProdcut = true
            vc.strProductId = (arrRecommend[sender.tag].id! as NSNumber).stringValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    @IBAction func actionQrCode(_ sender: Any) {
        if #available(iOS 13.0, *) {
                   let vc = self.storyboard?.instantiateViewController(identifier: "QRCodeVC") as! QRCodeVC
            self.navigationController?.pushViewController(vc, animated: true)

               } else {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeVC") as! QRCodeVC
            self.navigationController?.pushViewController(vc, animated: true)

               }
               
    }
    
    //MARK:- ScrollPager delegate 
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        
        if changedIndex == 0{//Buy
            apiProductList(type: "1")
            strType = "1"
            
        }else{
            apiProductList(type: "2")
            strType = "2"
        }
        
    }
    
    
}


@available(iOS 13.0, *)
extension BuySellVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionBuyCategory{
            return arrCategory.count
        }else //if collectionView == collectionSellCategory
        {
            return arrCategory.count
        }
        /*else if collectionView == collectionBuyRecommendation{
            return arrRecommend.count
        }else{
            return arrRecommend.count
        }*/
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionBuyCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
            
            
            if(arrCategory[indexPath.row].icon != nil)
            {
                // 1/9/20.
                
                cell.imgProduct.sd_setImage(with: URL(string:webservices().BuySellImgUrl + arrCategory[indexPath.row].icon!), placeholderImage: UIImage(named: "vendor-1"))
                
              //  cell.imgProduct.sd_setImage(with: URL(string: webservices().imgurl + arrCategory[indexPath.row].icon!), placeholderImage: UIImage(named: "vendor-1"))

            }
            cell.lblCategoryName.text = arrCategory[indexPath.row].name!
            
            return cell
        }else if collectionView == collectionSellCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
            
            
            if(arrCategory[indexPath.row].icon != nil)
            {
                // 1/9/20.

                cell.imgProduct.sd_setImage(with: URL(string:webservices().BuySellImgUrl + arrCategory[indexPath.row].icon!), placeholderImage: UIImage(named: "vendor-1"))
                
              //  cell.imgProduct.sd_setImage(with: URL(string: webservices().imgurl + arrCategory[indexPath.row].icon!), placeholderImage: UIImage(named: "vendor-1"))

            }
            cell.lblCategoryName.text = arrCategory[indexPath.row].name!
            
            return cell
      /*  }else if collectionView == collectionBuyRecommendation{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
    
            cell.ViewDelete.isHidden = true
            cell.viewEdit.isHidden = true
            cell.lblSeprater.isHidden = true
            
            if arrRecommend[indexPath.row].productsimages!.count > 0{
                if arrRecommend[indexPath.row].productsimages?[0].image != nil
                {
                    cell.imgProduct.sd_setImage(with: URL(string:webservices().imgurl + (arrRecommend[indexPath.row].productsimages?[0].image!)!), placeholderImage: UIImage(named: "vendor profile"))
                }
            }
            
            //            let rupee = "\u{20B9}"
            cell.lblPrice.text = String(format: "\u{20B9} %@", arrRecommend[indexPath.row].price!) //arrRecommend[indexPath.row].price
            cell.lblDiscription.text = arrRecommend[indexPath.row].title
            
            
            cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
            cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
            
            return cell
            
            */
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
            
            if strType == "1"{
                cell.ViewDelete.isHidden = true
                cell.viewEdit.isHidden = true
                cell.lblSeprater.isHidden = true
            }else{
//                if UsermeResponse?.data?.relation == "self"{
                    cell.ViewDelete.isHidden = false
                    cell.viewEdit.isHidden = false
                    cell.lblSeprater.isHidden = false
                    cell.btnEdit.tag = indexPath.row
                    cell.btnDelete.tag = indexPath.row
               // }
            }
            
            
            if arrRecommend[indexPath.row].productsimages!.count > 0{
                if arrRecommend[indexPath.row].productsimages?[0].image != nil
                {
                    cell.imgProduct.sd_setImage(with: URL(string:webservices().imgurl + (arrRecommend[indexPath.row].productsimages?[0].image!)!), placeholderImage: UIImage(named: "vendor profile"))
                }
            }
            
      
            
            cell.lblPrice.text = String(format: "\u{20B9} %@", arrRecommend[indexPath.row].price!)
            cell.lblDiscription.text = arrRecommend[indexPath.row].title
            
            cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
            cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
            
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionBuyCategory{
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsVC") as! CategoryDetailsVC
            vc.strCategoryName = arrCategory[indexPath.row].name!
            vc.strCategoryId = (arrCategory[indexPath.row].id! as NSNumber).stringValue
            vc.strCategoryType = strType
            self.navigationController?.pushViewController(vc, animated: true)
        }else if collectionView == collectionSellCategory{
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "AddEditBuySellProductVC") as! AddEditBuySellProductVC
            vc.strCategoryID = (arrCategory[indexPath.row].id! as NSNumber).stringValue
            vc.isEditProdcut = false
            self.navigationController?.pushViewController(vc, animated: true)
       /* }else if collectionView == collectionBuyRecommendation{
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
            vc.arrProductDetails = arrRecommend[indexPath.row]
            vc.strCategoryId = (arrRecommend[indexPath.row].categoryID! as NSNumber).stringValue
            vc.strProductID = (arrRecommend[indexPath.row].id! as NSNumber).stringValue
            vc.strCategoryName = arrRecommend[indexPath.row].title!
            self.navigationController?.pushViewController(vc, animated: true) */
        }
        else{
           let vc  = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
            vc.arrProductDetails = arrRecommend[indexPath.row]
            vc.strCategoryId = (arrRecommend[indexPath.row].categoryID! as NSNumber).stringValue
            vc.strProductID = (arrRecommend[indexPath.row].id! as NSNumber).stringValue
            vc.strCategoryName = arrRecommend[indexPath.row].title!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        //return CGSize(width: 100, height: 128)
        
        if collectionView == collectionBuyCategory{
            return CGSize(width: 125, height: 112)
        }else if collectionView == collectionSellCategory{
            return CGSize(width: 125, height: 112)
        }
        else{
            return  CGSize(width: collectionWidth/2-8, height: 208)
        }
        
        
    }
    
    
}




@available(iOS 13.0, *)
extension BuySellVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return arrRecommend.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblBuyRecommendation{
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "BuycategoryCell") as! BuycategoryCell
           
           cell.selectionStyle = .none
                   
          cell.stkviw.isHidden = true
                  
          if arrRecommend[indexPath.row].productsimages!.count > 0{
                if arrRecommend[indexPath.row].productsimages?[0].image != nil
                      {
                          cell.imgProduct.sd_setImage(with: URL(string:webservices().imgurl + (arrRecommend[indexPath.row].productsimages?[0].image!)!), placeholderImage: UIImage(named: "ic_bg_buy"))
                        }
                      
                  }
                  
                  //            let rupee = "\u{20B9}"
        cell.lblPrice.text = String(format: "\u{20B9} %@", arrRecommend[indexPath.row].price!)
        cell.lblName.text = arrRecommend[indexPath.row].title
                  
        cell.lblQuality.text = arrRecommend[indexPath.row].quality

                  
        cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
        
        
           return cell
        
        }else{
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "BuycategoryCell") as! BuycategoryCell

                    
                    if strType == "1"{
                        cell.stkviw.isHidden = true
                    }else{
        //                if UsermeResponse?.data?.relation == "self"{
                            cell.btnEdit.tag = indexPath.row
                            cell.btnDelete.tag = indexPath.row
                       // }
                    }
                    
                    
                    if arrRecommend[indexPath.row].productsimages!.count > 0{
                        if arrRecommend[indexPath.row].productsimages?[0].image != nil
                        {
                            cell.imgProduct.sd_setImage(with: URL(string:webservices().imgurl + (arrRecommend[indexPath.row].productsimages?[0].image!)!), placeholderImage: UIImage(named: "ic_bg_buy"))
                        }
                    }
                    
              
                    
                    cell.lblPrice.text = String(format: "\u{20B9} %@", arrRecommend[indexPath.row].price!)
                    cell.lblName.text = arrRecommend[indexPath.row].title
                    
                    cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
                    cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
                    
                    
                    return cell
                }
           
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tblBuyRecommendation{

            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
            vc.arrProductDetails = arrRecommend[indexPath.row]
            vc.strCategoryId = (arrRecommend[indexPath.row].categoryID! as NSNumber).stringValue
            vc.strProductID = (arrRecommend[indexPath.row].id! as NSNumber).stringValue
            vc.strCategoryName = arrRecommend[indexPath.row].title!
            self.navigationController?.pushViewController(vc, animated: true)
        
          }else{
              let vc  = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
               vc.arrProductDetails = arrRecommend[indexPath.row]
               vc.strCategoryId = (arrRecommend[indexPath.row].categoryID! as NSNumber).stringValue
               vc.strProductID = (arrRecommend[indexPath.row].id! as NSNumber).stringValue
               vc.strCategoryName = arrRecommend[indexPath.row].title!
               self.navigationController?.pushViewController(vc, animated: true)
           }
        
        }
       
       
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableViewAutomaticDimension
       }

    
    
    
    
}
