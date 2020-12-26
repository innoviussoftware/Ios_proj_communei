//
//  CategoryDetailsVC.swift
//  SocietyMangement
//
//  Created by Innovius on 03/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
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
class CategoryDetailsVC: UIViewController {
    @IBOutlet weak var lblTitel: UILabel!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
   // @IBOutlet weak var collectionCategory: UICollectionView!
    
    @IBOutlet weak var tblCategory: UITableView!
    
    var ProductCategoryID: Int?

    var strCategoryName = ""
    var strCategoryId = ""
    var strCategoryType = ""
    var arrCategoryDetails = [BuySellProductListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        apiProductList(ProductCategoryID: ProductCategoryID!)
        
        self.lblNoDataFound.isHidden = true
        
   //   collectionCategory.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCell")
        
        tblCategory.register(UINib(nibName: "BuycategoryCell", bundle: nil), forCellReuseIdentifier: "BuycategoryCell")
        tblCategory.separatorStyle = .none

       lblTitel.text = strCategoryName
    }
    

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- action Delete/Edit
    @objc func actionDelete(sender:UIButton) {
        let strId = (arrCategoryDetails[sender.tag].productCategoryID! as NSNumber).stringValue
        
        let _ : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr = Alert_Titel
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
            vc.arrRecommendData = arrCategoryDetails[sender.tag]
            vc.isEditProdcut = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddEditBuySellProductVC") as! AddEditBuySellProductVC
            vc.arrRecommendData = arrCategoryDetails[sender.tag]
            vc.isEditProdcut = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    //webservice
    
      
        func apiProductList(ProductCategoryID:Int)
        {
              if !NetworkState().isInternetAvailable {
                             ShowNoInternetAlert()
                             return
                         }
    //            let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
    //            let strSociId  = (SociId as NSNumber).stringValue
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            let pram:Parameters = [
                "ProductCategoryID":ProductCategoryID,
               // "type":strCategoryType,
            ]
              
            webservices().StartSpinner()
            
            Apicallhandler().GetProductListBuy(URL: webservices().baseurl + API_BUY_SELL_LISTING_SEPRATED, param: pram, token: token as! String) { JSON in

           // Apicallhandler().GetProductList(URL: webservices().baseurl + API_BUY_SELL_PRODUCT, param:pram, token: token as! String) { JSON in
                    switch JSON.result{
                    case .success(let resp):
                        webservices().StopSpinner()
                        if(JSON.response?.statusCode == 200)
                        {
                            
                            self.arrCategoryDetails = resp.data!
                          
                                if self.arrCategoryDetails.count > 0{
                                    self.lblNoDataFound.isHidden = true
                                    // collectionCategory
                                    self.tblCategory.isHidden = false
                                                         self.tblCategory.delegate = self
                                                         self.tblCategory.dataSource = self
                                                         self.tblCategory.reloadData()
                                                         
                                                     }else{
                                    self.lblNoDataFound.isHidden = false
                                    self.tblCategory.isHidden = true
                                                     }
                        }
                        else
                        {
                            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
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
                        print(err.asAFError!)
                        
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
                      
                    if self.strCategoryType == "1"{
                        self.apiProductList(ProductCategoryID: 1)
                       }else{
                          self.apiProductList(ProductCategoryID: 2)
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
    
    
}




@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension CategoryDetailsVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategoryDetails.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
            
       
        //if strCategoryType == "1"{
            cell.ViewDelete.isHidden = true
            cell.viewEdit.isHidden = true
            cell.lblSeprater.isHidden = true
       // }else{
            //if UsermeResponse?.data?.relation == "self"{
//                cell.ViewDelete.isHidden = false
//                cell.viewEdit.isHidden = false
//                cell.lblSeprater.isHidden = false
//                cell.btnEdit.tag = indexPath.row
//                cell.btnDelete.tag = indexPath.row
//            }else{
//                cell.ViewDelete.isHidden = true
//                cell.viewEdit.isHidden = true
//                cell.lblSeprater.isHidden = true
//            }
        //}
        
        if arrCategoryDetails[indexPath.row].productsimages!.count > 0{
                       if arrCategoryDetails[indexPath.row].productsimages?[0].attachment != nil
                       {
                           cell.imgProduct.sd_setImage(with: URL(string: (arrCategoryDetails[indexPath.row].productsimages?[0].attachment!)!), placeholderImage: UIImage(named: "vendor-1"))
                       }
                   }
  
               
        cell.lblPrice.text =  String(format: "\u{20B9} %@", arrCategoryDetails[indexPath.row].amount!)
        cell.lblDiscription.text = arrCategoryDetails[indexPath.row].title
        

        cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
        
            return cell
     
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC")  as! BuySellProductDetailsVC
                   vc.arrProductDetails = arrCategoryDetails[indexPath.row]
                   vc.CategoryId = (arrCategoryDetails[indexPath.row].productCategoryID!) // as NSNumber).stringValue
                   vc.ProductID = (arrCategoryDetails[indexPath.row].productID!) // as NSNumber).stringValue
                   vc.strCategoryName = arrCategoryDetails[indexPath.row].title!
                   self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        //return CGSize(width: 100, height: 128)
      
            return  CGSize(width: collectionWidth/2-8, height: 208)
       
    }
    
    
        
    
}



@available(iOS 13.0, *)
extension CategoryDetailsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return arrCategoryDetails.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "BuycategoryCell") as! BuycategoryCell
           
           cell.selectionStyle = .none
                                     
          //if strCategoryType == "1"{
            
                        cell.stkviw.isHidden = true
        
                 // }else{
                      //if UsermeResponse?.data?.relation == "self"{
          //                cell.ViewDelete.isHidden = false
          //                cell.viewEdit.isHidden = false
          //                cell.lblSeprater.isHidden = false
          //                cell.btnEdit.tag = indexPath.row
          //                cell.btnDelete.tag = indexPath.row
          //            }else{
          //                cell.ViewDelete.isHidden = true
          //                cell.viewEdit.isHidden = true
          //                cell.lblSeprater.isHidden = true
          //            }
                  //}
                  
                  if arrCategoryDetails[indexPath.row].productsimages!.count > 0{
                                 if arrCategoryDetails[indexPath.row].productsimages?[0].attachment != nil
                                 {
                                     cell.imgProduct.sd_setImage(with: URL(string: (arrCategoryDetails[indexPath.row].productsimages?[0].attachment!)!), placeholderImage: UIImage(named: "ic_bg_buy"))
                                 }
                             }
            
                         
                  cell.lblPrice.text =  "\(arrCategoryDetails[indexPath.row].amount!)"
                  cell.lblName.text = arrCategoryDetails[indexPath.row].title
                  cell.lblQuality.text = arrCategoryDetails[indexPath.row].qualityStatus


                  cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
                  cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
        
                return cell
           
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                    let vc  = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC")  as! BuySellProductDetailsVC
                    vc.arrProductDetails = arrCategoryDetails[indexPath.row]
                    vc.CategoryId = (arrCategoryDetails[indexPath.row].productCategoryID!) // as NSNumber).stringValue
                    vc.ProductID = (arrCategoryDetails[indexPath.row].productID!) //  as NSNumber).stringValue
                    vc.strCategoryName = arrCategoryDetails[indexPath.row].title!
                    self.navigationController?.pushViewController(vc, animated: true)
        
        }
       
       
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableViewAutomaticDimension
       }

    
        
    
}
