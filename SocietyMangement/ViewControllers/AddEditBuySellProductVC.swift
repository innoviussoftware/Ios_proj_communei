//
//  AddEditBuySellProductVC.swift
//  SocietyMangement
//
//  Created by MacMini on 20/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SkyFloatingLabelTextField
import Alamofire

class AddEditBuySellProductVC: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate,UITextViewDelegate{
    @IBOutlet weak var btnUpdate: UIButton!
    
    
    @IBOutlet weak var txtperice: SkyFloatingLabelTextField!
    @IBOutlet weak var lblTitel: UILabel!
    
    @IBOutlet weak var txttitel: SkyFloatingLabelTextField!
    
    @IBOutlet weak var imgUploadStatic: UIImageView!
    
    @IBOutlet weak var collectionImg: UICollectionView!
    
    @IBOutlet weak var constraintHightCollection: NSLayoutConstraint!
    
    @IBOutlet weak var txtDescription: IQTextView!
    
    @IBOutlet weak var txtItemCondition: SkyFloatingLabelTextField!
    
    @IBOutlet weak var viewCamera: UIView!

    var arrItemCondition = NSMutableArray()
    var arrproductImg = NSMutableArray()
    
    
    var picker : UIPickerView!
    var selectedCondition : Int! = 0
    var activeTexfield : UITextField!
    var strCategoryID = ""
    var strProductId = ""
    
    var arrRecommendData : BuySellProductListData!
    var arrEditProductImg = NSMutableArray()//[Productsimage]()
    var arrdummyEditImg = NSMutableArray()
    var isEditProdcut : Bool! = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtDescription.text = "Type here"
//        txtDescription.textColor = UIColor.lightGray
        
        txtperice.placeholder = "Price(\u{20B9})"
        txtItemCondition.text = "Brand New"
        
        
        
