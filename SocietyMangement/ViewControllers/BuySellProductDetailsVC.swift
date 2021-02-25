//
//  BuySellProductDetailsVC.swift
//  SocietyMangement
//
//  Created by MacMini on 20/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire
import FSPagerView



class BuySellProductDetailsVC: BaseVC {
    @IBOutlet weak var btnBack: UIButton!
   
    @IBOutlet weak var lblCategorNameTitel: UILabel!
    
    @IBOutlet weak var lblQuality: UILabel!

    @IBOutlet weak var pagerView: FSPagerView!{
    didSet {
           self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
       }
    }
    
    @IBOutlet weak var lblSellerName: UILabel!
    @IBOutlet weak var lblFlatNo: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var constraintPagerViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var tblview: UITableView!

    
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var imgSeller: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var page: UIPageControl!
    
    @IBOutlet weak var  lblBloodGroup: UILabel!
    
    @IBOutlet weak var lblStaticRelatedItem: UILabel!
    var arrProductDetails : BuySellProductListData!
    var arrRelatedProduct = [BuySellProductListData]()
    var arrProductImage = [Productsimage]()
    
    var ProductID : Int?
    var CategoryId : Int?
    
    
   // var strProductID = ""
   // var strCategoryId = ""
    
    var strProductName = ""
    var strCategoryName = ""
    
