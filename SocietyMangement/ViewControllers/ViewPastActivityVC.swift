//
//  ViewPastActivityVC.swift
//  SocietyMangement
//
//  Created by Innovius on 21/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire
@available(iOS 13.0, *)
class ViewPastActivityVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tblview: UITableView!
    var arrGuestList = [guestData]()
    
    @IBOutlet weak var lblnoproperty: UILabel!
    @IBOutlet weak var innerview: UIView!
    
    @IBAction func PastAction(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
        }) { (true) in
            self.view.removeFromSuperview()
          self.removeFromParentViewController()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apicallGuestList()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
              view.addGestureRecognizer(gesture)

//
//            lblnoproperty.text = "No Gated Activity Found"
//             lblnoproperty.font =  UIFont(name:"Lato-Regular", size:20.0)!
//            lblnoproperty.textColor = UIColor.darkGray
//             lblnoproperty.textAlignment = .center
//             lblnoproperty.isHidden = true
//             lblnoproperty.frame = CGRect(x:0, y: self.view.frame.height, width: self.view.frame.width, height: 40)
//             self.innerview.addSubview(lblnoproperty)
//             self.innerview.bringSubview(toFront:lblnoproperty)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @objc func panGesture(recognizer: UIPanGestureRecognizer){
          let translation = recognizer.translation(in: self.view)
          let y = self.view.frame.minY
          
          if (y + translation.y) <= 0{
              return
          }
          
          self.view.frame =  CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
          recognizer.setTranslation(.zero, in: self.view)
          
          if recognizer.state == .began {
          } else if recognizer.state == .ended {
              if y > (view.frame.size.height/2){
                  
                  UIView.animate(withDuration: 0.3, animations: {
                      self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
                  }) { (true) in
                      self.view.removeFromSuperview()
                    self.removeFromParentViewController()
                  }
                  
              }else{
                  
                  UIView.animate(withDuration: 0.2) {
                   self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                  }
              }
          }
      }
  
    //MARK:- tableView method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return arrGuestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"GuestListCell", for: indexPath) as! GuestListCell
        
        cell.imgUser.layer.cornerRadius =  cell.imgUser.frame.size.height/2
        cell.imgUser.clipsToBounds = true
        //        2019-10-01 05:41:53"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.imgUser.isUserInteractionEnabled = true
                       
                   let tap = UITapGestureRecognizer()
                       tap.addTarget(self, action:#selector(tapguest))
                       cell.imgUser.addGestureRecognizer(tap)
                       cell.imgUser.tag = indexPath.row
        if arrGuestList[indexPath.row].type == "1"{
            if arrGuestList[indexPath.row].inOutFlag == 0{
                
            }else if arrGuestList[indexPath.row].inOutFlag == 1{ //in
                cell.lblTime.isHidden = true
                cell.viewDecline.isHidden = false
                cell.AcceptView.isHidden = false
                cell.lblOutTime.isHidden = true
                cell.btnWaiting.text = "INVITED"
                cell.btnWaiting.backgroundColor = AppColor.appcolor
                cell.lblName.text = arrGuestList[indexPath.row].name
                
                cell.imgUser.sd_setImage(with: URL(string:  arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                cell.btnGuestWaitingIcon.isHidden = true
                
                
                cell.btnAccept.isHidden = true
                cell.btnOut.isHidden = false
                
                cell.btnDecline.setTitle("Delete", for: .normal)
                cell.btnOut.setTitle("OUT", for: .normal)
                cell.btnOut.backgroundColor = AppColor.orangeColor
                cell.btnOut.layer.cornerRadius = 8
                cell.btnOut.clipsToBounds = true
                
                cell.lblStack.isHidden = false
                cell.btnDecline.tag = indexPath.row
                
                cell.btnOut.tag = indexPath.row
                
                cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
                
                                                    
                cell.btnOut.addTarget(self, action: #selector(OutguestByMember(sender:)), for: .touchUpInside)
                
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                
                var attributedString1 = NSMutableAttributedString()
                
                if arrGuestList[indexPath.row].intime != nil ||  arrGuestList[indexPath.row].intime != ""{
                    cell.lblINTIme.isHidden = false
                    cell.lblGuestWaiting.isHidden = true
                    let dateFormaINOUT = DateFormatter()
                    dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                    //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                    let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                    //let timeInterval = date!.timeIntervalSinceNow
                    //print("=========>\(dayDifference(from: timeInterval))")
                    
                    if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                        let formater = DateFormatter()
                        formater.dateFormat = "hh:mm a"
                        let strIN = formater.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Today, %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblINTIme.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                    }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                        let format = DateFormatter()
                        format.dateFormat = "hh:mm a"
                        let strIN = format.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday, %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblINTIme.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                    }else{
                        dateFormaINOUT.dateFormat = "dd-MMM-yy HH:mm a"
                        let strIN = dateFormaINOUT.string(from: date!)
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblINTIme.attributedText = attributedString1
                        
                        //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                    }
                    
                }else{
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    //cell.lblINTIme.isHidden = true
                    cell.lblGuestWaiting.isHidden = true
                }
                
            }else{ //in and OUT both
                           cell.lblTime.isHidden = true
                           cell.viewDecline.isHidden = false
                           cell.AcceptView.isHidden = true
                           cell.btnWaiting.text = "INVITED"
                cell.btnWaiting.backgroundColor = AppColor.appcolor
                           cell.lblName.text = arrGuestList[indexPath.row].name
                           
                           cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                           cell.btnGuestWaitingIcon.isHidden = true
                           
                           cell.btnDecline.setTitle("Delete", for: .normal)
                           cell.lblStack.isHidden = true
                            cell.btnDecline.tag = indexPath.row
                            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
                           
                           let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                           let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                           
                           var attributedString1 = NSMutableAttributedString()
                           
                           if arrGuestList[indexPath.row].intime != nil || arrGuestList[indexPath.row].intime != "" {
                               cell.lblINTIme.isHidden = false
                               cell.lblGuestWaiting.isHidden = true
                               let dateFormaINOUT = DateFormatter()
                               dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                               //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                               let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                               //let timeInterval = date!.timeIntervalSinceNow
                               //print("=========>\(dayDifference(from: timeInterval))")
                               
                               if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                                   let formater = DateFormatter()
                                   formater.dateFormat = "hh:mm a"
                                   let strIN = formater.string(from: date!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                                   let attributedString2 = NSMutableAttributedString(string:String(format: "Today, %@", strIN), attributes:attrs2)
                                   attributedString1.append(attributedString2)
                                   cell.lblINTIme.attributedText = attributedString1
                                   
                                   // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                               }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                                   let format = DateFormatter()
                                   format.dateFormat = "hh:mm a"
                                   let strIN = format.string(from: date!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                                   let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday, %@", strIN), attributes:attrs2)
                                   attributedString1.append(attributedString2)
                                   cell.lblINTIme.attributedText = attributedString1
                                   
                                   // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                               }else{
                                   dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                                   let strIN = dateFormaINOUT.string(from: date!)
                                   attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                                   let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                                   attributedString1.append(attributedString2)
                                   cell.lblINTIme.attributedText = attributedString1
                                   
                                   //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                               }
                               
                           }else{
                               attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                               let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                               attributedString1.append(attributedString2)
                               cell.lblINTIme.attributedText = attributedString1
                               cell.lblGuestWaiting.isHidden = true
                           }
                           
                           
                           
                           if arrGuestList[indexPath.row].outtime != nil || arrGuestList[indexPath.row].outtime != "" {
                               cell.lblOutTime.isHidden = false
                               cell.lblGuestWaiting.isHidden = true
                               let dateFormaINOUT = DateFormatter()
                               dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                               // dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                               let dates = dateFormaINOUT.date(from: arrGuestList[indexPath.row].outtime!)
                               
                               if dayDifference(from: 0000, date: dates! as NSDate) == "Today"{
                                   let formateee = DateFormatter()
                                   formateee.dateFormat = "hh:mm a"
                                   let strOut = formateee.string(from: dates!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                                   let attributedString3 = NSMutableAttributedString(string:String(format: "Today ,%@ ", strOut), attributes:attrs2)
                                   attributedString1.append(attributedString3)
                                   cell.lblOutTime.attributedText = attributedString1
                                   
                                   //cell.lblOutTime.text = String(format: "OUT: %@ Today", strOut)
                               }else if dayDifference(from: 0000, date: dates! as NSDate) == "Yesterday"{
                                   let formateees = DateFormatter()
                                   formateees.dateFormat = "hh:mm a"
                                   let strOut = formateees.string(from: dates!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                                   let attributedString3 = NSMutableAttributedString(string:String(format: "Yesterday ,%@ ", strOut), attributes:attrs2)
                                   attributedString1.append(attributedString3)
                                   cell.lblOutTime.attributedText = attributedString1
                                   
                                   //cell.lblOutTime.text = String(format: "OUT: %@ Yesterday", strOut)
                               }else{
                                   dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                                   let strOut = dateFormaINOUT.string(from: dates!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                                   let attributedString3 = NSMutableAttributedString(string:String(format: "%@", strOut), attributes:attrs2)
                                   attributedString1.append(attributedString3)
                                   cell.lblOutTime.attributedText = attributedString1
                                   //cell.lblOutTime.text = String(format: "OUt: %@", strOut)
                               }
                               
                           }else{
                               attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                               let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                               attributedString1.append(attributedString2)
                               cell.lblOutTime.attributedText = attributedString1
                               //cell.lblOutTime.text = "00:00 PM"
                               cell.lblGuestWaiting.isHidden = true
                           }
            }
            
            
        }else{
        
        if arrGuestList[indexPath.row].flag == 0 && arrGuestList[indexPath.row].inOutFlag == 0{ //IN
             cell.btnAccept.isHidden = false
             cell.btnOut.isHidden = true
            
            cell.lblINTIme.isHidden = false
            cell.lblOutTime.isHidden = true
            cell.lblTime.isHidden = true
            cell.btnDecline.tag = indexPath.row
            cell.btnAccept.tag = indexPath.row
            cell.lblStack.isHidden = false
            cell.btnGuestWaitingIcon.isHidden = false
            cell.lblGuestWaiting.isHidden = false
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = false
            cell.btnWaiting.text = "WAITING"
            cell.lblGuestWaiting.text = "Guest is waiting at gate"
            cell.btnWaiting.backgroundColor = AppColor.appcolor
            cell.lblName.text = arrGuestList[indexPath.row].name
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
            dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
            cell.lblINTIme.text = dateFormatterGet.string(from: date!)
            cell.btnDecline.setTitle("Decline", for: .normal)
            
             cell.btnDecline.removeTarget(self, action: #selector(DeleteGuest(sender:)), for: .allEvents)
             cell.btnAccept.removeTarget(self, action: #selector(OutguestByMember(sender:)), for: .allEvents)
            
            cell.btnAccept.addTarget(self, action: #selector(aceeptRequest(sender:)), for: .touchUpInside)
            cell.btnDecline.addTarget(self, action: #selector(DeclineRequest(sender:)), for: .touchUpInside)
            
        }else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 0{ //approve but not IN
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = true
            cell.btnWaiting.text = "APPROVED"
            cell.btnWaiting.backgroundColor = UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            cell.lblGuestWaiting.isHidden = true
            
             cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.lblStack.isHidden = true
            
            cell.btnDecline.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            
            let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
            dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
            cell.lblINTIme.text = dateFormatterGet.string(from: date!)
            
            cell.lblINTIme.isHidden = false
            cell.lblTime.isHidden = true
            cell.lblOutTime.isHidden = true
           
            
        }else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 1{ //approve and IN
            
            cell.lblTime.isHidden = true
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = false
            cell.lblOutTime.isHidden = true
            cell.btnWaiting.text = "APPROVED"
            cell.btnWaiting.backgroundColor = UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            
            cell.btnAccept.isHidden = true
            cell.btnOut.isHidden = false
            
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.btnOut.setTitle("OUT", for: .normal)
            cell.btnOut.backgroundColor = UIColor(red: 249.0/255.0, green: 164.0/255.0, blue: 49.0/255.0, alpha: 1)
            cell.btnOut.layer.cornerRadius = 8
            cell.btnOut.clipsToBounds = true
            
            
            cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            cell.btnOut.removeTarget(self, action: #selector(aceeptRequest(sender:)), for: .allEvents)
            
            cell.lblStack.isHidden = false
            cell.btnDecline.tag = indexPath.row
            cell.btnOut.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            cell.btnOut.addTarget(self, action: #selector(OutguestByMember(sender:)), for: .touchUpInside)
            
            let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
            let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
            
            var attributedString1 = NSMutableAttributedString()
            
            if arrGuestList[indexPath.row].intime != nil ||  arrGuestList[indexPath.row].intime != ""{
                cell.lblINTIme.isHidden = false
                cell.lblGuestWaiting.isHidden = true
                let dateFormaINOUT = DateFormatter()
                dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                //let timeInterval = date!.timeIntervalSinceNow
                //print("=========>\(dayDifference(from: timeInterval))")
                
                if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                    let formater = DateFormatter()
                    formater.dateFormat = "hh:mm a"
                    let strIN = formater.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Today, %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                    let format = DateFormatter()
                    format.dateFormat = "hh:mm a"
                    let strIN = format.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday, %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                }else{
                    dateFormaINOUT.dateFormat = "dd-MMM-yy HH:mm a"
                    let strIN = dateFormaINOUT.string(from: date!)
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                }
                
            }else{
                
                attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                attributedString1.append(attributedString2)
                cell.lblINTIme.attributedText = attributedString1
                //cell.lblINTIme.isHidden = true
                cell.lblGuestWaiting.isHidden = true
            }
            
            
            
        }else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 2 { //approve and OUT
            cell.lblTime.isHidden = true
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = true
            cell.btnWaiting.text = "APPROVED"
            cell.btnWaiting.backgroundColor = UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            
            cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.lblStack.isHidden = true
            cell.btnDecline.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            
            let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
            let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
            
            var attributedString1 = NSMutableAttributedString()
            
            if arrGuestList[indexPath.row].intime != nil || arrGuestList[indexPath.row].intime != "" {
                cell.lblINTIme.isHidden = false
                cell.lblGuestWaiting.isHidden = true
                let dateFormaINOUT = DateFormatter()
                dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                //let timeInterval = date!.timeIntervalSinceNow
                //print("=========>\(dayDifference(from: timeInterval))")
                
                if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                    let formater = DateFormatter()
                    formater.dateFormat = "hh:mm a"
                    let strIN = formater.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Today, %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                    let format = DateFormatter()
                    format.dateFormat = "hh:mm a"
                    let strIN = format.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday, %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                }else{
                    dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                    let strIN = dateFormaINOUT.string(from: date!)
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                }
                
            }else{
                attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                attributedString1.append(attributedString2)
                cell.lblINTIme.attributedText = attributedString1
                cell.lblGuestWaiting.isHidden = true
            }
            
            
            
            if arrGuestList[indexPath.row].outtime != nil || arrGuestList[indexPath.row].outtime != "" {
                cell.lblOutTime.isHidden = false
                cell.lblGuestWaiting.isHidden = true
                let dateFormaINOUT = DateFormatter()
                dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                // dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                let dates = dateFormaINOUT.date(from: arrGuestList[indexPath.row].outtime!)
                
                if dayDifference(from: 0000, date: dates! as NSDate) == "Today"{
                    let formateee = DateFormatter()
                    formateee.dateFormat = "hh:mm a"
                    let strOut = formateee.string(from: dates!)
                    
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString3 = NSMutableAttributedString(string:String(format: "Today ,%@ ", strOut), attributes:attrs2)
                    attributedString1.append(attributedString3)
                    cell.lblOutTime.attributedText = attributedString1
                    
                    //cell.lblOutTime.text = String(format: "OUT: %@ Today", strOut)
                }else if dayDifference(from: 0000, date: dates! as NSDate) == "Yesterday"{
                    let formateees = DateFormatter()
                    formateees.dateFormat = "hh:mm a"
                    let strOut = formateees.string(from: dates!)
                    
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString3 = NSMutableAttributedString(string:String(format: "Yesterday ,%@ ", strOut), attributes:attrs2)
                    attributedString1.append(attributedString3)
                    cell.lblOutTime.attributedText = attributedString1
                    
                    //cell.lblOutTime.text = String(format: "OUT: %@ Yesterday", strOut)
                }else{
                    dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                    let strOut = dateFormaINOUT.string(from: dates!)
                    
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString3 = NSMutableAttributedString(string:String(format: "%@", strOut), attributes:attrs2)
                    attributedString1.append(attributedString3)
                    cell.lblOutTime.attributedText = attributedString1
                    //cell.lblOutTime.text = String(format: "OUt: %@", strOut)
                }
                
            }else{
                attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                attributedString1.append(attributedString2)
                cell.lblOutTime.attributedText = attributedString1
                //cell.lblOutTime.text = "00:00 PM"
                cell.lblGuestWaiting.isHidden = true
            }
            
            
            
        }else if arrGuestList[indexPath.row].flag == 2{ //Declined
            
            cell.lblTime.isHidden = true
            cell.lblOutTime.isHidden = true
            cell.lblINTIme.isHidden = true
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = true
            cell.btnWaiting.text = "Decline"
            cell.btnWaiting.backgroundColor =  UIColor.red //UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            cell.lblGuestWaiting.isHidden = true
            
             cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            
            
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.lblStack.isHidden = true
            cell.btnDecline.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            
        }
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if arrGuestList[indexPath.row].type == "1" && arrGuestList[indexPath.row].inOutFlag == 0{
        return 0
     }else{
       return UITableViewAutomaticDimension
    }
    }
    
    
    func dayDifference(from interval : TimeInterval , date : NSDate) -> String
    {
        let calendar = Calendar.current
        //let date = Date(timeIntervalSinceNow: interval)
        if calendar.isDateInYesterday(date as Date) { return "Yesterday" }
        else if calendar.isDateInToday(date as Date) { return "Today" }
        else if calendar.isDateInTomorrow(date as Date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date as Date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(-day) days ago" }
            else { return "In \(day) days" }
        }
    }
    
    
  
      
     @objc func aceeptRequest(sender:UIButton) {
            let strGuestId = arrGuestList[sender.tag].id
            ApiCallAccepGuest(type: 1, guestId: strGuestId!)
            
        }
        
        @objc func DeclineRequest(sender:UIButton) {
            let strGuestId = arrGuestList[sender.tag].id
            
            

            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                           let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                           avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
                           avc?.subtitleStr = "Are you sure you want to decline entry request?"
                           avc?.yesAct = {
                                                          self.ApiCallAccepGuest(type: 2, guestId: strGuestId!)

                               }
                           avc?.noAct = {
                             
                           }
                           present(avc!, animated: true)
            
//            let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to decline entry request?" , preferredStyle: UIAlertController.Style.alert)
//                   alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
//                    self.ApiCallAccepGuest(type: 2, guestId: strGuestId!)
//                   }))
//                   alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//                   self.present(alert, animated: true, completion: nil)
            
        }
        
      
        @objc func EditFrequentEntry(sender:UIButton) {
    //        let strType = arrFrequentGuestData[sender.tag].type
    //        let popup = self.storyboard?.instantiateViewController(withIdentifier: "EditFrequentEntryPopUp") as! EditFrequentEntryPopUp
    //        popup.strType = strType!
    //        let navigationController = UINavigationController(rootViewController: popup)
    //        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    //        self.present(navigationController, animated: true)
            
            
           }
        
        @objc func DeleteGuest(sender:UIButton) {
            let strType = arrGuestList[sender.tag].type!
            let strId = String(format: "%d", arrGuestList[sender.tag].id!)
            
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            
                            // 17/8/20.
            
                          // avc?.titleStr = "Society Buddy"
                         //  avc?.subtitleStr = "Are you sure want to delete this record?"
            
                            avc?.titleStr = "Delete Contact"
                            avc?.subtitleStr = "Are you sure you want to delete this contact?"
                           avc?.yesAct = {
                                                          self.apicallDeleteGuest(strType: strType, strId: strId)

                               }
                           avc?.noAct = {
                             
                           }
                           present(avc!, animated: true)
            
            
            
//
//
//            let alert = UIAlertController(title: Alert_Titel, message:"Are you sure want to delete this record?" , preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
//                self.apicallDeleteGuest(strType: strType, strId: strId)
//            }))
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        @objc func OutguestByMember(sender:UIButton) {
               let strType = arrGuestList[sender.tag].type!
               let strId = String(format: "%d", arrGuestList[sender.tag].id!)
               let strGurdId = String(format: "%d", arrGuestList[sender.tag].guard_id!)
               let strBuildingId = arrGuestList[sender.tag].buildingname!
               let strFlatId = arrGuestList[sender.tag].flatname!
            
            let date = Date()
            let formater = DateFormatter()
            formater.dateFormat = "dd-MM-yyyy hh:mm a"
            let outTime = formater.string(from: date)
            
               
            
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                              let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                              avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
                              avc?.subtitleStr = "Are you sure you want to OUT this guest?"
                              avc?.yesAct = {
  self.apicallOutMember(strGaurdID: strGurdId, strRequestId: strId, outTime: outTime, userTye: strType, strbuildingID: strBuildingId, strflatID: strFlatId, strType: "")
                                  }
                              avc?.noAct = {
                                
                              }
                              present(avc!, animated: true)
            
            
//               let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to OUT this guest?" , preferredStyle: UIAlertController.Style.alert)
//               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
//
//                self.apicallOutMember(strGaurdID: strGurdId, strRequestId: strId, outTime: outTime, userTye: strType, strbuildingID: strBuildingId, strflatID: strFlatId, strType: "")
//
//               }))
//               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//               self.present(alert, animated: true, completion: nil)
               
           }
        
    @objc func tapguest(sender:UITapGestureRecognizer)
     {
         
         let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "ImagePopUP") as! ImagePopUP
         otpVC.imgurl =  arrGuestList[sender.view!.tag].photos!
            self.addChildViewController(otpVC)
                   self.view.addSubview(otpVC.view)
                   let height = self.view.bounds.height
                   otpVC.view.frame = CGRect(x: 0, y: height, width: self.view.bounds.width, height: height)
                   
                   UIView.animate(withDuration: 0.4, animations: {
                       otpVC.view.frame = self.view.bounds
                   })
             
         
         
     }
     
    
      func apicallGuestList()
        {
              if !NetworkState().isInternetAvailable {
                             ShowNoInternetAlert()
                             return
                         }
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
                webservices().StartSpinner()
            Apicallhandler.sharedInstance.ApiCallGuestList(type:0, token: token as! String) { JSON in
                    
                    let statusCode = JSON.response?.statusCode
                    
                    switch JSON.result{
                    case .success(let resp):
                        webservices().StopSpinner()
                        if statusCode == 200{
                            
                            self.arrGuestList = resp.data!
                            if self.arrGuestList.count > 0{
                                self.tblview.dataSource = self
                                self.tblview.delegate = self
                                self.tblview.reloadData()
                                self.lblnoproperty.isHidden = true
                               self.tblview.isHidden = false

                            }else{
                                self.lblnoproperty.isHidden = false
                                self.tblview.isHidden = true


                            }
                            
                        }
                    case .failure(let err):
                        
                        webservices().StopSpinner()
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                        self.present(alert, animated: true, completion: nil)
                        print(err.asAFError)
                        
                        
                    }
                }
                
           
            
        }
      



    func ApiCallAccepGuest(type:Int,guestId : Int)
    {
        
        let strGuestId = (guestId as NSNumber).stringValue
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().ApiAcceptGuestRequest(URL: webservices().baseurl + API_ACCEPT_DECLINE, token: token as! String,type: type, guest_id: strGuestId) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    if(resp.status == 1)
                    {
                        self.apicallGuestList()
                    }else if (resp.status == 0){
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    
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
                    webservices().StopSpinner()
                    
                }
                
            }
     
    }
    
        
      func apicallDeleteGuest(strType:String , strId:String)
         {
              if !NetworkState().isInternetAvailable {
                              ShowNoInternetAlert()
                              return
                          }
                 let token = UserDefaults.standard.value(forKey: USER_TOKEN)
              let param : Parameters = [
                  "type" : strType,
                  "request_id" : strId
               ]
              
              webservices().StartSpinner()
              Apicallhandler.sharedInstance.ApiCallDeleteGuest(token: token as! String, param: param) { JSON in
                     
                     let statusCode = JSON.response?.statusCode
                     
                     switch JSON.result{
                     case .success(let resp):
                         //webservices().StopSpinner()
                         if statusCode == 200{
                          self.apicallGuestList()
                         }
                     case .failure(let err):
                         
                         webservices().StopSpinner()
                         let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                         self.present(alert, animated: true, completion: nil)
                         print(err.asAFError)
                         
                         
                     }
                 }
                 
         
             
         }
    
    
     func apicallOutMember(strGaurdID:String,strRequestId:String,outTime:String,userTye:String,strbuildingID:String,strflatID:String,strType:String)
        {
             if !NetworkState().isInternetAvailable {
                             ShowNoInternetAlert()
                             return
                         }
             let societyID = UserDefaults.standard.value(forKey: USER_SOCIETY_ID)
             let param : Parameters = [
                 "type" : "2",
                 "request_id" : strRequestId,
                 "outtime" : outTime,
                 "user_type" : userTye,
                 "society_id" : "\(societyID!)",
                 "guard_id" : strGaurdID,
                 "building_id" : strbuildingID,
                 "flat_id" : strflatID
                
              ]
             
             webservices().StartSpinner()
             Apicallhandler.sharedInstance.ApiCallOUTMember(token:"", param: param) { JSON in
                    
                    let statusCode = JSON.response?.statusCode
                    
                    switch JSON.result{
                    case .success(let resp):
                        //webservices().StopSpinner()
                        if statusCode == 200{
                         self.apicallGuestList()
                        }
                    case .failure(let err):
                        
                        webservices().StopSpinner()
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                        self.present(alert, animated: true, completion: nil)
                        print(err.asAFError as Any)
                        
                    }
                }
         
        }
     
     
     
    
    
    
}