        arrItemCondition = ["Brand New","Like New","Very Good","Good"]
        
        
        txtItemCondition.addTarget(self, action: #selector(openPicker(txt:)), for: .editingDidBegin)
        txtItemCondition.addDoneOnKeyboardWithTarget(self, action: #selector(DoneItemSelection), shouldShowPlaceholder: true)
        setrightviewnew(textfield:txtItemCondition, image: #imageLiteral(resourceName: "down-1"))
        
        collectionImg.register(UINib.init(nibName: "ProductAddImgCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProductAddImgCollectionCell")
        
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                      verticalAlignment: .center)
              
        collectionImg.collectionViewLayout = alignedFlowLayout
        
        constraintHightCollection.constant = 0
        
    self.collectionImg.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

               if isEditProdcut == false{
                lblTitel.text = "Add Details" // "Include Some Details"
                btnUpdate.setTitle("SELL NOW", for: .normal)
               }else{
                btnUpdate.setTitle("UPDATE", for: .normal)
                lblTitel.text = "Update Details" // "Update Item Details"
                   txttitel.text = arrRecommendData.title
                   txtperice.text = arrRecommendData.price
                   txtItemCondition.text = arrRecommendData.quality
                   txtDescription.text = arrRecommendData.datumDescription
                
                for img in arrRecommendData.productsimages!{
                    let str =  webservices().imgurl + img.image!
                    let img = UIImageView()
                    img.sd_setImage(with: URL(string:str), placeholderImage: UIImage(named: "vendor-1"))
                    arrEditProductImg.add(img.image!)
                }
                
                collectionImg.reloadData()
                
//
//
//                   arrEditProductImg = arrRecommendData.productsimages!
                   
               }
               
        viewCamera.isHidden = true
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)

    }
    
    @objc func tapviewCameraimage() {
           viewCamera.isHidden = true
       }
    
    @IBAction func btnCameraClicked(_ sender: Any) {
           
           viewCamera.isHidden = false
           
       }

       @IBAction func btnOpenCameraClicked(_ sender: Any) {
              
           viewCamera.isHidden = true
           
           camera()
              
       }
       
       @IBAction func btnOpenGalleryClicked(_ sender: Any) {
              
           viewCamera.isHidden = true
           
           photoLibrary()
              
       }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        collectionImg.layer.removeAllAnimations()
        constraintHightCollection.constant = collectionImg.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.view.layoutIfNeeded()
        }

    }
    
    
    
    @objc func openPicker(txt:UITextField!) {
        activeTexfield = txt
        
        if (picker != nil){
            picker.removeFromSuperview()
        }
        
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        
        activeTexfield.inputView = picker
        picker.backgroundColor = .white
        
    }
    
    @objc func DoneItemSelection() {
        txtItemCondition.text = arrItemCondition[selectedCondition] as? String
        txtItemCondition.resignFirstResponder()
    }
    
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         if let originalimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           
            if isEditProdcut == false{
                arrproductImg.add(originalimage)
            }else{
                arrEditProductImg.add(originalimage)
                arrdummyEditImg.add(originalimage)
            }
           collectionImg.reloadData()
           
        }
        
         dismiss(animated: true, completion: nil)
    }
    //MARK:-User define functions
    
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        myPickerController.mediaTypes = ["public.image"]
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myPickerController.mediaTypes = ["public.image"]
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   /* @IBAction func actionUpload(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    } */
    
    @IBAction func actionSellNow(_ sender: Any) {
        
        if !txttitel.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please enter titel")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtperice.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please enter price")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtItemCondition.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select item condition")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtDescription.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please enter description")
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            if isEditProdcut == false{
                if arrproductImg.count == 0{
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select minimum 1 photo of item")
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    apicallAddProduct()
                }
            }else{
                if arrEditProductImg.count == 0{
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select minimum 1 photo of item")
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                  apicallUpdateProduct()
                }
            }
            
             
        }
    }
    
    //MARK:- textView delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type here"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    @objc func DeleteImage(sender:UIButton) {
        
        if isEditProdcut == false{
            if arrproductImg.count > 0{
                       arrproductImg.removeObject(at: sender.tag)
                       collectionImg.reloadData()
                       constraintHightCollection.constant = collectionImg.contentSize.height
                   }
        }else{
            if arrEditProductImg.count > 0{
                       arrEditProductImg.removeObject(at: sender.tag)
                       collectionImg.reloadData()
                       constraintHightCollection.constant = collectionImg.contentSize.height
                   }
        }
       
    }
    
    
       func setrightviewnew(textfield: UITextField ,image:UIImage)
       {
           let imageView = UIImageView.init(image: image)
           imageView.isUserInteractionEnabled = true
           imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
           let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
           
           view.addSubview(imageView)
           textfield.rightViewMode = UITextFieldViewMode.always
           
           textfield.rightView = view
       }
       
    
    
    // MARK: - Add notice
    
   func apicallAddProduct() {
       
    
    let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
    
    let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
    let strSociId  = (SociId as NSNumber).stringValue
    
    
       webservices().StartSpinner()
       let param : Parameters = [
           "category_id":strCategoryID,
           "title":txttitel.text!,
           "price":txtperice.text!,
           "description":txtDescription.text!,
           "quality":txtItemCondition.text!,
           "society_id":strSociId
       ]
       
       AF.upload(
           multipartFormData: { MultipartFormData in
               
               for (key, value) in param {
                   MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
               }
            
            if self.isEditProdcut == false{
                for img in self.arrproductImg{
                                                       let date = Date()
                                                       let formatter = DateFormatter()
                                                       formatter.dateFormat = "yyyyMMddHHmmss"
                                                       let strFileName = formatter.string(from: date)
                                                       
                                                        let imgData = UIImageJPEGRepresentation(img as! UIImage, 0.2)!
                                                        
                                                         MultipartFormData.append(imgData, withName: "product_photos[]", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                                                       
                                                    }
                
               }else{
                
                for img in self.arrdummyEditImg{
                                                       let date = Date()
                                                       let formatter = DateFormatter()
                                                       formatter.dateFormat = "yyyyMMddHHmmss"
                                                       let strFileName = formatter.string(from: date)
                                                       
                                                        let imgData = UIImageJPEGRepresentation(img as! UIImage, 0.2)!
                                                        
                                                         MultipartFormData.append(imgData, withName: "product_photos[]", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                                                       
                                                    }
                
            }
            
               
               
       }, to:  webservices().baseurl + API_ADD_PRODUCT,headers:["Accept": "application/json","Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
           //Current upload progress of file
           
           
           print("Upload Progress: \(progress.fractionCompleted)")
       })
           .responseJSON (completionHandler: { (response:DataResponse<Any>) in
               
               webservices().StopSpinner()
               let statusCode = response.response?.statusCode
               switch(response.result) {
               case .success(let resp):
                   if statusCode == 200{
                       print(resp)
                    
                    self.txttitel.text = ""
                    self.txtperice.text = ""
                    self.txtItemCondition.text = ""
                    self.txtDescription.text = "Type here"
                    self.txtDescription.textColor = UIColor.lightGray
                    self.arrEditProductImg.removeAllObjects()
                    self.collectionImg.reloadData()
                    
                    // create the alert
                    let alert = UIAlertController(title: Alert_Titel, message:"Product added for sell successfully" , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                                    self.navigationController?.popViewController(animated: true)
                                               }))
                                              // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                    
              
                       
                   }else{
                       let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:(response.result.value as! NSDictionary).value(forKey:"message") as! String)
                       self.present(alert, animated: true, completion: nil)
                   }
                   
                   break
               case .failure(let err):
                   print(err.localizedDescription)
                   break
                   
               }
               
           })
       
   }
    
    
    
    func apicallUpdateProduct() {
          
          let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
        
           let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
           let strSociId  = (SociId as NSNumber).stringValue
        
          webservices().StartSpinner()
          let param : Parameters = [
              "product_id":strProductId,
              "category_id":strCategoryID,
              "title":txttitel.text!,
              "price":txtperice.text!,
              "description":txtDescription.text!,
              "quality":txtItemCondition.text!,
              "society_id":strSociId
          ]
          
          AF.upload(
              multipartFormData: { MultipartFormData in
                  
                  for (key, value) in param {
                      MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
                  }
               
               if self.isEditProdcut == false{
                   for img in self.arrproductImg{
                                                          let date = Date()
                                                          let formatter = DateFormatter()
                                                          formatter.dateFormat = "yyyyMMddHHmmss"
                                                          let strFileName = formatter.string(from: date)
                                                          
                                                           let imgData = UIImageJPEGRepresentation(img as! UIImage, 0.2)!
                                                           
                                                            MultipartFormData.append(imgData, withName: "product_photos[]", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                                                          
                                                       }
                   
                  }else{
                   
                   for img in self.arrdummyEditImg{
                                                          let date = Date()
                                                          let formatter = DateFormatter()
                                                          formatter.dateFormat = "yyyyMMddHHmmss"
                                                          let strFileName = formatter.string(from: date)
                                                          
                                                           let imgData = UIImageJPEGRepresentation(img as! UIImage, 0.2)!
                                                           
                                                            MultipartFormData.append(imgData, withName: "product_photos[]", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                                                          
                                                       }
                   
               }
               
                  
                  
          }, to:  webservices().baseurl + API_BUY_SELL_PRODUCT_EDIT,headers:["Accept": "application/json","Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
              //Current upload progress of file
              
              
              print("Upload Progress: \(progress.fractionCompleted)")
          })
              .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                  
                  webservices().StopSpinner()
                  let statusCode = response.response?.statusCode
                  switch(response.result) {
                  case .success(let resp):
                      if statusCode == 200{
                          print(resp)
                       
                       self.txttitel.text = ""
                       self.txtperice.text = ""
                       self.txtItemCondition.text = ""
                       self.txtDescription.text = "Type here"
                       self.txtDescription.textColor = UIColor.lightGray
                       self.arrEditProductImg.removeAllObjects()
                       self.collectionImg.reloadData()
                       
                       // create the alert
                       let alert = UIAlertController(title: Alert_Titel, message:"Product added for sell successfully" , preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                                       self.navigationController?.popViewController(animated: true)
                                                  }))
                                                 // show the alert
                       self.present(alert, animated: true, completion: nil)
                       
                       
                          
                      }else{
                          let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:(response.result.value as! NSDictionary).value(forKey:"message") as! String)
                          self.present(alert, animated: true, completion: nil)
                      }
                      
                      break
                  case .failure(let err):
                      print(err.localizedDescription)
                      break
                      
                  }
                  
              })
          
      }
   
    
    
    
}