    let layout = UICollectionViewFlowLayout()
   
    
    @IBOutlet weak var collectionPagging: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
                   overrideUserInterfaceStyle = .light
            }
        
        lblCategorNameTitel.text = strCategoryName
        
        lblQuality.text = arrProductDetails.qualityStatus!
        
      //  collectionview.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCell")
        
        tblview.register(UINib(nibName: "BuycategoryCell", bundle: nil), forCellReuseIdentifier: "BuycategoryCell")

        tblview.separatorStyle = .none


       // layout.scrollDirection = .horizontal
      //  self.collectionview.collectionViewLayout = layout
        
        fillData()
    }
    
    func fillData() {
        
        if arrProductDetails.productsimages != nil {

            arrProductImage = arrProductDetails.productsimages!
            
            if arrProductImage.count == 0{
                constraintPagerViewHight.constant = 0
                page.isHidden = true
                
                pagerView.contentMode = .right
                page.numberOfPages = 0
            }else{
                constraintPagerViewHight.constant = 200
                page.isHidden = false
                
                pagerView.contentMode = .right
                page.numberOfPages = arrProductImage.count
            }
            
        }else{
            constraintPagerViewHight.constant = 0
            page.isHidden = true
            page.numberOfPages = 0
        }
        
      // lblPrice.text = String(format: "Price: \u{20B9} %@", arrProductDetails.amount!)
        
        lblPrice.text = "\u{20B9}" + "\(arrProductDetails.amount!)" //"\(arrProductDetails.amount!)"

        
       // lblBloodGroup.text =  arrProductDetails.bloodgroup!
        lblDescription.text = arrProductDetails.datumDescription!
        lblSellerName.text = arrProductDetails.userName!
        lblFlatNo.text = arrProductDetails.propertyFullName
       // lblMobileNo.text = arrProductDetails.phone
        
        if(arrProductDetails.profilePhotoPath != nil)
        {
            imgSeller.sd_setImage(with: URL(string: arrProductDetails.profilePhotoPath!), placeholderImage: UIImage(named: "vendor profile"))
        }else{
            imgSeller.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "vendor profile"))
        }
        apiProductList(productID: ProductID!, categoryId: CategoryId!)

    }
    
    @IBAction func actionNotification(_ sender: Any) {
             let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
              vc.isfrom = 0
           }
          
    
    //Mark:- action method
    
    func shareImage() {
        
       // let messageStr = "Product Detail:\nName:\(arrProductDetails.categoryname!)\n\(lblPrice.text!)\n\nSeller Details:\nName:\(lblSellerName.text!)\nFlat No:\(lblFlatNo.text!)\nContact No:\(lblMobileNo.text!)"
        
        let messageStr = "Product Detail:\nName:\(arrProductDetails.productCategoryName!)\n\(lblPrice.text!)\n\nSeller Details:\nName:\(lblSellerName.text!)\nFlat No:\(lblFlatNo.text!)"//"\nContact No:\(lblMobileNo.text!)"

        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [imgSeller.image!, messageStr], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.copyToPasteboard, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func actionShare(_ sender: Any) {
        shareImage()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionCall(_ sender: Any) {
        
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
        avc?.isfrom = 3

            avc?.subtitleStr = "Are you sure you want to call:\(arrProductDetails.phone!)"
                        avc?.yesAct = {
                                              
                                self.dialNumber(number:self.arrProductDetails.phone!)

                            }
                        avc?.noAct = {
                                            
                                    }
            
        present(avc!, animated: true)
        
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
        
    //webServices
    func apiProductList(productID:Int,categoryId:Int)
       {
           if !NetworkState().isInternetAvailable {
               ShowNoInternetAlert()
               return
           }
           let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
           
           let pram:Parameters = [
               "ProductCategoryID":categoryId,
               "ProductID":productID,
           ]
           
           webservices().StartSpinner()
        
           Apicallhandler().GetRelatedProduct(URL: webservices().baseurl + API_RELATED_PRODUCT, param:pram, token: token as! String) { JSON in
               switch JSON.result{
               case .success(let resp):
                   webservices().StopSpinner()
                   if(JSON.response?.statusCode == 200)
                   {
                       self.arrRelatedProduct = resp.data!
                    
                           if self.arrRelatedProduct.count > 0{
                               self.tblview.isHidden = false
                               self.tblview.delegate = self
                               self.tblview.dataSource = self
                               self.tblview.reloadData()
                               
                           }else{
                               self.tblview.isHidden = true
                              // self.lblNoDataFound.isHidden = false
                               
                           }
                       
                   }
                   else if(JSON.response?.statusCode == 401)
                   {
                    
                    UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                    UserDefaults.standard.removeObject(forKey:USER_ID)
                    UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                    UserDefaults.standard.removeObject(forKey:USER_ROLE)
                    UserDefaults.standard.removeObject(forKey:USER_PHONE)
                    UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                    UserDefaults.standard.removeObject(forKey:USER_NAME)
                    UserDefaults.standard.removeObject(forKey:USER_SECRET)
                    UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                    
                       
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                             let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                          let navController = UINavigationController(rootViewController: aVC)
                                                                          navController.isNavigationBarHidden = true
                                                             self.appDelegate.window!.rootViewController  = navController
                                                                                
                       
                   }
                   else
                   {
                   // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
                     //  self.present(alert, animated: true, completion: nil)
                   }
                   
                   print(resp)
               case .failure(let err):
                   webservices().StopSpinner()
                   if JSON.response?.statusCode == 401{
                    
                    UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                    UserDefaults.standard.removeObject(forKey:USER_ID)
                    UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                    UserDefaults.standard.removeObject(forKey:USER_ROLE)
                    UserDefaults.standard.removeObject(forKey:USER_PHONE)
                    UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                    UserDefaults.standard.removeObject(forKey:USER_NAME)
                    UserDefaults.standard.removeObject(forKey:USER_SECRET)
                    UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                    
                       
                               let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                               let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                               let navController = UINavigationController(rootViewController: aVC)
                               navController.isNavigationBarHidden = true
                               self.appDelegate.window!.rootViewController  = navController
                               
                        
                       
                       return
                   }
                  // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                  // self.present(alert, animated: true, completion: nil)
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
                         
//                       if self.strType == "1"{
//                           self.apiProductList(type: "1")
//                          }else{
//                             self.apiProductList(type: "2")
//                          }
                        
                        self.apiProductList(productID: self.ProductID!, categoryId: self.CategoryId!)

                      }
                      else if(JSON.response?.statusCode == 401)
                      {
                         
                        
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                   let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                             let navController = UINavigationController(rootViewController: aVC)
                                                                             navController.isNavigationBarHidden = true
                                                                self.appDelegate.window!.rootViewController  = navController
                           
                          
                      }
                      else
                      {
                         // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                         // self.present(alert, animated: true, completion: nil)
                      }
                      
                      print(resp)
                  case .failure(let err):
                      webservices().StopSpinner()
                      if JSON.response?.statusCode == 401{
                         
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                  let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                  let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                  let navController = UINavigationController(rootViewController: aVC)
                                  navController.isNavigationBarHidden = true
                                  self.appDelegate.window!.rootViewController  = navController
                        
                          
                          return
                      }
                     // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                     // self.present(alert, animated: true, completion: nil)
                      print(err.asAFError!)
                      
                  }
              }
              
              
          }
    
    
    //MARK:- action Delete/Edit
    @objc func actionDelete(sender:UIButton) {
        let strId = (arrRelatedProduct[sender.tag].productCategoryID! as NSNumber).stringValue
        
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
            vc.arrRecommendData = arrRelatedProduct[sender.tag]
            vc.isEditProdcut = true
            vc.CategoryID = (arrRelatedProduct[sender.tag].productCategoryID!) // as NSNumber).stringValue
            vc.ProductId = (arrRelatedProduct[sender.tag].productID!) // as NSNumber).stringValue
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddEditBuySellProductVC") as! AddEditBuySellProductVC
            vc.arrRecommendData = arrRelatedProduct[sender.tag]
            vc.CategoryID = (arrRelatedProduct[sender.tag].productCategoryID!) //  as NSNumber).stringValue
            vc.isEditProdcut = true
            vc.ProductId = (arrRelatedProduct[sender.tag].productID!) // as NSNumber).stringValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
}


/*

 
extension BuySellProductDetailsVC : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if collectionView == collectionPagging{
//            return arrProductImage.count
//        }else{
            return arrRelatedProduct.count
       // }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if collectionView == collectionPagging{
//             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "paggingCollectionCell", for: indexPath) as! paggingCollectionCell
//            if(arrProductImage[indexPath.row].image != nil)
//                       {
//                           cell.imgProduct.sd_setImage(with: URL(string:webservices().imgurl + arrProductImage[indexPath.row].image!), placeholderImage: UIImage(named: "vendor-1"))
//                       }
//            return cell
//
//        }else{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
            
            cell.ViewDelete.isHidden = true
            cell.viewEdit.isHidden = true
            cell.lblSeprater.isHidden = true
            
        
        if arrRelatedProduct[indexPath.row].productsimages!.count > 0{
            if arrRelatedProduct[indexPath.row].productsimages?[0].image != nil
            {
                cell.imgProduct.sd_setImage(with: URL(string:webservices().imgurl + (arrRelatedProduct[indexPath.row].productsimages?[0].image!)!), placeholderImage: UIImage(named: "vendor-1"))
            }
        }
        
            cell.lblPrice.text = String(format: "\u{20B9} %@", arrRelatedProduct[indexPath.row].price!)
            cell.lblDiscription.text = arrRelatedProduct[indexPath.row].categoryname

      
            
            return cell
        //}
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if collectionView == collectionview{

            
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
                vc.arrProductDetails = arrRelatedProduct[indexPath.row]
                          vc.strCategoryId = (arrRelatedProduct[indexPath.row].categoryID! as NSNumber).stringValue
                          vc.strProductID = (!(arrRelatedProduct[indexPath.row].id != nil) as NSNumber).stringValue
                vc.strCategoryName = arrRelatedProduct[indexPath.row].categoryname!
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
                vc.arrProductDetails = arrRelatedProduct[indexPath.row]
                          vc.strCategoryId = (arrRelatedProduct[indexPath.row].categoryID! as NSNumber).stringValue
                          vc.strProductID = (!(arrRelatedProduct[indexPath.row].id != nil) as NSNumber).stringValue
                          self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        
    }
    
   

    
    
}

*/

/*
 
extension BuySellProductDetailsVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
               return  CGSize(width: 200, height: 208)
           
       }
}
*/


extension BuySellProductDetailsVC : FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrProductImage.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        if(arrProductImage[index].attachment != nil)
        {
            cell.imageView?.sd_setImage(with: URL(string: arrProductImage[index].attachment!), placeholderImage: UIImage(named: "vendor-1"))
        }
        
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.page.currentPage = targetIndex
    }
    

    
    
    
}




extension BuySellProductDetailsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           return arrRelatedProduct.count

       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblview{
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "BuycategoryCell") as! BuycategoryCell
           
           cell.selectionStyle = .none
                   
           cell.stkviw.isHidden = true
               
            if arrRelatedProduct[indexPath.row].productsimages != nil {
                if arrRelatedProduct[indexPath.row].productsimages!.count > 0{
                    if arrRelatedProduct[indexPath.row].productsimages?[0].attachment != nil
                      {
                          cell.imgProduct.sd_setImage(with: URL(string: (arrRelatedProduct[indexPath.row].productsimages?[0].attachment!)!), placeholderImage: UIImage(named: "ic_bg_buy"))
                        }else{
                            cell.imgProduct.image = UIImage(named: "ic_bg_buy")
                        }
                  }else{
                    cell.imgProduct.image = UIImage(named: "ic_bg_buy")
                }
            }else{
                cell.imgProduct.image = UIImage(named: "ic_bg_buy")
            }
                  
                  //            let rupee = "\u{20B9}"
        cell.lblPrice.text = "\u{20B9} "+"\(arrRelatedProduct[indexPath.row].amount!)"//"\(arrRelatedProduct[indexPath.row].amount!)"
            //String(format: "\u{20B9} %@", arrRelatedProduct[indexPath.row].amount!)
        cell.lblName.text = arrRelatedProduct[indexPath.row].title
                  
        cell.lblQuality.text = arrRelatedProduct[indexPath.row].qualityStatus

                  
        cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
        
        
           return cell
        
        }else{
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "BuycategoryCell") as! BuycategoryCell

                    
//                    if strType == "1"{
//                        cell.stkviw.isHidden = true
//                    }else{
        //                if UsermeResponse?.data?.relation == "self"{
                            cell.btnEdit.tag = indexPath.row
                            cell.btnDelete.tag = indexPath.row
                       // }
                 //   }
                    
            if arrRelatedProduct[indexPath.row].productsimages != nil {
                    if arrRelatedProduct[indexPath.row].productsimages!.count > 0{
                        if arrRelatedProduct[indexPath.row].productsimages?[0].attachment != nil
                        {
                            
                            cell.imgProduct.sd_setImage(with: URL(string: (arrRelatedProduct[indexPath.row].productsimages?[0].attachment!)!), placeholderImage: UIImage(named: "ic_bg_buy"))
                            
                        }else{
                            cell.imgProduct.image = UIImage(named: "ic_bg_buy")
                        }
                    }else{
                        cell.imgProduct.image = UIImage(named: "ic_bg_buy")
                    }
            }else{
                cell.imgProduct.image = UIImage(named: "ic_bg_buy")
            }
              
                    
                    cell.lblPrice.text = "\u{20B9} "+"\(arrRelatedProduct[indexPath.row].amount!)" // "\(arrRelatedProduct[indexPath.row].amount!)"
            // String(format: "\u{20B9} %@", arrRelatedProduct[indexPath.row].amount!)
                    cell.lblName.text = arrRelatedProduct[indexPath.row].title
                    
                    cell.btnDelete.addTarget(self, action: #selector(actionDelete(sender:)), for: .touchUpInside)
                    cell.btnEdit.addTarget(self, action: #selector(actionEdit(sender:)), for: .touchUpInside)
                    
                    
                    return cell
                }
           
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            if tableView == tblview {
                    
                    if #available(iOS 13.0, *) {
                        let vc = self.storyboard?.instantiateViewController(identifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
                        vc.arrProductDetails = arrRelatedProduct[indexPath.row]
                                  vc.CategoryId = (arrRelatedProduct[indexPath.row].productCategoryID!) //as NSNumber).stringValue
                        
                        vc.ProductID = (arrRelatedProduct[indexPath.row].productID!)

                                 // vc.ProductID = (!(arrRelatedProduct[indexPath.row].productID != nil) as NSNumber).stringValue
                        vc.strCategoryName = arrRelatedProduct[indexPath.row].title! // productCategoryName!
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuySellProductDetailsVC") as! BuySellProductDetailsVC
                        vc.arrProductDetails = arrRelatedProduct[indexPath.row]
                                  vc.CategoryId = (arrRelatedProduct[indexPath.row].productCategoryID!) // as NSNumber).stringValue
                        
                        vc.ProductID = (arrRelatedProduct[indexPath.row].productID!)

                                //  vc.ProductID = (!(arrRelatedProduct[indexPath.row].productID != nil) as NSNumber).stringValue
                                  self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
            }
        
        }
       
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableViewAutomaticDimension
       }

    
    
    
    
}