extension AddEditBuySellProductVC : UIPickerViewDelegate,UIPickerViewDataSource{
    
    // MARK: - pickerview delegate and data source methods
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrItemCondition.count
        
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrItemCondition[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCondition = row
        
    }
    
    
    
}


extension AddEditBuySellProductVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isEditProdcut == false{
        return arrproductImg.count
        }else{
         return arrEditProductImg.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductAddImgCollectionCell", for: indexPath) as! ProductAddImgCollectionCell
        cell.btnClose.tag = indexPath.row
        cell.imgProduct.contentMode = .scaleAspectFit
        
        if isEditProdcut == false{
        cell.imgProduct.image = arrproductImg[indexPath.row] as? UIImage
        cell.btnClose.addTarget(self, action: #selector(DeleteImage(sender:)), for: .touchUpInside)
        
        return cell
        }else{
            
            cell.imgProduct.image = arrEditProductImg[indexPath.row] as? UIImage
//            if(arrEditProductImg[indexPath.row].image != nil)
//                   {
//                    cell.imgProduct.sd_setImage(with: URL(string:webservices().imgurl + arrEditProductImg[indexPath.row].image!), placeholderImage: UIImage(named: "vendor-1"))
//                   }
            
            cell.btnClose.addTarget(self, action: #selector(DeleteImage(sender:)), for: .touchUpInside)
        
          return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        //return CGSize(width: 100, height: 128)
        return  CGSize(width: collectionWidth/3, height: 107)
        
    }
    
    
    
    
    
    
}
