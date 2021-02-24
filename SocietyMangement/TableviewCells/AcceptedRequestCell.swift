//
//  AcceptedRequestswift
//  SocietyMangement
//
//  Created by innoviussoftware on 20/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
class AcceptedRequestCell: UITableViewCell {
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var imgviewCompanyLogo: UIImageView!

        
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblguest: UILabel!
    
    @IBOutlet weak var lbldateintime: UILabel!
    @IBOutlet weak var lbldateintimeMulti: UILabel!  // Extra
    @IBOutlet weak var lblintime: UILabel!
    @IBOutlet weak var lblouttime: UILabel!
    @IBOutlet weak var lbladdedby: UILabel!
    @IBOutlet weak var lblparceltime: UILabel!
    @IBOutlet weak var lblLeaveatGate: UILabel!
    @IBOutlet weak var lblcancelby: UILabel!
    @IBOutlet weak var lblWrongEntry: UILabel!

    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var btnInviteShare: UIButton!
    @IBOutlet weak var btncall: UIButton!

    @IBOutlet weak var btnExtraShow: UIButton!

    
    @IBOutlet weak var imgview1: UIImageView!
    @IBOutlet weak var imgview2: UIImageView!
    @IBOutlet weak var imgview3: UIImageView!
    @IBOutlet weak var imgview4: UIImageView!
    @IBOutlet weak var imgview5: UIImageView!
    @IBOutlet weak var imgview6: UIImageView!
    @IBOutlet weak var imgview7: UIImageView!
    @IBOutlet weak var imgview8: UIImageView!
    
    @IBOutlet weak var imgviewExtra: UIImageView!

   
    @IBOutlet weak var imgviewTop1: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop2: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop3: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop4: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop5: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop7: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop8: NSLayoutConstraint!

    @IBOutlet weak var imgviewTopExtra: NSLayoutConstraint!

    @IBOutlet weak var stackviewStatus: NSLayoutConstraint!

    
   /* @IBOutlet weak var imgviewBottom6: NSLayoutConstraint!
    
    @IBOutlet weak var imgviewTop3_1: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6_3: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6_1: NSLayoutConstraint!

    
    @IBOutlet weak var imgviewStackTop1: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop2: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop3: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop4: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop5: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop6: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop7: NSLayoutConstraint! */

    
    @IBOutlet weak var imgviewHight1: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight2: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight3: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight4: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight5: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight6: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight7: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight8: NSLayoutConstraint!

    @IBOutlet weak var imgviewHightExtra: NSLayoutConstraint!



    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnRenew: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnWrong_Entry: UIButton!
    @IBOutlet weak var btnWrong_Entry_Red: UIButton!

    @IBOutlet weak var btnNote_Guard: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    
    @IBOutlet weak var btnAlertInfo: UIButton!
    @IBOutlet weak var btnDeliveryInfo: UIButton!

    
    @IBOutlet weak var btnIn_OnDemand: UIButton! // Entry
    @IBOutlet weak var btnEdit_OnDemand: UIButton!
    @IBOutlet weak var btnCancel_OnDemand: UIButton!
    @IBOutlet weak var btnOut_OnDemand: UIButton!  // Exit

   // @IBOutlet weak var btnIn: UIButton!

    
    @IBOutlet weak var constraintHightStackBtn: NSLayoutConstraint!

    @IBOutlet weak var constraintHightStacklbl: NSLayoutConstraint!

    @IBOutlet weak var lblHightStacklblMiddle: UILabel!
    
    /*
       imgview1.isHidden = true   // time
       imgview2.isHidden = true   // intime
       imgview3.isHidden = true   // outtime
       imgview4.isHidden = true   // approvedby
       imgview5.isHidden = false   // addedby
       imgview6.isHidden = true   // parcel collection time
       imgview7.isHidden = true   // leave at gate
       imgview8.isHidden = true   // cancel by you
       imgview9.isHidden = true   // denied by you
       imgview10.isHidden = true  // No response
    */


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func strChangeDateFormate(strDateeee: String) -> String
    {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "dd MMM"
            return  dateFormatter.string(from: date!)
        
    }
    
    func strChangeTimeFormate(strDateeee: String) -> String
    {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "hh:mm a"
            return  dateFormatter.string(from: date!)

    }
    
    func setVisitorEntry(activity:ActivityAll,wrong:UserActivityAll) // Activity type Visitor
    {
            lblguest.text = "Visitor"
            
            imgviewCompanyLogo.isHidden = true
            if activity.name == "" || activity.name == nil {
               lblname.text = ""
            }else{
                lblname.text = activity.name
            }

           imgviewCompanyLogo.isHidden = true
            
            if activity.profilePic == "" || activity.profilePic == nil {
                imgview.image = UIImage(named: "vendor-1")
            }else{
                imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }
        
            lblStatus.isHidden = false
        
            if activity.addedBy != nil {
                lbladdedby.text = "Added by " + (activity.addedBy)!
                lbladdedby.isHidden = false
            }else {
                lbladdedby.isHidden = true
            }
           
            lblStatus.text = activity.status
                
        
            if lblStatus.text == "NOT RESPONDED" {
                lblStatus.backgroundColor = AppColor.cancelColor
             
                if activity.isMulti == "1" {
                    if activity.activityIn != nil {
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                     let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                     let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                     lblintime.isHidden = false
                     
                     lblintime.text = "\(strDate) - \(strDate1)"

                     // lblintime.text = strDate + " - " + strDate1
                 }else{
                     lblintime.isHidden = true
                 }
             }else {
                 
                 if activity.activityIn != nil {
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                          lblintime.isHidden = false
                     
                         lblintime.text = "\(strTime) - \(strDate)"

                        // lblintime.text = strTime + " , " + strDate
                 }else{
                     lblintime.isHidden = true
                 }
             }
             
                if wrong.isWrongEntry == 0 {
                    
                    // lblWrongEntry.isHidden = false

                     lblWrongEntry.text = "No Response"
                    
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true

                }else{
                    
                   // lblWrongEntry.isHidden = false

                    lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false

                }

                 
                    imgview1.isHidden = true
                    imgview2.isHidden = false
                    imgview3.isHidden = true
                    imgview4.isHidden = true
                    imgview5.isHidden = true
                    imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = false
                    imgviewExtra.isHidden = true
             
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = -12
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = 81.5
                     imgviewTopExtra.constant = -12

                     stackviewStatus.constant = 103.5

             
                 constraintHightStackBtn.constant = 50
                 constraintHightStacklbl.constant = 0.5
                 lblHightStacklblMiddle.isHidden = true
                 
                 lblWrongEntry.isHidden = false
                 lblintime.isHidden = false
                 
                 lbldateintime.isHidden = false
                 lbldateintimeMulti.isHidden = true // Extra
                 lblouttime.isHidden = true
                 lbladdedby.isHidden = true
                 lblparceltime.isHidden = true
                 lblLeaveatGate.isHidden = true
                 lblcancelby.isHidden = true

                 btnInviteShare.isHidden = true

                 btnExtraShow.isHidden = false
                

                btnCancel.isHidden = true
                btnEdit.isHidden = true
                
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            }
            else if lblStatus.text == "DENIED" {
             lblStatus.backgroundColor = AppColor.deniedColor

             
             if activity.isMulti == "1" {

                if activity.activityIn != nil {
                        let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                           
                       let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                       let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                       lblintime.isHidden = false
                     
                       lblintime.text = "\(strDate) - \(strDate1)"

                          // lblintime.text = strDate + " - " + strDate1
                   }else{
                       lblintime.isHidden = true
                   }
               }else{
            
            if activity.activityIn != nil {
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                   
                         lblintime.isHidden = false

                     lblintime.text = "\(strTime) , \(strDate)"

                 //   lblintime.text = strTime + " , " + strDate
            }else{
                lblintime.isHidden = true
            }
        }
             
             if activity.deniedBy != nil {
                 lblWrongEntry.text = "Denied by " + (activity.deniedBy)!
             }else {
                 lblWrongEntry.text = "Denied by "
             }
                
                if wrong.isWrongEntry == 0 {
                    // lblWrongEntry.isHidden = false
                    
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                }else{
                   // lblWrongEntry.isHidden = false

                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false
                }

                
                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = true
                 imgview4.isHidden = true
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                 imgview7.isHidden = true
                 imgview8.isHidden = false
                 imgviewExtra.isHidden = true

                 imgviewTop1.constant = -12
                 imgviewTop2.constant = 64.5
                 imgviewTop3.constant = -12
                 imgviewTop4.constant = -12
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = 81.5
                 imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5

          
                  constraintHightStackBtn.constant = 50
                  constraintHightStacklbl.constant = 0.5
                  lblHightStacklblMiddle.isHidden = true
                  
                  lblWrongEntry.isHidden = false
                 // lblintime.isHidden = false
                  
                  lbldateintime.isHidden = true
                    // lblintime.isHidden = false
                  lbldateintimeMulti.isHidden = true // Extra
                  lblouttime.isHidden = true
                  lbladdedby.isHidden = true
                  lblparceltime.isHidden = true
                  lblLeaveatGate.isHidden = true
                  lblcancelby.isHidden = true

                 btnInviteShare.isHidden = true

                 btnExtraShow.isHidden = false

                //  btnWrong_Entry.isHidden = false
                //  btnWrong_Entry_Red.isHidden = true

                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true

         }
         else if lblStatus.text == "CANCELLED" {
                                
             lblStatus.backgroundColor = AppColor.cancelColor
             
             if activity.isMulti == "1" {

                 if activity.activityIn != nil {
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                     let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                     let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                        lbldateintime.isHidden = false
                         lbldateintime.text = "\(strDate) - \(strDate1)"

                       //  lbldateintime.text =  strDate + " - " + strDate1
                 }else{
                     lbldateintime.isHidden = true
                 }
             }else{
          
                  if activity.activityIn != nil {
                          let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                          let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                          lbldateintime.isHidden = false
                        
                         lbldateintime.text = "\(strTime) , \(strDate)"

                         // lbldateintime.text = strTime + " , " + strDate
                  }else{
                      lbldateintime.isHidden = true
                  }
              }
                    
                lblcancelby.text = "Cancelled by " + (activity.cancelledBy)!
                                
                
                // 13/1/20 temp comment

              /*  imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 12
                imgviewHight5.constant = 0 */
             
            
            if wrong.isWrongEntry == 0 {
                
                imgview8.isHidden = true
                lblWrongEntry.isHidden = true

                imgviewTop8.constant = -12

                stackviewStatus.constant = 120.5
                  
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true


            }else{
                
                imgview8.isHidden = false

                lblWrongEntry.isHidden = false

                lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                
                imgviewTop8.constant = 115.5

                stackviewStatus.constant = 137.5

                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = false
                

            }
            
            
             lblintime.isHidden = true
             
           //  lbldateintime.isHidden = false
             lbldateintimeMulti.isHidden = true // Extra
             lblouttime.isHidden = true
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = false
                
             imgview1.isHidden = false
             imgview2.isHidden = true
             imgview3.isHidden = true
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
             imgview7.isHidden = false
             imgview8.isHidden = true
             imgviewExtra.isHidden = true
              
            
             imgviewTop1.constant = 64.5
             imgviewTop2.constant = -12
             imgviewTop3.constant = -12
             imgviewTop4.constant = 81.5
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = 98.5
           //  imgviewTop8.constant = -12
             imgviewTopExtra.constant = -12

            // stackviewStatus.constant = 120.5

                                
                constraintHightStackBtn.constant = 0
                constraintHightStacklbl.constant = 0
                lblHightStacklblMiddle.isHidden = true
                
                 btnInviteShare.isHidden = true
                btnExtraShow.isHidden = false

                 btnWrong_Entry.isHidden = true
                 btnWrong_Entry_Red.isHidden = true

                btnCancel.isHidden = true
                btnEdit.isHidden = true
                
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            }
         else if lblStatus.text == "EXPIRED" {
             lblStatus.backgroundColor = AppColor.cancelColor
            
            if activity.isMulti == "1" {

                if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                 let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                 let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                   lbldateintime.isHidden = false

                   lbldateintime.text = "\(strDate) - \(strDate1)"

             }else{
                 lbldateintime.isHidden = true
             }
         }else{
             
             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                      lbldateintime.isHidden = false
              
                      lbldateintime.text = "\(strTime) , \(strDate)"
              
             }else{
                 lbldateintime.isHidden = true
             }
         }
            
             // lbldateintime.isHidden = false
              lbldateintimeMulti.isHidden = true // Extra
              lblintime.isHidden = true
              lblouttime.isHidden = true
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = true
              lblWrongEntry.isHidden = true


             imgview1.isHidden = false
             imgview2.isHidden = true
             imgview3.isHidden = true
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
              imgview7.isHidden = true
              imgview8.isHidden = true
              imgviewExtra.isHidden = true
               
              imgviewTop1.constant = 64.5
              imgviewTop2.constant = -12
              imgviewTop3.constant = -12
              imgviewTop4.constant = 81.5
              imgviewTop5.constant = -12
              imgviewTop6.constant = -12
              imgviewTop7.constant = -12
              imgviewTop8.constant = -12
              imgviewTopExtra.constant = -12

              stackviewStatus.constant = 103.5
              
              
              constraintHightStackBtn.constant = 50
              constraintHightStacklbl.constant = 0.5
              lblHightStacklblMiddle.isHidden = true
              

              btnInviteShare.isHidden = true
              btnExtraShow.isHidden = false

             btnRenew.isHidden = false
             btnCancel.isHidden = true
             btnEdit.isHidden = true
             btnWrong_Entry.isHidden = true
             btnWrong_Entry_Red.isHidden = true
             btnClose.isHidden = true
             btnNote_Guard.isHidden = true
             btnOut.isHidden = true
             btnDeliveryInfo.isHidden = true
             btnAlertInfo.isHidden = true
             
         }
         else if lblStatus.text == "ADDED" {
        
             lblStatus.backgroundColor = AppColor.pollborderSelect

           if activity.isMulti == "1" {

             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                 let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                 let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                      lblintime.isHidden = false

                      lblintime.text = "\(strDate) - \(strDate1)"

                    // lblintime.text = strDate + " - " + strDate1
             }else{
                 lblintime.isHidden = true
             }
         }else{
             
             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                      lblintime.isHidden = false
                      lblintime.text = "\(strTime) , \(strDate)"

             }else{
                 lblintime.isHidden = true
             }
         }
            
          
            if wrong.isWrongEntry == 0 {
                
                imgview8.isHidden = true
                lblWrongEntry.isHidden = true

                imgviewTop8.constant = -12

                stackviewStatus.constant = 103.5
                  
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true


            }else{
                
                imgview8.isHidden = false

                lblWrongEntry.isHidden = false

                lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                
                imgviewTop8.constant = 98.5

                stackviewStatus.constant = 120.5

                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = false
                

            }

          lbldateintime.isHidden = true
         // lblintime.isHidden = false
          lblouttime.isHidden = true
          lbladdedby.isHidden = false
          lblparceltime.isHidden = true
          lblLeaveatGate.isHidden = true
          lblcancelby.isHidden = true
         // lblWrongEntry.isHidden = true
          lbldateintimeMulti.isHidden = true // Extra
            
          
          imgview1.isHidden = true
          imgview2.isHidden = false
          imgview3.isHidden = true
          imgview4.isHidden = false
          imgview5.isHidden = true
          imgview6.isHidden = true
           imgview7.isHidden = true
         //  imgview8.isHidden = true
           imgviewExtra.isHidden = true
          
          imgviewTop1.constant = -12
          imgviewTop2.constant = 64.5
          imgviewTop3.constant = -12
          imgviewTop4.constant = 81.5
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
         // imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

         // stackviewStatus.constant = 103.5
                             
             constraintHightStackBtn.constant = 50
             constraintHightStacklbl.constant = 0.5
             lblHightStacklblMiddle.isHidden = false
             
              btnInviteShare.isHidden = true
              btnExtraShow.isHidden = false

             
              btnOut.isHidden = false

             btnCancel.isHidden = true
             btnEdit.isHidden = true
             btnRenew.isHidden = true
             btnClose.isHidden = true
             btnNote_Guard.isHidden = true
             btnDeliveryInfo.isHidden = true
             btnAlertInfo.isHidden = true

         }
         else if lblStatus.text == "VISITED" {
             lblStatus.backgroundColor = AppColor.cancelColor
          
        
              if activity.activityIn != nil {
                      let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                      let strDate = strChangeDateFormate(strDateeee: lblDate!)
                      
                      let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                      let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     // lblintime.text = strTime + " , " + strDate
                  
                  lblintime.text = "\(strTime) , \(strDate)"

              }

          if activity.out != nil {
                      let lblDate = activity.out?.components(separatedBy: " ")[0]
                      let strDate = strChangeDateFormate(strDateeee: lblDate!)
                      
                      let lblTime = activity.out?.components(separatedBy: " ")[1]
                      
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                      lblouttime.text = "\(strTime) , \(strDate)"

                     // lblouttime.text = strDate + " , " + strTime
              }
           
             
             constraintHightStackBtn.constant = 50

             constraintHightStacklbl.constant = 0.5

             lblHightStacklblMiddle.isHidden = true
             
             // if wrong.isWrongEntry == 0 {
            if wrong.isWrongEntry == 0 {

                 lblWrongEntry.isHidden = true
                 imgview8.isHidden = true
                 
                 btnWrong_Entry.isHidden = false
                 btnWrong_Entry_Red.isHidden = true
              
              imgview1.isHidden = true
              imgview2.isHidden = false
              imgview3.isHidden = false
              imgview4.isHidden = false
              imgview5.isHidden = true
              imgview6.isHidden = true
               imgview7.isHidden = true
            //  imgview8.isHidden = true
               imgviewExtra.isHidden = true

              imgviewTop1.constant = -12
              imgviewTop2.constant = 64.5
              imgviewTop3.constant = 81.5
              imgviewTop4.constant = 98.5
              imgviewTop5.constant = -12
              imgviewTop6.constant = -12
              imgviewTop7.constant = -12
              imgviewTop8.constant = -12
              imgviewTopExtra.constant = -12

              stackviewStatus.constant = 120.5
                   

             }else{
                 lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                 lblWrongEntry.isHidden = false
                 imgview8.isHidden = false
                 
                 btnWrong_Entry_Red.isHidden = false
                 btnWrong_Entry.isHidden = true
              
              imgview1.isHidden = true
              imgview2.isHidden = false
              imgview3.isHidden = false
              imgview4.isHidden = false
              imgview5.isHidden = true
              imgview6.isHidden = true
               imgview7.isHidden = true
            //  imgview8.isHidden = true
               imgviewExtra.isHidden = true

              imgviewTop1.constant = -12
              imgviewTop2.constant = 64.5
              imgviewTop3.constant = 81.5
              imgviewTop4.constant = 98.5
              imgviewTop5.constant = -12
              imgviewTop6.constant = -12
              imgviewTop7.constant = -12
              imgviewTop8.constant = 115.5
              imgviewTopExtra.constant = -12

              stackviewStatus.constant = 137.5
                               

             }
             
             // 13/1/20 temp comment
             
            /* imgviewHight1.constant = 12
             imgviewHight2.constant = 0
             imgviewHight3.constant = 12
             imgviewHight4.constant = 0
             imgviewHight5.constant = 0 */

          lbldateintime.isHidden = true
          lblintime.isHidden = false
          lblouttime.isHidden = false
          lbladdedby.isHidden = false
          lblparceltime.isHidden = true
          lblLeaveatGate.isHidden = true
          lblcancelby.isHidden = true
        //  lblWrongEntry.isHidden = true
          lbldateintimeMulti.isHidden = true // Extra


          btnInviteShare.isHidden = true

          btnExtraShow.isHidden = false

              btnDeliveryInfo.isHidden = true
             btnCancel.isHidden = true
             btnEdit.isHidden = true
             btnRenew.isHidden = true
             btnClose.isHidden = true
             btnNote_Guard.isHidden = true
             btnOut.isHidden = true
             btnAlertInfo.isHidden = true

         }
         else if lblStatus.text == "APPROVED" {
             lblStatus.backgroundColor = AppColor.pollborderSelect
          
         /* if activity.activityIn != nil {
                  let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                  let strDate = strChangeDateFormate(strDateeee: lblDate!)
                  
                  let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                  let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                  lblintime.text = strTime + " , " + strDate
                  lblintime.isHidden = false
          }else{
              lblintime.isHidden = true
          } */
          
          if activity.isMulti == "1" {

             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                 let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                 let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
              lblintime.isHidden = false
              
              lblintime.text = "\(strDate) - \(strDate1)"


                    // lblintime.text = strDate + " - " + strDate1
             }else{
                 lblintime.isHidden = true
             }
         }else{
             
             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                    lblintime.isHidden = false
              
                      lblintime.text = "\(strTime) , \(strDate)"

                    // lblintime.text = strTime + " , " + strDate
             }else{
                 lblintime.isHidden = true
             }
         }
             
          if activity.approvedBy != nil {
              lbladdedby.text = "Approved by " + (activity.approvedBy)!
          }else {
              lbladdedby.text = "Approved by "
          }
            
            if wrong.isWrongEntry == 0 {
                lblWrongEntry.isHidden = true
                
                imgview8.isHidden = true
                
                imgviewTop8.constant = -12

                stackviewStatus.constant = 103.5
                   
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true
            }else{
                lblWrongEntry.isHidden = false
                
                imgview8.isHidden = false
                
                imgviewTop8.constant = 98.5

                stackviewStatus.constant = 120.5

                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = false
            }
             
          lbldateintime.isHidden = true
         // lblintime.isHidden = false
          lblouttime.isHidden = true
          lbladdedby.isHidden = false
          lblparceltime.isHidden = true
          lblLeaveatGate.isHidden = true
          lblcancelby.isHidden = true
         // lblWrongEntry.isHidden = true
          lbldateintimeMulti.isHidden = true // Extra


           // 13/1/20 temp comment

           /*  imgviewHight1.constant = 12
             imgviewHight2.constant = 0
             imgviewHight3.constant = 12
             imgviewHight4.constant = 0
             imgviewHight5.constant = 0
             imgviewHight6.constant = 0 */

             imgview1.isHidden = true
             imgview2.isHidden = false
             imgview3.isHidden = true
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
             imgview7.isHidden = true
            // imgview8.isHidden = true
             imgviewExtra.isHidden = true

          imgviewTop1.constant = -12
          imgviewTop2.constant = 64.5
          imgviewTop3.constant = -12
          imgviewTop4.constant = 81.5
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
            
          imgviewTopExtra.constant = -12
            
           
          
          constraintHightStackBtn.constant = 50
          constraintHightStacklbl.constant = 0.5
          lblHightStacklblMiddle.isHidden = false
       
          btnInviteShare.isHidden = true
          btnExtraShow.isHidden = false

             btnClose.isHidden = true
             btnCancel.isHidden = true
             btnEdit.isHidden = true
           //  btnWrong_Entry.isHidden = false
           //  btnWrong_Entry_Red.isHidden = true
             btnRenew.isHidden = true
             btnNote_Guard.isHidden = true
             btnOut.isHidden = false
             btnDeliveryInfo.isHidden = true
             btnAlertInfo.isHidden = true

         }
         else if lblStatus.text == "PRE-APPROVAL" || lblStatus.text == "PRE-APPROVED" {  // right
             lblStatus.backgroundColor = AppColor.pollborderSelect
                 
             /* if activity.activityIn != nil {
                      let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                      let strDate = strChangeDateFormate(strDateeee: lblDate!)
                      
                      let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                      let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                      lbldateintime.text = strTime + " , " + strDate
                      lbldateintime.isHidden = false
              }else{
                  lbldateintime.isHidden = true
              } */
          
          if activity.isMulti == "1" {

             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                 let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                 let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                     lbldateintime.isHidden = false

                      lbldateintime.text = "\(strDate) - \(strDate1)"

                    // lbldateintime.text = strDate + " - " + strDate1
             }else{
                 lbldateintime.isHidden = true
             }
         }else{
             
             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                     lbldateintime.isHidden = false

                      lbldateintime.text = "\(strTime) , \(strDate)"

                    // lbldateintime.text = strTime + " , " + strDate
             }else{
                 lbldateintime.isHidden = true
             }
         }
           
             // 13/1/20 temp comment

           /*  imgviewHight1.constant = 12
             imgviewHight2.constant = 0
             imgviewHight3.constant = 12
             imgviewHight4.constant = 0
             imgviewHight5.constant = 0
             imgviewHight6.constant = 0 */
          
          lbldateintime.isHidden = false
          lblintime.isHidden = true
          lblouttime.isHidden = true
          lbladdedby.isHidden = false
          lblparceltime.isHidden = true
          lblLeaveatGate.isHidden = true
          lblcancelby.isHidden = true
          lblWrongEntry.isHidden = true
          lbldateintimeMulti.isHidden = true // Extra


          imgview1.isHidden = false
          imgview2.isHidden = true
          imgview3.isHidden = true
          imgview4.isHidden = false
          imgview5.isHidden = true
          imgview6.isHidden = true
          imgview7.isHidden = true
          imgview8.isHidden = true
          imgviewExtra.isHidden = true

          imgviewTop1.constant = 64.5
          imgviewTop2.constant = -12
          imgviewTop3.constant = -12
          imgviewTop4.constant = 81.5
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

          stackviewStatus.constant = 103.5
               
          constraintHightStackBtn.constant = 50
          constraintHightStacklbl.constant = 0.5
          lblHightStacklblMiddle.isHidden = false
          

             btnCancel.isHidden = false
             btnEdit.isHidden = false
             
             btnInviteShare.isHidden = false
          btnExtraShow.isHidden = true

             btnWrong_Entry.isHidden = true
             btnWrong_Entry_Red.isHidden = true
             btnRenew.isHidden = true
             btnClose.isHidden = true
             btnNote_Guard.isHidden = true
             btnOut.isHidden = true
             btnDeliveryInfo.isHidden = true
             btnAlertInfo.isHidden = true

         }
         else if lblStatus.text == "DELIVERED" {
             
             lblStatus.backgroundColor = AppColor.pollborderSelect
          
          if activity.isMulti == "1" {
              
              if activity.activityIn != nil {
                      let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                      let strDate = strChangeDateFormate(strDateeee: lblDate!)
                      
                  let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                  let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                  lbldateintime.isHidden = false
                  
                  lbldateintime.text = "\(strDate) - \(strDate1)"

                     // lbldateintime.text = strDate + " - " + strDate1
              }else{
                  lbldateintime.isHidden = true
              }
              
          }else{
                 
                  if activity.activityIn != nil {
                          let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                          let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                      lbldateintime.isHidden = false

                      lbldateintime.text = "\(strTime) , \(strDate)"

                         // lbldateintime.text = strTime + " , " + strDate
                  }else{
                      lbldateintime.isHidden = true
                  }
          }
                     
         // lbldateintime.isHidden = false
          lblintime.isHidden = true
          lblouttime.isHidden = true
          lbladdedby.isHidden = true
          lblparceltime.isHidden = true
          lblLeaveatGate.isHidden = true
          lblcancelby.isHidden = true
          lblWrongEntry.isHidden = true
          lbldateintimeMulti.isHidden = true // Extra


          imgview1.isHidden = false
          imgview2.isHidden = true
          imgview3.isHidden = true
          imgview4.isHidden = true
          imgview5.isHidden = true
          imgview6.isHidden = true
          imgview7.isHidden = true
          imgview8.isHidden = true
          imgviewExtra.isHidden = true

          imgviewTop1.constant = 64.5
          imgviewTop2.constant = -12
          imgviewTop3.constant = -12
          imgviewTop4.constant = -12
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

          stackviewStatus.constant = 86.5
            
          constraintHightStackBtn.constant = 0
          
          constraintHightStacklbl.constant = 0

          lblHightStacklblMiddle.isHidden = true

          
          btnInviteShare.isHidden = true
          btnExtraShow.isHidden = false

             btnCancel.isHidden = true
             btnEdit.isHidden = true
             btnWrong_Entry_Red.isHidden = true
             btnWrong_Entry.isHidden = true
             btnRenew.isHidden = true
             btnClose.isHidden = true
             btnNote_Guard.isHidden = true
             btnOut.isHidden = true
             btnDeliveryInfo.isHidden = true
             btnAlertInfo.isHidden = true

         }
         else if lblStatus.text == "LEFT FROM GATE" {
            
            lblStatus.backgroundColor = AppColor.pollborderSelect
         
         if activity.isMulti == "1" {
             
             if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                 let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                 let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                 lbldateintime.isHidden = false
                 
                 lbldateintime.text = "\(strDate) - \(strDate1)"

                    // lbldateintime.text = strDate + " - " + strDate1
             }else{
                 lbldateintime.isHidden = true
             }
             
         }else{
                
                 if activity.activityIn != nil {
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                     lbldateintime.isHidden = false

                     lbldateintime.text = "\(strTime) , \(strDate)"

                        // lbldateintime.text = strTime + " , " + strDate
                 }else{
                     lbldateintime.isHidden = true
                 }
         }
                    
        // lbldateintime.isHidden = false
         lblintime.isHidden = true
         lblouttime.isHidden = true
         lbladdedby.isHidden = true
         lblparceltime.isHidden = true
         lblLeaveatGate.isHidden = true
         lblcancelby.isHidden = true
         lblWrongEntry.isHidden = true
         lbldateintimeMulti.isHidden = true // Extra


         imgview1.isHidden = false
         imgview2.isHidden = true
         imgview3.isHidden = true
         imgview4.isHidden = true
         imgview5.isHidden = true
         imgview6.isHidden = true
         imgview7.isHidden = true
         imgview8.isHidden = true
         imgviewExtra.isHidden = true

         imgviewTop1.constant = 64.5
         imgviewTop2.constant = -12
         imgviewTop3.constant = -12
         imgviewTop4.constant = -12
         imgviewTop5.constant = -12
         imgviewTop6.constant = -12
         imgviewTop7.constant = -12
         imgviewTop8.constant = -12
         imgviewTopExtra.constant = -12

         stackviewStatus.constant = 86.5
           
         constraintHightStackBtn.constant = 0
         
         constraintHightStacklbl.constant = 0

         lblHightStacklblMiddle.isHidden = true

         
         btnInviteShare.isHidden = true
         btnExtraShow.isHidden = false

            btnCancel.isHidden = true
            btnEdit.isHidden = true
            btnWrong_Entry_Red.isHidden = true
            btnWrong_Entry.isHidden = true
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnNote_Guard.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = true

        }
         else if lblStatus.text == "LEFT" {
             lblStatus.backgroundColor = AppColor.pollborderSelect
             
             constraintHightStackBtn.constant = 0
             
             constraintHightStacklbl.constant = 0

             lblHightStacklblMiddle.isHidden = true
          
          imgviewTop1.constant = -12
          imgviewTop2.constant = -12
          imgviewTop3.constant = -12
          imgviewTop4.constant = -12
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

          stackviewStatus.constant = 69.5
            
          lbldateintime.isHidden = true
          lblintime.isHidden = true
          lblouttime.isHidden = true
          lbladdedby.isHidden = true
          lblparceltime.isHidden = true
          lblLeaveatGate.isHidden = true
          lblcancelby.isHidden = true
          lblWrongEntry.isHidden = true
          lbldateintimeMulti.isHidden = true // Extra


          imgview1.isHidden = true
          imgview2.isHidden = true
          imgview3.isHidden = true
          imgview4.isHidden = true
          imgview5.isHidden = true
          imgview6.isHidden = true
          imgview7.isHidden = true
          imgview8.isHidden = true
          imgviewExtra.isHidden = true

          btnInviteShare.isHidden = true
          btnExtraShow.isHidden = false

             btnCancel.isHidden = true
             btnEdit.isHidden = true
             btnWrong_Entry.isHidden = true
             btnWrong_Entry_Red.isHidden = true
             btnRenew.isHidden = true
             btnClose.isHidden = true
             btnNote_Guard.isHidden = true
             btnOut.isHidden = true
             btnDeliveryInfo.isHidden = true
             btnAlertInfo.isHidden = true

         }
         else if lblStatus.text == "CHECKED IN" {
             
             lblStatus.backgroundColor = AppColor.pollborderSelect
           
          
           lbldateintime.isHidden = true
           lblintime.isHidden = true
           lblouttime.isHidden = true
           lbladdedby.isHidden = true
           lblparceltime.isHidden = true
           lblLeaveatGate.isHidden = true
           lblcancelby.isHidden = true
           lblWrongEntry.isHidden = true
           lbldateintimeMulti.isHidden = true // Extra


           imgview1.isHidden = true
           imgview2.isHidden = true
           imgview3.isHidden = true
           imgview4.isHidden = true
           imgview5.isHidden = true
           imgview6.isHidden = true
           imgview7.isHidden = true
           imgview8.isHidden = true
           imgviewExtra.isHidden = true

          constraintHightStackBtn.constant = 0
          
          constraintHightStacklbl.constant = 0

          lblHightStacklblMiddle.isHidden = true
       
          
          imgviewTop1.constant = -12
          imgviewTop2.constant = -12
          imgviewTop3.constant = -12
          imgviewTop4.constant = -12
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

          stackviewStatus.constant = 69.5
            
          btnInviteShare.isHidden = true
          btnExtraShow.isHidden = false

          btnCancel.isHidden = true
          btnEdit.isHidden = true
          btnWrong_Entry.isHidden = true
          btnWrong_Entry_Red.isHidden = true
          btnRenew.isHidden = true
          btnClose.isHidden = true
          btnNote_Guard.isHidden = true
          btnOut.isHidden = true
          btnDeliveryInfo.isHidden = true
          btnAlertInfo.isHidden = true


         }
         else{
             lblStatus.backgroundColor = AppColor.pollborderSelect
             
              
               lbldateintime.isHidden = true
               lblintime.isHidden = true
               lblouttime.isHidden = true
               lbladdedby.isHidden = true
               lblparceltime.isHidden = true
               lblLeaveatGate.isHidden = true
               lblcancelby.isHidden = true
               lblWrongEntry.isHidden = true
               lbldateintimeMulti.isHidden = true // Extra


               imgview1.isHidden = true
               imgview2.isHidden = true
               imgview3.isHidden = true
               imgview4.isHidden = true
               imgview5.isHidden = true
               imgview6.isHidden = true
               imgview7.isHidden = true
               imgview8.isHidden = true
               imgviewExtra.isHidden = true

          constraintHightStackBtn.constant = 0
          
          constraintHightStacklbl.constant = 0

          lblHightStacklblMiddle.isHidden = true
       
          
          imgviewTop1.constant = -12
          imgviewTop2.constant = -12
          imgviewTop3.constant = -12
          imgviewTop4.constant = -12
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

          stackviewStatus.constant = 69.5
            
          btnInviteShare.isHidden = true
          btnExtraShow.isHidden = false

              btnCancel.isHidden = true
              btnEdit.isHidden = true
              btnWrong_Entry.isHidden = true
              btnWrong_Entry_Red.isHidden = true
              btnRenew.isHidden = true
              btnClose.isHidden = true
              btnNote_Guard.isHidden = true
              btnOut.isHidden = true
              btnDeliveryInfo.isHidden = true
              btnAlertInfo.isHidden = true

         }
        
        btnIn_OnDemand.isHidden = true
        btnCancel_OnDemand.isHidden = true
        btnOut_OnDemand.isHidden = true
        btnEdit_OnDemand.isHidden = true

        
    }
    
    func setDeliveryEntry(activity:ActivityAll,wrong:UserActivityAll) // Delivery
    {
        
             lblname.text = "Delivery"

              btnExtraShow.isHidden = false
              btnInviteShare.isHidden = true
             
            if activity.profilePic == "" || activity.profilePic == nil {
                imgview.image = UIImage(named: "ic_delivery_tab")
            }else{
                imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "ic_delivery_tab"))
            }
        
            // imgview.image = UIImage(named: "ic_delivery_tab")

             if activity.companyLogoURL == "" || activity.companyLogoURL == nil {
                 imgviewCompanyLogo.image = UIImage(named: "default_logo")
                  imgviewCompanyLogo.isHidden = false
              }else{
                 imgviewCompanyLogo.sd_setImage(with: URL(string: (activity.companyLogoURL)!), placeholderImage: UIImage(named: "default_logo"))
                 imgviewCompanyLogo.isHidden = false
              }
             
                if activity.companyName == "" || activity.companyName == nil {
                     lblguest.text = ""
                }else{
                     lblguest.text = activity.companyName
                }
                
            /* if activity.addedBy == "" || activity.addedBy == nil {
                 lbladdedby.text = "Added by "
             }else{
                 lbladdedby.text = "Added by " + (activity.addedBy)!
             } */
                
                lbladdedby.isHidden = false
                      
                lblStatus.text = activity.status
             
             lblStatus.isHidden = false

             if lblStatus.text == "LEAVE AT GATE" {
                 if activity.recivedBy != nil {
                     lblStatus.backgroundColor = AppColor.pollborderSelect

                     lblStatus.text = "COLLECTED"
                     
                     if activity.activityIn != nil {
                         
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)
         
                             lblintime.text = "\(strTime) , \(strDate)"

                         //  lblintime.text =  strTime + " , " + strDate

                     }
                     
                     if activity.recivedAt != nil {
                         
                         let lblDate = activity.recivedAt?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.recivedAt?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        // lblparceltime.text =  strTime + " , " + strDate
                         
                         lblparceltime.text = "\(strTime) , \(strDate)"

                     }

                     if activity.approvedBy != nil {
                         lbladdedby.text = "Approved by " + (activity.approvedBy)!
                     }else {
                         lbladdedby.text = "Approved by "
                     }
                     
                     if activity.wrongEntryBy != nil {
                         
                         lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

                     }
               
                     lblcancelby.text  =  "Collected by " + (activity.recivedBy)!
                 
                 if activity.leaveAtGate == "1" {
                     
                     if wrong.isWrongEntry == 0 {
                         
                         lblWrongEntry.isHidden = true
                         imgview8.isHidden = true
                         
                         imgviewTop8.constant = -12

                         stackviewStatus.constant = 154.5

                         btnWrong_Entry.isHidden = false
                         
                         btnWrong_Entry_Red.isHidden = true
                         
                     }else{
                         lblWrongEntry.isHidden = false
                         imgview8.isHidden = false

                         imgviewTop8.constant = 149.5

                         stackviewStatus.constant = 171.5
                         
                         lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                         btnWrong_Entry.isHidden = true
                         btnWrong_Entry_Red.isHidden = false
                     }
                     
                     lblLeaveatGate.text = "Leave at Gate"
                     
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = false
                     lblLeaveatGate.isHidden = false
                     lblcancelby.isHidden = false
                     lbldateintimeMulti.isHidden = true // Extra

                    // imgview7.sd_setImage(with: URL(string: ), placeholderImage: UIImage(named: ""))

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = false
                     imgview6.isHidden = false
                      imgview7.isHidden = false
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = 98.5
                     imgviewTop6.constant = 115.5
                     imgviewTop7.constant = 132.5
                     imgviewTopExtra.constant = -12
                     
                 }else{
                     
                     if wrong.isWrongEntry == 0 {
                         
                         lblWrongEntry.isHidden = true
                         imgview8.isHidden = true
                         
                         imgviewTop8.constant = -12

                         stackviewStatus.constant = 137.5

                         btnWrong_Entry.isHidden = false
                         
                         btnWrong_Entry_Red.isHidden = true
                         
                     }else{
                         lblWrongEntry.isHidden = false
                         imgview8.isHidden = false

                         imgviewTop8.constant = 132.5

                         stackviewStatus.constant = 154.5
                         
                         lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                         btnWrong_Entry.isHidden = true
                         btnWrong_Entry_Red.isHidden = false
                     }
                     
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = false
                     lblLeaveatGate.isHidden = true
                     lblcancelby.isHidden = false
                     lbldateintimeMulti.isHidden = true // Extra

                     // imgview7.sd_setImage(with: URL(string: ), placeholderImage: UIImage(named: ""))

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = false
                     imgview6.isHidden = true
                      imgview7.isHidden = false
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = 98.5
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = 115.5
                     imgviewTopExtra.constant = -12

                 }
             
                     
                 }else{
                     lblStatus.backgroundColor = AppColor.LeaveatgateColor
                     
                     lblStatus.text = "LEAVE AT GATE"
                     
                     if activity.activityIn != nil {
                         
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         lblintime.text = "\(strTime) , \(strDate)"

                       //  lblintime.text =  strTime + " , " + strDate

                     }
                     

                     if activity.approvedBy != nil {
                         lbladdedby.text = "Approved by " + (activity.approvedBy)!
                     }else {
                         lbladdedby.text = "Approved by "
                     }
                       
                         if activity.wrongEntryBy != nil {
                             
                             lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

                         }
                   
                     
                     if activity.leaveAtGate == "1" {
                         
                         
                         if wrong.isWrongEntry == 0 {
                             
                             lblWrongEntry.isHidden = true
                             imgview8.isHidden = true
                             
                             imgviewTop8.constant = -12

                             stackviewStatus.constant = 120.5

                             btnWrong_Entry.isHidden = false
                             
                             btnWrong_Entry_Red.isHidden = true
                             
                         }else{
                             lblWrongEntry.isHidden = false
                             imgview8.isHidden = false

                             imgviewTop8.constant = 115.5

                             stackviewStatus.constant = 137.5
                             
                             lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                             btnWrong_Entry.isHidden = true
                             btnWrong_Entry_Red.isHidden = false
                         }
                         
                         lblLeaveatGate.text = "Leave at Gate"
                         
                         lbldateintime.isHidden = true
                         lblintime.isHidden = false
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = false
                         lblcancelby.isHidden = true
                         lbldateintimeMulti.isHidden = true // Extra

                         imgview1.isHidden = true
                         imgview2.isHidden = false
                         imgview3.isHidden = true
                         imgview4.isHidden = true
                         imgview5.isHidden = true
                         imgview6.isHidden = false
                          imgview7.isHidden = true
                          imgviewExtra.isHidden = true
                         
                         imgviewTop1.constant = -12
                         imgviewTop2.constant = 64.5
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 81.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = 98.5
                         imgviewTop7.constant = -12
                         imgviewTopExtra.constant = -12
                         
                     }else{
                         
                         if wrong.isWrongEntry == 0 {
                             
                             lblWrongEntry.isHidden = true
                             imgview8.isHidden = true
                             
                             imgviewTop8.constant = -12

                             stackviewStatus.constant = 103.5

                             btnWrong_Entry.isHidden = false
                             
                             btnWrong_Entry_Red.isHidden = true
                             
                         }else{
                             lblWrongEntry.isHidden = false
                             imgview8.isHidden = false

                             imgviewTop8.constant = 98.5

                             stackviewStatus.constant = 120.5
                             
                             lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                             btnWrong_Entry.isHidden = true
                             btnWrong_Entry_Red.isHidden = false
                         }
                         
                         lbldateintime.isHidden = true
                         lblintime.isHidden = false
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = true
                         lblcancelby.isHidden = true
                         lbldateintimeMulti.isHidden = true // Extra

                         imgview1.isHidden = true
                         imgview2.isHidden = false
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = true
                          imgview7.isHidden = true
                          imgviewExtra.isHidden = true
                         
                         imgviewTop1.constant = -12
                         imgviewTop2.constant = 64.5
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 81.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = -12
                         imgviewTop7.constant = -12
                         imgviewTopExtra.constant = -12

                         
                     }
                 
                 }
                 
                 constraintHightStackBtn.constant = 50
                 constraintHightStacklbl.constant = 0.5
                 lblHightStacklblMiddle.isHidden = false
               
                 
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = false
                 btnAlertInfo.isHidden = true
           
                  
                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true
                 
             }
             else if lblStatus.text == "NOT RESPONDED" {
                 lblStatus.backgroundColor = AppColor.cancelColor
              
                      if activity.activityIn != nil {
                              let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                             lblintime.text = "\(strTime) , \(strDate)"

                            //  lblintime.text =  strTime + " , " + strDate
                              lblintime.isHidden = false
                      }else{
                          lblintime.isHidden = true
                      }
                
                         
                if wrong.isWrongEntry == 0 {
                     lblWrongEntry.text = "No Response"
                    
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true

                }else{
                    
                    lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false

                }
                     
                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = true
                     imgview5.isHidden = true
                     imgview6.isHidden = true
                     imgview7.isHidden = true
                     imgview8.isHidden = false
                     imgviewExtra.isHidden = true
              
                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = -12
                  imgviewTop4.constant = -12
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = -12
                  imgviewTop7.constant = -12
                  imgviewTop8.constant = 81.5
                  imgviewTopExtra.constant = -12

                  stackviewStatus.constant = 103.5
                  
                  constraintHightStackBtn.constant = 50
                  constraintHightStacklbl.constant = 0.5
                  lblHightStacklblMiddle.isHidden = true
                  
                  lblWrongEntry.isHidden = false
                  lblintime.isHidden = false
                  
                  lbldateintime.isHidden = true
                  lbldateintimeMulti.isHidden = true // Extra
                  lblouttime.isHidden = true
                  lbladdedby.isHidden = true
                  lblparceltime.isHidden = true
                  lblLeaveatGate.isHidden = true
                  lblcancelby.isHidden = true

                
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true
                 
                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true

             }
             else if lblStatus.text == "DENIED" {
                    lblStatus.backgroundColor = AppColor.deniedColor
                    
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lblintime.text = "\(strTime) , \(strDate)"

                    // lblintime.text =  strTime + " , " + strDate
                     
                     lblintime.isHidden = false

                 }else{
                     lblintime.isHidden = true
                 }
                   
                     if activity.deniedBy != nil {
                         lblWrongEntry.text = "Denied by " + (activity.deniedBy)!
                              
                     }else{
                         lblWrongEntry.text = "Denied by "
                     }
                 
                 if wrong.isWrongEntry == 0 {
                     btnWrong_Entry.isHidden = false
                     btnWrong_Entry_Red.isHidden = true
                 }else{
                     btnWrong_Entry.isHidden = true
                     btnWrong_Entry_Red.isHidden = false
                 }
                 
                 if activity.leaveAtGate == "1" {
                     lblLeaveatGate.text = "Leave at Gate"
                     
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = true
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = false
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = false
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = true
                     imgview5.isHidden = true
                     imgview6.isHidden = false
                      imgview7.isHidden = true
                      imgview8.isHidden = false
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = -12
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = 81.5
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = 98.5
                     imgviewTopExtra.constant = -12

                     stackviewStatus.constant = 120.5
                     
                     
                 }else{
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = true
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = true
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = false
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = true
                     imgview5.isHidden = true
                     imgview6.isHidden = true
                      imgview7.isHidden = true
                      imgview8.isHidden = false
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = -12
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = 81.5
                     imgviewTopExtra.constant = -12

                     stackviewStatus.constant = 103.5
                     
                 }
                 
                 constraintHightStackBtn.constant = 50
                 constraintHightStacklbl.constant = 0.5
                 lblHightStacklblMiddle.isHidden = true

                 
                           btnCancel.isHidden = true
                           btnEdit.isHidden = true
                           
                           btnRenew.isHidden = true
                           btnClose.isHidden = true
                           btnNote_Guard.isHidden = true
                           btnOut.isHidden = true
                           btnDeliveryInfo.isHidden = true
                           btnAlertInfo.isHidden = true
                 
                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                     
                        
                }
             else if lblStatus.text == "VISITED" {
                 lblStatus.backgroundColor = AppColor.cancelColor
            
                  if activity.activityIn != nil {
                          let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                          let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         // lblintime.text = strTime + " , " + strDate
                      
                      lblintime.text = "\(strTime) , \(strDate)"

                  }

              if activity.out != nil {
                          let lblDate = activity.out?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.out?.components(separatedBy: " ")[1]
                          
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                  
                          lblouttime.text = "\(strTime) , \(strDate)"

                         // lblouttime.text = strTime + " , " + strDate
                  }
               
                 
                 constraintHightStackBtn.constant = 50

                 constraintHightStacklbl.constant = 0.5

                 lblHightStacklblMiddle.isHidden = true
                 
                 if wrong.isWrongEntry == 0 {
                     lblWrongEntry.isHidden = true
                     imgview8.isHidden = true
                     
                     btnWrong_Entry.isHidden = false
                     btnWrong_Entry_Red.isHidden = true
                  
                  imgview1.isHidden = true
                  imgview2.isHidden = false
                  imgview3.isHidden = false
                  imgview4.isHidden = false
                  imgview5.isHidden = true
                  imgview6.isHidden = true
                   imgview7.isHidden = true
                //  imgview8.isHidden = true
                   imgviewExtra.isHidden = true

                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = 81.5
                  imgviewTop4.constant = 98.5
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = -12
                  imgviewTop7.constant = -12
                  imgviewTop8.constant = -12
                  imgviewTopExtra.constant = -12

                  stackviewStatus.constant = 120.5
                       

                 }else{
                     lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                     lblWrongEntry.isHidden = false
                     imgview8.isHidden = false
                     
                     btnWrong_Entry_Red.isHidden = false
                     btnWrong_Entry.isHidden = true
                  
                  imgview1.isHidden = true
                  imgview2.isHidden = false
                  imgview3.isHidden = false
                  imgview4.isHidden = false
                  imgview5.isHidden = true
                  imgview6.isHidden = true
                   imgview7.isHidden = true
                //  imgview8.isHidden = true
                   imgviewExtra.isHidden = true

                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = 81.5
                  imgviewTop4.constant = 98.5
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = -12
                  imgviewTop7.constant = -12
                  imgviewTop8.constant = 115.5
                  imgviewTopExtra.constant = -12

                  stackviewStatus.constant = 137.5
                                   

                 }
                 
                 // 13/1/20 temp comment
                 
                /* imgviewHight1.constant = 12
                 imgviewHight2.constant = 0
                 imgviewHight3.constant = 12
                 imgviewHight4.constant = 0
                 imgviewHight5.constant = 0 */

              lbldateintime.isHidden = true
              lblintime.isHidden = false
              lblouttime.isHidden = false
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = true
            //  lblWrongEntry.isHidden = true
              lbldateintimeMulti.isHidden = true // Extra

              btnInviteShare.isHidden = true

              btnExtraShow.isHidden = false

                 btnDeliveryInfo.isHidden = true
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnAlertInfo.isHidden = true
                
                btnIn_OnDemand.isHidden = true
                btnCancel_OnDemand.isHidden = true
                btnOut_OnDemand.isHidden = true
                btnEdit_OnDemand.isHidden = true

             }
              else if lblStatus.text == "CANCELLED" {
                                    
                    lblStatus.backgroundColor = AppColor.cancelColor
                    
                    lblcancelby.text = "Cancelled by " + (activity.cancelledBy)!
                 
                     lbladdedby.text = "Added by " + (activity.addedBy)!
                 
              if activity.isMulti == "1" {

                     if activity.activityIn != nil {
                         
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                         let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                         
                        lbldateintime.text = "\(strDate) , \(strDate1)"

                       //  lbldateintime.text =  strDate + " - " + strDate1
                         
                         lbldateintime.isHidden = false

                     }else{
                         lbldateintime.isHidden = true
                     }
                     
                     if activity.allowedInTime != nil {
                         
                         
                         let lblTime = activity.allowedInTime!
                        let strTime = strChangeTimeFormate(strDateeee: lblTime)

                         let lblTime1 = activity.allowedOutTime!
                        let strTime1 = strChangeTimeFormate(strDateeee: lblTime1)

                         lbldateintimeMulti.text = "\(strTime) , \(strTime1)"

                        // lbldateintimeMulti.text =  strTime + " , " + strTime1
                         
                         lbldateintimeMulti.isHidden = false

                     }else{
                         lbldateintimeMulti.isHidden = true
                     }
                        
                        
                     
                     if activity.leaveAtGate == "1" {
                         lblLeaveatGate.text = "Leave at Gate"
                         
                         if wrong.isWrongEntry == 0 {
                             
                             lblWrongEntry.isHidden = true
                             imgview8.isHidden = true
                             
                             imgviewTop8.constant = -12

                             stackviewStatus.constant = 154.5
                             

                             btnWrong_Entry.isHidden = false
                             btnWrong_Entry_Red.isHidden = true
                         }else{
                             lblWrongEntry.isHidden = false
                             imgview8.isHidden = false

                             imgviewTop8.constant = 149.5

                             stackviewStatus.constant = 171.5
                             
                             lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                             btnWrong_Entry.isHidden = true
                             btnWrong_Entry_Red.isHidden = false
                         }
                         
                       //  lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = false
                         lblcancelby.isHidden = false
                         lbldateintimeMulti.isHidden = false // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = false
                          imgview7.isHidden = false
                          imgviewExtra.isHidden = false
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 98.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = 115.5
                         imgviewTop7.constant = 132.5
                         
                         imgviewTopExtra.constant = 81.5

                         
                     }else{
                         
                         if wrong.isWrongEntry == 0 {
                             
                             lblWrongEntry.isHidden = true
                             imgview8.isHidden = true
                             
                             imgviewTop8.constant = -12

                             stackviewStatus.constant = 137.5

                             btnWrong_Entry.isHidden = false
                             btnWrong_Entry_Red.isHidden = true
                         }else{
                             lblWrongEntry.isHidden = false
                             imgview8.isHidden = false

                            imgviewTop8.constant = 132.5

                            stackviewStatus.constant = 154.5
                             
                             
                             lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                             btnWrong_Entry.isHidden = true
                             btnWrong_Entry_Red.isHidden = false
                         }
                         
                         lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = true
                         lblcancelby.isHidden = false
                         lbldateintimeMulti.isHidden = false // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = true
                          imgview7.isHidden = false
                          imgviewExtra.isHidden = false
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 98.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = -12
                         imgviewTop7.constant = 115.5
                         
                         imgviewTopExtra.constant = 81.5
                        
                     }
                 }else {
                     
                     if activity.activityIn != nil {
                         
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         lbldateintime.text = "\(strTime) , \(strDate)"

                        // lbldateintime.text =  strTime + " , " + strDate
                         
                         lbldateintime.isHidden = false

                     }else{
                         lbldateintime.isHidden = true
                     }
                        
                     
                     if activity.leaveAtGate == "1" {
                         lblLeaveatGate.text = "Leave at Gate"
                         
                         if wrong.isWrongEntry == 0 {
                             
                             lblWrongEntry.isHidden = true
                             imgview8.isHidden = true
                             
                             imgviewTop8.constant = -12

                             stackviewStatus.constant = 137.5
                             

                             btnWrong_Entry.isHidden = false
                             btnWrong_Entry_Red.isHidden = true
                         }else{
                             lblWrongEntry.isHidden = false
                             imgview8.isHidden = false

                             imgviewTop8.constant = 132.5

                             stackviewStatus.constant = 154.5
                             
                             lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                             btnWrong_Entry.isHidden = true
                             btnWrong_Entry_Red.isHidden = false
                         }
                         
                         lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = false
                         lblcancelby.isHidden = false
                         lbldateintimeMulti.isHidden = true // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = false
                          imgview7.isHidden = false
                          imgviewExtra.isHidden = true
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 81.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = 98.5
                         imgviewTop7.constant = 115.5
                         
                         imgviewTopExtra.constant = -12

                         
                     }else{
                         
                         if wrong.isWrongEntry == 0 {
                             
                             lblWrongEntry.isHidden = true
                             imgview8.isHidden = true
                             
                             imgviewTop8.constant = -12

                            stackviewStatus.constant = 120.5


                             btnWrong_Entry.isHidden = false
                             btnWrong_Entry_Red.isHidden = true
                         }else{
                             lblWrongEntry.isHidden = false
                             imgview8.isHidden = false

                            imgviewTop8.constant = 115.5

                            stackviewStatus.constant = 137.5
                             
                             lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                             btnWrong_Entry.isHidden = true
                             btnWrong_Entry_Red.isHidden = false
                         }
                         
                        // lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = true
                         lblcancelby.isHidden = false
                         lbldateintimeMulti.isHidden = true // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = true
                          imgview7.isHidden = false
                          imgviewExtra.isHidden = true
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 81.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = -12
                        imgviewTop7.constant = 98.5
                         
                         imgviewTopExtra.constant = -12
                        
                     }
                 }
                 
                         constraintHightStackBtn.constant = 50
                         constraintHightStacklbl.constant = 0.5
                         lblHightStacklblMiddle.isHidden = true
                 
                           btnCancel.isHidden = true
                           btnEdit.isHidden = true
                           
                           btnRenew.isHidden = true
                           btnClose.isHidden = true
                           btnNote_Guard.isHidden = true
                           btnOut.isHidden = true
                           btnDeliveryInfo.isHidden = true
                           btnAlertInfo.isHidden = true
                 
                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                     
                }
                else if lblStatus.text == "EXPIRED" {
                    lblStatus.backgroundColor = AppColor.cancelColor
                 
                  if activity.isMulti == "1" {
                     
                     if activity.activityIn != nil {
                         
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                         let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                         
                         lbldateintime.text = "\(strDate) - \(strDate1)"

                       //  lbldateintime.text =  strDate + " - " + strDate1
                         
                         lbldateintime.isHidden = false

                     }else{
                         lbldateintime.isHidden = true
                     }
                     
                     if activity.allowedInTime != nil {
                         
                         let lblTime = activity.allowedInTime!
                         let strTime = strChangeTimeFormate(strDateeee: lblTime)

                         let lblTime1 = activity.allowedOutTime!
                         let strTime1 = strChangeTimeFormate(strDateeee: lblTime1)

                        lbldateintimeMulti.text = "\(strTime) - \(strTime1)"

                        // lbldateintimeMulti.text =  strTime + " , " + strTime1
                         
                         lbldateintimeMulti.isHidden = false

                     }else{
                         lbldateintimeMulti.isHidden = true
                     }
                     
                     lbladdedby.text = "Added by " + (activity.addedBy)!

                     if activity.leaveAtGate == "1" {
                         lblLeaveatGate.text = "Leave at Gate"
                         
                         lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = false
                         lblcancelby.isHidden = true
                         lblWrongEntry.isHidden = true
                         lbldateintimeMulti.isHidden = false // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = false
                          imgview7.isHidden = true
                          imgview8.isHidden = true
                          imgviewExtra.isHidden = false
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 98.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = 115.5
                         imgviewTop7.constant = -12
                         imgviewTop8.constant = -12
                         imgviewTopExtra.constant = 81.5

                         stackviewStatus.constant = 137.5
                         
                         
                     }else{
                         lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = true
                         lblcancelby.isHidden = true
                         lblWrongEntry.isHidden = true
                         lbldateintimeMulti.isHidden = false // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = true
                          imgview7.isHidden = true
                          imgview8.isHidden = true
                          imgviewExtra.isHidden = false
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 98.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = -12
                         imgviewTop7.constant = -12
                         imgviewTop8.constant = -12
                         imgviewTopExtra.constant = 81.5

                         stackviewStatus.constant = 120.5
                         
                     }
                  }else{
                     
                     if activity.activityIn != nil {
                         
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         lbldateintime.text = "\(strTime) , \(strDate)"

                        // lbldateintime.text =  strTime + " , " + strDate

                     }
                     
                     lbladdedby.text = "Added by " + (activity.addedBy)!

                     if activity.leaveAtGate == "1" {
                         lblLeaveatGate.text = "Leave at Gate"
                         
                         lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = false
                         lblcancelby.isHidden = true
                         lblWrongEntry.isHidden = true
                         lbldateintimeMulti.isHidden = true // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = false
                          imgview7.isHidden = true
                          imgview8.isHidden = true
                          imgviewExtra.isHidden = true
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 81.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = 98.5
                         imgviewTop7.constant = -12
                         imgviewTop8.constant = -12
                         imgviewTopExtra.constant = -12

                         stackviewStatus.constant = 120.5
                         
                         
                     }else{
                         lbldateintime.isHidden = false
                         lblintime.isHidden = true
                         lblouttime.isHidden = true
                         lbladdedby.isHidden = false
                         lblparceltime.isHidden = true
                         lblLeaveatGate.isHidden = true
                         lblcancelby.isHidden = true
                         lblWrongEntry.isHidden = true
                         lbldateintimeMulti.isHidden = true // Extra

                         imgview1.isHidden = false
                         imgview2.isHidden = true
                         imgview3.isHidden = true
                         imgview4.isHidden = false
                         imgview5.isHidden = true
                         imgview6.isHidden = true
                          imgview7.isHidden = true
                          imgview8.isHidden = true
                          imgviewExtra.isHidden = true
                         
                         imgviewTop1.constant = 64.5
                         imgviewTop2.constant = -12
                         imgviewTop3.constant = -12
                         imgviewTop4.constant = 81.5
                         imgviewTop5.constant = -12
                         imgviewTop6.constant = -12
                         imgviewTop7.constant = -12
                         imgviewTop8.constant = -12
                         imgviewTopExtra.constant = -12

                         stackviewStatus.constant = 103.5
                         
                     }
                     }
                    
                    constraintHightStackBtn.constant = 50
                    constraintHightStacklbl.constant = 0.5
                    lblHightStacklblMiddle.isHidden = true
                    
                   
                    btnRenew.isHidden = false

                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true
                 
                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                 
                }
                else if lblStatus.text == "PRE-APPROVAL" || lblStatus.text == "PRE-APPROVED" {  // right
                    lblStatus.backgroundColor = AppColor.pollborderSelect
                 
                 
                 if activity.isMulti == "1" {

                 
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                     let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                     
                     lbldateintime.text = "\(strDate) , \(strDate1)"

                    // lbldateintime.text =  strDate + " - " + strDate1
                     
                 }
                 
                 if activity.allowedInTime != nil {
                     
                     let lblTime = activity.allowedInTime!
                     let strTime = strChangeTimeFormate(strDateeee: lblTime)

                     let lblTime1 = activity.allowedOutTime
                     let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                    lbldateintimeMulti.text = "\(strTime) , \(strTime1)"

                   //  lbldateintimeMulti.text =  strTime + " , " + strTime1
                     

                 }
                 
                 lbladdedby.text = "Added by " + (activity.addedBy)!

                 if activity.leaveAtGate == "1" {
                     lblLeaveatGate.text = "Leave at Gate"
                     
                     lbldateintime.isHidden = false
                     lblintime.isHidden = true
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = false
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = true
                     lbldateintimeMulti.isHidden = false // Extra

                     imgview1.isHidden = false
                     imgview2.isHidden = true
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = false
                      imgview7.isHidden = true
                      imgview8.isHidden = true
                      imgviewExtra.isHidden = false
                     
                     imgviewTop1.constant = 64.5
                     imgviewTop2.constant = -12
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 98.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = 115.5
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = -12
                     imgviewTopExtra.constant = 81.5

                     stackviewStatus.constant = 137.5
                     
                     
                 }else{
                     lbldateintime.isHidden = false
                     lblintime.isHidden = true
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = true
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = true
                     lbldateintimeMulti.isHidden = false // Extra

                     imgview1.isHidden = false
                     imgview2.isHidden = true
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = true
                      imgview7.isHidden = true
                      imgview8.isHidden = true
                      imgviewExtra.isHidden = false
                     
                     imgviewTop1.constant = 64.5
                     imgviewTop2.constant = -12
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 98.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = -12
                     imgviewTopExtra.constant = 81.5

                     stackviewStatus.constant = 120.5
                     
                 }
                }else{
                 
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lbldateintime.text = "\(strTime) , \(strDate)"

                   //  lbldateintime.text =  strTime + " , " + strDate

                 }
                 
                 lbladdedby.text = "Added by " + (activity.addedBy)!

                 if activity.leaveAtGate == "1" {
                     lblLeaveatGate.text = "Leave at Gate"
                     
                     lbldateintime.isHidden = false
                     lblintime.isHidden = true
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = false
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = true
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = false
                     imgview2.isHidden = true
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = false
                      imgview7.isHidden = true
                      imgview8.isHidden = true
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = 64.5
                     imgviewTop2.constant = -12
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = 98.5
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = -12
                     imgviewTopExtra.constant = -12

                     stackviewStatus.constant = 120.5
                     
                     
                 }else{
                     lbldateintime.isHidden = false
                     lblintime.isHidden = true
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = true
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = true
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = false
                     imgview2.isHidden = true
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = true
                      imgview7.isHidden = true
                      imgview8.isHidden = true
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = 64.5
                     imgviewTop2.constant = -12
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = -12
                     imgviewTopExtra.constant = -12

                     stackviewStatus.constant = 103.5
                     
                 }
                }
                    
                    constraintHightStackBtn.constant = 50
                    constraintHightStacklbl.constant = 0.5
                    lblHightStacklblMiddle.isHidden = false
                    
                   
                    btnCancel.isHidden = false
                    btnEdit.isHidden = false
                    
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = true
                    btnRenew.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true

                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                     
                }
                else if lblStatus.text == "APPROVED" {
                    lblStatus.backgroundColor = AppColor.pollborderSelect
                 
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lblintime.text = "\(strTime) , \(strDate)"

                   //  lblintime.text =  strTime + " , " + strDate

                 }
                 
                 lbladdedby.text = "Added by " + (activity.addedBy)!

                 if activity.leaveAtGate == "1" {
                     lblLeaveatGate.text = "Leave at Gate"
                     
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = false
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = true
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = false
                      imgview7.isHidden = true
                      imgview8.isHidden = true
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = 98.5
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = -12
                     imgviewTopExtra.constant = -12

                     stackviewStatus.constant = 120.5
                     
                     
                 }else{
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = true
                     lblcancelby.isHidden = true
                     lblWrongEntry.isHidden = true
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = true
                      imgview7.isHidden = true
                      imgview8.isHidden = true
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = -12
                     imgviewTop8.constant = -12
                     imgviewTopExtra.constant = -12

                     stackviewStatus.constant = 103.5
                     
                 }
                
                 
                    constraintHightStackBtn.constant = 50
                    constraintHightStacklbl.constant = 0.5
                    lblHightStacklblMiddle.isHidden = false
                    
                    
                   
                    btnClose.isHidden = false
                    
                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = true
                    btnRenew.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true
                 
                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                 
                }
                else if lblStatus.text == "ADDED" {
                 
                 lblStatus.backgroundColor = AppColor.pollborderSelect
                 
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lblintime.text = "\(strTime) , \(strDate)"

                    // lblintime.text =  strTime + " , " + strDate
                     
                 }
                    
                 lbladdedby.text = "Added by " + (activity.addedBy)!

                 if activity.leaveAtGate == "1" {
                     lblLeaveatGate.text = "Leave at Gate"
                     
                     if wrong.isWrongEntry == 0 {
                         
                         lblWrongEntry.isHidden = true
                         imgview8.isHidden = true
                         
                         imgviewTop8.constant = -12

                        stackviewStatus.constant = 120.5 // 137.5
                         
                         btnWrong_Entry.isHidden = false
                         btnWrong_Entry_Red.isHidden = true
                     }else{
                         lblWrongEntry.isHidden = false
                         imgview8.isHidden = false

                         imgviewTop8.constant = 115.5

                        stackviewStatus.constant = 137.5
                         
                         lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

                         btnWrong_Entry.isHidden = true
                         btnWrong_Entry_Red.isHidden = false
                     }
                     
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = false
                     lblcancelby.isHidden = true
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = false
                      imgview7.isHidden = true
                     
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = 98.5
                     imgviewTop7.constant = -12 // 115.5
                     
                     imgviewTopExtra.constant = -12

                     
                 }else{
                     
                     if wrong.isWrongEntry == 0 {
                         
                         lblWrongEntry.isHidden = true
                         imgview8.isHidden = true
                         
                         imgviewTop8.constant = -12

                         stackviewStatus.constant = 103.5

                         btnWrong_Entry.isHidden = false
                         btnWrong_Entry_Red.isHidden = true
                        
                     }else{
                        
                         lblWrongEntry.isHidden = false
                         imgview8.isHidden = false

                         imgviewTop8.constant = 98.5

                         stackviewStatus.constant = 120.5
                         
                         lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

                         btnWrong_Entry.isHidden = true
                         btnWrong_Entry_Red.isHidden = false
                     }
                     
                    lbladdedby.text = "Added by " + (activity.addedBy)!

                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = true
                     lblcancelby.isHidden = true
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = true
                      imgview7.isHidden = true
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = -12 // 98.5
                     
                     imgviewTopExtra.constant = -12
                    
                 }
                 
               
                 constraintHightStackBtn.constant = 50
                 constraintHightStacklbl.constant = 0.5
                 lblHightStacklblMiddle.isHidden = true
                                 
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true
                 
                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true
                 
             }
                else if lblStatus.text == "DELIVERED" {
                 
                 lblStatus.backgroundColor = AppColor.pollborderSelect
                     
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lbldateintime.text = "\(strTime) , \(strDate)"

                    // lbldateintime.text =  strTime + " , " + strDate
                     
                 }
                    
                 lbldateintime.isHidden = false
                 lblintime.isHidden = true
                 lblouttime.isHidden = true
                 lbladdedby.isHidden = true
                 lblparceltime.isHidden = true
                 lblLeaveatGate.isHidden = true
                 lblcancelby.isHidden = true
                 lblWrongEntry.isHidden = true
                 lbldateintimeMulti.isHidden = true // Extra


                 imgview1.isHidden = false
                 imgview2.isHidden = true
                 imgview3.isHidden = true
                 imgview4.isHidden = true
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                 imgview7.isHidden = true
                 imgview8.isHidden = true
                 imgviewExtra.isHidden = true

                 imgviewTop1.constant = 64.5
                 imgviewTop2.constant = -12
                 imgviewTop3.constant = -12
                 imgviewTop4.constant = -12
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = -12
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 86.5
                   

                 constraintHightStackBtn.constant = 0
                 
                 constraintHightStacklbl.constant = 0

                 lblHightStacklblMiddle.isHidden = true

                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 btnWrong_Entry_Red.isHidden = true
                 btnWrong_Entry.isHidden = true
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true
                 
                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true

             }
                else if lblStatus.text == "LEFT" {  // right
                 lblStatus.backgroundColor = AppColor.pollborderSelect
                 
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lbldateintime.text = "\(strTime) , \(strDate)"

                   //  lbldateintime.text =  strTime + " , " + strDate
                     
                 }
                    
                 lbldateintime.isHidden = false
                 lblintime.isHidden = true
                 lblouttime.isHidden = true
                 lbladdedby.isHidden = true
                 lblparceltime.isHidden = true
                 lblLeaveatGate.isHidden = true
                 lblcancelby.isHidden = true
                 lblWrongEntry.isHidden = true
                 lbldateintimeMulti.isHidden = true // Extra


                 imgview1.isHidden = false
                 imgview2.isHidden = true
                 imgview3.isHidden = true
                 imgview4.isHidden = true
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                 imgview7.isHidden = true
                 imgview8.isHidden = true
                 imgviewExtra.isHidden = true

                 imgviewTop1.constant = 64.5
                 imgviewTop2.constant = -12
                 imgviewTop3.constant = -12
                 imgviewTop4.constant = -12
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = -12
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 86.5
                 
                 constraintHightStackBtn.constant = 0
                 
                 constraintHightStacklbl.constant = 0

                 lblHightStacklblMiddle.isHidden = true

               
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 btnWrong_Entry.isHidden = true
                 btnWrong_Entry_Red.isHidden = true
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true
                 
                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true
                 

             }
                else if lblStatus.text == "CHECKED IN" {
                    
                    lblStatus.backgroundColor = AppColor.pollborderSelect
                 
                 if activity.activityIn != nil {
                     
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lblintime.text = "\(strTime) , \(strDate)"

                    // lblintime.text =  strTime + " , " + strDate
                     
                 }
                    
                 lbladdedby.text = "Pre-Approved by " + (activity.addedBy)!

                 
                 if activity.leaveAtGate == "1" {
                     lblLeaveatGate.text = "Leave at Gate"
                     
                     if wrong.isWrongEntry == 0 {
                         
                         lblWrongEntry.isHidden = true
                         imgview8.isHidden = true
                         
                         imgviewTop8.constant = -12

                         stackviewStatus.constant = 120.5
                         

                         btnWrong_Entry.isHidden = false
                         btnWrong_Entry_Red.isHidden = true
                     }else{
                         lblWrongEntry.isHidden = false
                         imgview8.isHidden = false

                         imgviewTop8.constant = 115.5

                         stackviewStatus.constant = 137.5
                         
                         lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                         btnWrong_Entry.isHidden = true
                         btnWrong_Entry_Red.isHidden = false
                     }
                     
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = false
                     lblcancelby.isHidden = true
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = false
                      imgview7.isHidden = true
                     
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = 98.5
                     imgviewTop7.constant = -12
                     
                     imgviewTopExtra.constant = -12

                     
                 }else{
                     
                     if wrong.isWrongEntry == 0 {
                         
                         lblWrongEntry.isHidden = true
                         imgview8.isHidden = true
                         
                         imgviewTop8.constant = -12

                         stackviewStatus.constant = 103.5

                         btnWrong_Entry.isHidden = false
                         btnWrong_Entry_Red.isHidden = true
                         
                     }else{
                         lblWrongEntry.isHidden = false
                         imgview8.isHidden = false

                        imgviewTop8.constant = 98.5

                        stackviewStatus.constant = 120.5
                         
                         lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                         btnWrong_Entry.isHidden = true
                         btnWrong_Entry_Red.isHidden = false
                     }
                     
                     lbldateintime.isHidden = true
                     lblintime.isHidden = false
                     lblouttime.isHidden = true
                     lbladdedby.isHidden = false
                     lblparceltime.isHidden = true
                     lblLeaveatGate.isHidden = true
                     lblcancelby.isHidden = false
                     lbldateintimeMulti.isHidden = true // Extra

                     imgview1.isHidden = true
                     imgview2.isHidden = false
                     imgview3.isHidden = true
                     imgview4.isHidden = false
                     imgview5.isHidden = true
                     imgview6.isHidden = true
                      imgview7.isHidden = true
                      imgviewExtra.isHidden = true
                     
                     imgviewTop1.constant = -12
                     imgviewTop2.constant = 64.5
                     imgviewTop3.constant = -12
                     imgviewTop4.constant = 81.5
                     imgviewTop5.constant = -12
                     imgviewTop6.constant = -12
                     imgviewTop7.constant = -12
                     
                     imgviewTopExtra.constant = -12
                    
                 }
                 

                            
                    constraintHightStackBtn.constant = 50
                    constraintHightStacklbl.constant = 0.5
                    lblHightStacklblMiddle.isHidden = false
                    
                    
                    btnOut.isHidden = false
                    
                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    btnRenew.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true
                 
                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                     
                }
                else if lblStatus.text == "CHECKED OUT" {
                 
                 lblStatus.backgroundColor = UIColor.systemRed

                 if activity.activityIn != nil {
                  
                  let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                  let strDate = strChangeDateFormate(strDateeee: lblDate!)
                  
                  let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                  let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 lblintime.text = "\(strTime) , \(strDate)"

                //  lblintime.text =  strTime + " , " + strDate
                  
              }
                 
                 if activity.out != nil {
                     
                     let lblDate = activity.out?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.out?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     lblouttime.text = "\(strTime) , \(strDate)"

                   //  lblouttime.text =  strTime + " , " + strDate
                     
                 }
                 
              lbladdedby.text = "Pre-Approved by " + (activity.addedBy)!
              
              if activity.leaveAtGate == "1" {
                  lblLeaveatGate.text = "Leave at Gate"
                  
                  if wrong.isWrongEntry == 0 {
                      
                      lblWrongEntry.isHidden = true
                      imgview8.isHidden = true
                      
                      imgviewTop8.constant = -12

                     stackviewStatus.constant = 137.5
                      

                      btnWrong_Entry.isHidden = false
                      btnWrong_Entry_Red.isHidden = true
                  }else{
                      lblWrongEntry.isHidden = false
                      imgview8.isHidden = false

                     imgviewTop8.constant = 132.5

                     stackviewStatus.constant = 154.5
                      
                      lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                      btnWrong_Entry.isHidden = true
                      btnWrong_Entry_Red.isHidden = false
                  }
                  
                  lbldateintime.isHidden = true
                  lblintime.isHidden = false
                  lblouttime.isHidden = false
                  lbladdedby.isHidden = false
                  lblparceltime.isHidden = true
                  lblLeaveatGate.isHidden = false
                  lblcancelby.isHidden = true
                  lbldateintimeMulti.isHidden = true // Extra

                  imgview1.isHidden = true
                  imgview2.isHidden = false
                  imgview3.isHidden = false
                  imgview4.isHidden = false
                  imgview5.isHidden = true
                  imgview6.isHidden = false
                   imgview7.isHidden = true
                  
                   imgviewExtra.isHidden = true
                  
                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = 81.5
                  imgviewTop4.constant = 98.5
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = 115.5
                 imgviewTop7.constant = -12
                  
                  imgviewTopExtra.constant = -12

                  
              }else{
                  
                  if wrong.isWrongEntry == 0 {
                      
                      lblWrongEntry.isHidden = true
                      imgview8.isHidden = true
                      
                      imgviewTop8.constant = -12

                     stackviewStatus.constant = 120.5

                      btnWrong_Entry.isHidden = false
                      btnWrong_Entry_Red.isHidden = true
                      
                  }else{
                      lblWrongEntry.isHidden = false
                      imgview8.isHidden = false

                     imgviewTop8.constant = 115.5

                     stackviewStatus.constant = 137.5
                      
                      lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!


                      btnWrong_Entry.isHidden = true
                      btnWrong_Entry_Red.isHidden = false
                  }
                  
                  lbldateintime.isHidden = true
                  lblintime.isHidden = false
                  lblouttime.isHidden = false
                  lbladdedby.isHidden = false
                  lblparceltime.isHidden = true
                  lblLeaveatGate.isHidden = true
                  lblcancelby.isHidden = false
                  lbldateintimeMulti.isHidden = true // Extra

                  imgview1.isHidden = true
                  imgview2.isHidden = false
                  imgview3.isHidden = false
                  imgview4.isHidden = false
                  imgview5.isHidden = true
                  imgview6.isHidden = true
                   imgview7.isHidden = true
                   imgviewExtra.isHidden = true
                  
                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = 81.5
                 imgviewTop4.constant = 98.5
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = -12
                  imgviewTop7.constant = -12
                  
                  imgviewTopExtra.constant = -12
                 
              }
              

                         
                 constraintHightStackBtn.constant = 50
                 constraintHightStacklbl.constant = 0.5
                 lblHightStacklblMiddle.isHidden = false
                 
                 
                 btnOut.isHidden = false
                 
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true
                 
                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true

             }
                else{
                    lblStatus.backgroundColor = AppColor.pollborderSelect
                 
                 lbldateintime.isHidden = true
                 lblintime.isHidden = true
                 lblouttime.isHidden = true
                 lbladdedby.isHidden = true
                 lblparceltime.isHidden = true
                 lblLeaveatGate.isHidden = true
                 lblcancelby.isHidden = true
                 lblWrongEntry.isHidden = true
                 lbldateintimeMulti.isHidden = true // Extra


                 imgview1.isHidden = true
                 imgview2.isHidden = true
                 imgview3.isHidden = true
                 imgview4.isHidden = true
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                 imgview7.isHidden = true
                 imgview8.isHidden = true
                 imgviewExtra.isHidden = true

           
                 imgviewTop1.constant = -12
                imgviewTop2.constant = -12
                imgviewTop3.constant = -12
                     imgviewTop4.constant = -12
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = -12
                imgviewTopExtra.constant = -12

                 stackviewStatus.constant =  69.5
                          
                    
                    constraintHightStackBtn.constant = 0
                    
                    constraintHightStacklbl.constant = 0

                    lblHightStacklblMiddle.isHidden = true
                   
                   
                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = true
                    btnRenew.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true
                 
                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true

                }
         
    }
    
    func setService_CabEntry(activity:ActivityAll,wrong:UserActivityAll) // Service/Cab
    {
        
        if (activity.ActivityType! == "Service Provider Pre-Approval") || (activity.ActivityType! == "Service Provider Entry") {
                lblname.text = "Service Provider"
               // imgview.image = UIImage(named: "ic_service")
            if activity.profilePic == "" || activity.profilePic == nil {
                imgview.image = UIImage(named: "ic_service")
            }else{
                imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "ic_service"))
            }
        }else if (activity.ActivityType  == "Cab Pre-Approval") || (activity.ActivityType  == "Cab Entry") {
            lblname.text = "Cab"
            if activity.profilePic == "" || activity.profilePic == nil {
                imgview.image = UIImage(named: "cab")
            }else{
                imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "cab"))
            }
           // imgview.image = UIImage(named: "cab")
        }
    
       
        if activity.companyName == "" || activity.companyName == nil {
            lblguest.text = ""
        }else{
            lblguest.text = activity.companyName
        }
        

       if activity.companyLogoURL == "" || activity.companyLogoURL == nil {
              imgviewCompanyLogo.image = UIImage(named: "default_logo")
             imgviewCompanyLogo.isHidden = false
         }else{
            imgviewCompanyLogo.sd_setImage(with: URL(string: (activity.companyLogoURL)!), placeholderImage: UIImage(named: "default_logo"))
            imgviewCompanyLogo.isHidden = false
         }     

            lblStatus.isHidden = false

            lblStatus.text = activity.status

          //  lbladdedby.text = "Added by " + (activity.addedBy)!
            
        if lblStatus.text == "NOT RESPONDED" {
            lblStatus.backgroundColor = AppColor.cancelColor
         
                 if activity.activityIn != nil {
                         let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        lblintime.text = "\(strTime) , \(strDate)"

                       //  lblintime.text = strTime + " , " + strDate
                 }
                      
            
            if wrong.isWrongEntry == 0 {
                 lblWrongEntry.text = "No Response"
                
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true

            }else{
                
                lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = false

            }

                // 13/1/20 temp comment
                
              /*  imgviewHight1.constant = 12
                imgviewHight2.constant = 0
              imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0
                imgviewHight6.constant = 0
              imgviewHight7.constant = 0
              imgviewHight8.constant = 0
              imgviewHightExtra.constant = 0
                 */
             
                imgview1.isHidden = true
                imgview2.isHidden = false
                imgview3.isHidden = true
                imgview4.isHidden = true
                imgview5.isHidden = true
                imgview6.isHidden = true
                imgview7.isHidden = true
                imgview8.isHidden = false
                imgviewExtra.isHidden = true
         
             imgviewTop1.constant = -12
             imgviewTop2.constant = 64.5
             imgviewTop3.constant = -12
             imgviewTop4.constant = -12
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = -12
             imgviewTop8.constant = 81.5
             imgviewTopExtra.constant = -12

             stackviewStatus.constant = 103.5
             
             constraintHightStackBtn.constant = 50
             constraintHightStacklbl.constant = 0.5
             lblHightStacklblMiddle.isHidden = true
             
             lblWrongEntry.isHidden = false
             lblintime.isHidden = false

             lbldateintime.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra
             lblouttime.isHidden = true
             lbladdedby.isHidden = true
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true

            
            btnCancel.isHidden = true
            btnEdit.isHidden = true
            
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnNote_Guard.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = true

        }
         else if lblStatus.text == "DENIED" {
                lblStatus.backgroundColor = AppColor.deniedColor
             
                if activity.activityIn != nil {
                     let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    // lblintime.text =  strTime + " , " + strDate
                    
                    lblintime.text = "\(strTime) , \(strDate)"

                     lblintime.isHidden = false
             }
            
                if activity.addedBy != nil {
                    lblWrongEntry.text = "Denied by " + (activity.deniedBy)!  //addedBy)!
                }else {
                    lblWrongEntry.text = "Denied by "
                }
            
                if wrong.isWrongEntry == 0 {
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                }else{
                   // lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false
                }

                    // 13/1/20 temp comment
                    
                  /*  imgviewHight1.constant = 12
                    imgviewHight2.constant = 0
                  imgviewHight3.constant = 12
                    imgviewHight4.constant = 0
                    imgviewHight5.constant = 0
                    imgviewHight6.constant = 0
                  imgviewHight7.constant = 0
                  imgviewHight8.constant = 0
                  imgviewHightExtra.constant = 0
                     */
                 
                    imgview1.isHidden = true
                    imgview2.isHidden = false
                    imgview3.isHidden = true
                    imgview4.isHidden = true
                    imgview5.isHidden = true
                    imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = false
                    imgviewExtra.isHidden = true

                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = -12
                imgviewTop4.constant = -12
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = 81.5
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5

             
             constraintHightStackBtn.constant = 50
             constraintHightStacklbl.constant = 0.5
             lblHightStacklblMiddle.isHidden = true
             
             lblWrongEntry.isHidden = false
             lblintime.isHidden = false
             
             lbldateintime.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra
             lblouttime.isHidden = true
             lbladdedby.isHidden = true
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
           
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            }
            else if lblStatus.text == "CANCELLED" {
                
                lblStatus.backgroundColor = AppColor.cancelColor
                
                lbladdedby.text = "Added by " + (activity.addedBy)!

            lblcancelby.text = "Cancelled by " + (activity.cancelledBy)!

              
            if activity.isMulti == "1" {
                
                if activity.activityIn != nil {
                        let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                    let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                    
                    lbldateintime.text = "\(strDate) - \(strDate1)"

                   // lbldateintime.text =  strDate + " - " + strDate1

                        let lblTime = activity.allowedInTime!
                        let strTime = strChangeTimeFormate(strDateeee: lblTime)
                    
                    let lblTime1 = activity.allowedOutTime!
                    let strTime1 = strChangeTimeFormate(strDateeee: lblTime1)

                    lbldateintimeMulti.text = "\(strTime) - \(strTime1)"

                }
                
                if wrong.isWrongEntry == 0 {
                    
                    imgview8.isHidden = true
                    lblWrongEntry.isHidden = true

                    imgviewTop8.constant = -12

                    stackviewStatus.constant = 137.5
                      
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true


                }else{
                    
                    imgview8.isHidden = false

                    lblWrongEntry.isHidden = false

                    lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    
                    imgviewTop8.constant = 132.5

                    stackviewStatus.constant = 154.5

                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false
                    

                }
                
                lblintime.isHidden = true
                
                lbldateintime.isHidden = false
                lbldateintimeMulti.isHidden = false // Extra
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = false
                   
                imgview1.isHidden = false
                imgview2.isHidden = true
                imgview3.isHidden = true
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                imgview7.isHidden = false
              //  imgview8.isHidden = true
                imgviewExtra.isHidden = false
                 
               
                imgviewTop1.constant = 64.5
                imgviewTop2.constant = -12
                imgviewTop3.constant = -12
                imgviewTop4.constant = 98.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = 115.5
               // imgviewTop8.constant = -12
                imgviewTopExtra.constant = 81.5

              //  stackviewStatus.constant = 137.5

                                
            }else {
                
                if activity.activityIn != nil {
                          let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                          let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         // lbldateintime.text =  strTime + " , " + strDate
                    
                          lbldateintime.text = "\(strTime) - \(strDate)"

                  }
                
                lbldateintime.isHidden = false
                
                if wrong.isWrongEntry == 0 {
                    
                    imgview8.isHidden = true
                    lblWrongEntry.isHidden = true

                    imgviewTop8.constant = -12

                    stackviewStatus.constant = 120.5
                      
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true


                }else{
                    
                    imgview8.isHidden = false

                    lblWrongEntry.isHidden = false

                    lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    
                    imgviewTop8.constant = 115.5

                    stackviewStatus.constant = 137.5

                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false
                    

                }

                lblintime.isHidden = true
                
                lbldateintimeMulti.isHidden = true // Extra
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = false
                   
                imgview1.isHidden = false
                imgview2.isHidden = true
                imgview3.isHidden = true
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                imgview7.isHidden = false
               // imgview8.isHidden = true
                imgviewExtra.isHidden = true
                 
               
                imgviewTop1.constant = 64.5
                imgviewTop2.constant = -12
                imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = 98.5
               // imgviewTop8.constant = -12
                imgviewTopExtra.constant = -12

              //  stackviewStatus.constant = 120.5
                                
            }
             
               
                constraintHightStackBtn.constant = 50
                constraintHightStacklbl.constant = 0.5
                lblHightStacklblMiddle.isHidden = true
                
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            }
            
            // 25/1/21 temp comment
            
            else if lblStatus.text == "EXPIRED" {
                lblStatus.backgroundColor = AppColor.cancelColor
                
                lbladdedby.text = "Added by " + (activity.addedBy)!
                
                if activity.isMulti == "1" {
                    
                    if activity.activityIn != nil {
                            let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                            let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                        let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                            
                       // lbldateintime.text =  strDate + " - " + strDate1

                        lbldateintime.text = "\(strDate) - \(strDate1)"

                            let lblTime = activity.allowedInTime!
                            let strTime = strChangeTimeFormate(strDateeee: lblTime)
                        
                        let lblTime1 = activity.allowedOutTime!
                        let strTime1 = strChangeTimeFormate(strDateeee: lblTime1)

                           lbldateintimeMulti.text = "\(strTime) - \(strTime1)"

                          //  lbldateintimeMulti.text =  strTime + " - " + strTime1
                    }
                    
                    lblWrongEntry.isHidden = true
                    lblintime.isHidden = true
                    
                    lbldateintime.isHidden = false
                    lbldateintimeMulti.isHidden = false // Extra
                    lblouttime.isHidden = true
                    lbladdedby.isHidden = false
                    lblparceltime.isHidden = true
                    lblLeaveatGate.isHidden = true
                    lblcancelby.isHidden = false
                       
                    imgview1.isHidden = false
                    imgview2.isHidden = true
                    imgview3.isHidden = true
                    imgview4.isHidden = false
                    imgview5.isHidden = true
                    imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = true
                    imgviewExtra.isHidden = false
                     
                   
                    imgviewTop1.constant = 64.5
                    imgviewTop2.constant = -12
                    imgviewTop3.constant = -12
                    imgviewTop4.constant = 98.5
                    imgviewTop5.constant = -12
                    imgviewTop6.constant = -12
                    imgviewTop7.constant = -12
                    imgviewTop8.constant = -12
                    imgviewTopExtra.constant = 81.5

                    stackviewStatus.constant = 120.5

                                    
                }else{
                    if activity.activityIn != nil {
                              let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                                lbldateintime.text = "\(strTime) , \(strDate)"

                            //  lbldateintime.text =  strTime + " , " + strDate
                      }
                    
                    lbldateintime.isHidden = false

                    lblWrongEntry.isHidden = true
                    lblintime.isHidden = true
                    
                    lbldateintimeMulti.isHidden = true // Extra
                    lblouttime.isHidden = true
                    lbladdedby.isHidden = false
                    lblparceltime.isHidden = true
                    lblLeaveatGate.isHidden = true
                    lblcancelby.isHidden = false
                       
                    imgview1.isHidden = false
                    imgview2.isHidden = true
                    imgview3.isHidden = true
                    imgview4.isHidden = false
                    imgview5.isHidden = true
                    imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = true
                    imgviewExtra.isHidden = true
                     
                   
                    imgviewTop1.constant = 64.5
                    imgviewTop2.constant = -12
                    imgviewTop3.constant = -12
                    imgviewTop4.constant = 81.5
                    imgviewTop5.constant = -12
                    imgviewTop6.constant = -12
                    imgviewTop7.constant = -12
                    imgviewTop8.constant = -12
                    imgviewTopExtra.constant = -12

                    stackviewStatus.constant = 103.5
                    
                }

                // 13/1/20 temp comment

             
             constraintHightStackBtn.constant = 50
             constraintHightStacklbl.constant = 0.5
             lblHightStacklblMiddle.isHidden = true
             

                btnRenew.isHidden = false
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true
                
            }
            else if lblStatus.text == "ADDED" {
           
                lblStatus.backgroundColor = AppColor.pollborderSelect

              if activity.isMulti == "1" {

                if activity.activityIn != nil {
                        let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                    let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                    let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                         lblintime.isHidden = false

                         lblintime.text = "\(strDate) - \(strDate1)"

                       // lblintime.text = strDate + " - " + strDate1
                }else{
                    lblintime.isHidden = true
                }
            }else{
                
                if activity.activityIn != nil {
                        let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                         lblintime.isHidden = false
                         lblintime.text = "\(strTime) , \(strDate)"

                }else{
                    lblintime.isHidden = true
                }
            }
               
             
               if wrong.isWrongEntry == 0 {
                   
                   imgview8.isHidden = true
                   lblWrongEntry.isHidden = true

                   imgviewTop8.constant = -12

                   stackviewStatus.constant = 103.5
                     
                   btnWrong_Entry.isHidden = false
                   btnWrong_Entry_Red.isHidden = true


               }else{
                   
                   imgview8.isHidden = false

                   lblWrongEntry.isHidden = false

                   lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                   
                   imgviewTop8.constant = 98.5

                   stackviewStatus.constant = 120.5

                   btnWrong_Entry.isHidden = true
                   btnWrong_Entry_Red.isHidden = false

               }

                lbladdedby.text = "Added by " + (activity.addedBy)!

             lbldateintime.isHidden = true
            // lblintime.isHidden = false
             lblouttime.isHidden = true
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
            // lblWrongEntry.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra
               
             
             imgview1.isHidden = true
             imgview2.isHidden = false
             imgview3.isHidden = true
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
              imgview7.isHidden = true
            //  imgview8.isHidden = true
              imgviewExtra.isHidden = true
             
             imgviewTop1.constant = -12
             imgviewTop2.constant = 64.5
             imgviewTop3.constant = -12
             imgviewTop4.constant = 81.5
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = -12
            // imgviewTop8.constant = -12
             imgviewTopExtra.constant = -12

            // stackviewStatus.constant = 103.5
                                
                constraintHightStackBtn.constant = 50
                constraintHightStacklbl.constant = 0.5
                lblHightStacklblMiddle.isHidden = false
                
                 btnInviteShare.isHidden = true
                 btnExtraShow.isHidden = false

                
                 btnOut.isHidden = false

                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            }
            else if lblStatus.text == "VISITED" {
                lblStatus.backgroundColor = AppColor.cancelColor
             
             if activity.out != nil {
                 
                 let lblDate = activity.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = activity.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 lblouttime.text =  strTime + " , " + strDate
                 
                 lblouttime.isHidden = false

             }else{
                 lblouttime.isHidden = true
             }
                
                
                constraintHightStackBtn.constant = 50

                constraintHightStacklbl.constant = 0.5

                lblHightStacklblMiddle.isHidden = true
                
                if wrong.isWrongEntry == 0 {
                    lblWrongEntry.isHidden = true
                    imgview8.isHidden = true
                    
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                 
                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = false
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
               //  imgview8.isHidden = true
                  imgviewExtra.isHidden = true

                 imgviewTop1.constant = -12
                 imgviewTop2.constant = 64.5
                 imgviewTop3.constant = 81.5
                 imgviewTop4.constant = 98.5
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = -12
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 120.5
                      

                }else{
                    lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    lblWrongEntry.isHidden = false
                    imgview8.isHidden = false
                    
                    btnWrong_Entry_Red.isHidden = false
                    btnWrong_Entry.isHidden = true
                 
                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = false
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
               //  imgview8.isHidden = true
                  imgviewExtra.isHidden = true

                 imgviewTop1.constant = -12
                 imgviewTop2.constant = 64.5
                 imgviewTop3.constant = 81.5
                 imgviewTop4.constant = 98.5
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = 115.5
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 137.5
                                  

                }
                
                // 13/1/20 temp comment
                
               /* imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0 */

             lbldateintime.isHidden = true
             lblintime.isHidden = false
            // lblouttime.isHidden = false
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
           //  lblWrongEntry.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra


                btnDeliveryInfo.isHidden = true
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnAlertInfo.isHidden = true

            }
            else if lblStatus.text == "APPROVED" {
                
                    lblStatus.backgroundColor = AppColor.pollborderSelect
                
                     if activity.approvedBy != nil {
                         lbladdedby.text = "Approved by " + (activity.approvedBy)!
                     }else {
                         lbladdedby.text = "Approved by "
                     }
            
             if activity.isMulti == "1" {
                if activity.activityIn != nil {
                          let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.allowedInTime!
                          let strTime = strChangeTimeFormate(strDateeee: lblTime)

                            lblintime.text = "\(strTime) , \(strDate)"

                         // lblintime.text =  strTime + " , " + strDate
                  }
                
                if activity.out != nil {
                          let lblDate = activity.out?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.allowedOutTime!
                          let strTime = strChangeTimeFormate(strDateeee: lblTime)

                         // lbldateintimeMulti.text =  strTime + " , " + strDate
                   
                         lbldateintimeMulti.text = "\(strTime) , \(strDate)"

                  }
                
                lbldateintime.isHidden = true
                lblintime.isHidden = false
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = true
                lbldateintimeMulti.isHidden = false // Extra


                 // 13/1/20 temp comment

                 /*  imgviewHight1.constant = 12
                   imgviewHight2.constant = 0
                   imgviewHight3.constant = 12
                   imgviewHight4.constant = 0
                   imgviewHight5.constant = 0
                   imgviewHight6.constant = 0 */

                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = true
                   imgview4.isHidden = false
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                   imgview7.isHidden = true
                   imgview8.isHidden = true
                   imgviewExtra.isHidden = false

                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = -12
                imgviewTopExtra.constant = 98.5

                stackviewStatus.constant = 120.5
                   
            }
            else{
                
                if activity.activityIn != nil {
                          let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                          let strDate = strChangeDateFormate(strDateeee: lblDate!)
                          
                          let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                          let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                        
                        lblintime.text = "\(strTime) , \(strDate)"

                        //  lblintime.text =  strTime + " , " + strDate
                  }
                
                lbldateintime.isHidden = true
                lblintime.isHidden = false
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra


                 // 13/1/20 temp comment

                 /*  imgviewHight1.constant = 12
                   imgviewHight2.constant = 0
                   imgviewHight3.constant = 12
                   imgviewHight4.constant = 0
                   imgviewHight5.constant = 0
                   imgviewHight6.constant = 0 */

                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = true
                   imgview4.isHidden = false
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                   imgview7.isHidden = true
                   imgview8.isHidden = true
                   imgviewExtra.isHidden = true

                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = -12
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5
                   
            }

                
                     constraintHightStackBtn.constant = 50
                     constraintHightStacklbl.constant = 0.5
                     lblHightStacklblMiddle.isHidden = true
                  
              
                btnClose.isHidden = false
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = true
                btnRenew.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            }
            else if lblStatus.text == "PRE-APPROVAL" || lblStatus.text == "PRE-APPROVED" {  // right
                lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if activity.approvedBy != nil {
                    lbladdedby.text = "Pre Approved by " + (activity.approvedBy)!
                }else {
                    lbladdedby.text = "Pre Approved by "
                }
                
                if activity.isMulti == "1" {
                    
                    if activity.activityIn != nil {
                            let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                            let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblDate1 = activity.out?.components(separatedBy: " ")[0]
                        let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                            
                        lbldateintime.text = "\(strDate) - \(strDate1)"

                       // lbldateintime.text =  strDate + " - " + strDate1

                            let lblTime = activity.allowedInTime!
                            let strTime = strChangeTimeFormate(strDateeee: lblTime)
                        
                        let lblTime1 = activity.allowedOutTime!
                        let strTime1 = strChangeTimeFormate(strDateeee: lblTime1)

                        lbldateintimeMulti.text = "\(strTime) - \(strTime1)"

                           // lbldateintimeMulti.text =  strTime + " - " + strTime1
                    }
                    
                    lbldateintime.isHidden = false
                    lblintime.isHidden = true
                    lblouttime.isHidden = true
                    lbladdedby.isHidden = false
                    lblparceltime.isHidden = true
                    lblLeaveatGate.isHidden = true
                    lblcancelby.isHidden = true
                    lblWrongEntry.isHidden = true
                    lbldateintimeMulti.isHidden = false // Extra


                    imgview1.isHidden = false
                    imgview2.isHidden = true
                    imgview3.isHidden = true
                    imgview4.isHidden = false
                    imgview5.isHidden = true
                    imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = true
                    imgviewExtra.isHidden = false

                    imgviewTop1.constant = 64.5
                    imgviewTop2.constant = -12
                    imgviewTop3.constant = -12
                    imgviewTop4.constant = 98.5
                    imgviewTop5.constant = -12
                    imgviewTop6.constant = -12
                    imgviewTop7.constant = -12
                    imgviewTop8.constant = -12
                    imgviewTopExtra.constant = 81.5

                    stackviewStatus.constant = 120.5
                         
                    
                }else{
                    
                    if activity.activityIn != nil {
                              let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                               lbldateintime.text = "\(strTime) , \(strDate)"

                             // lbldateintime.text =  strTime + " , " + strDate
                      }
                    
                    lbldateintime.isHidden = false
                    lblintime.isHidden = true
                    lblouttime.isHidden = true
                    lbladdedby.isHidden = false
                    lblparceltime.isHidden = true
                    lblLeaveatGate.isHidden = true
                    lblcancelby.isHidden = true
                    lblWrongEntry.isHidden = true
                    lbldateintimeMulti.isHidden = true // Extra


                    imgview1.isHidden = false
                    imgview2.isHidden = true
                    imgview3.isHidden = true
                    imgview4.isHidden = false
                    imgview5.isHidden = true
                    imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = true
                    imgviewExtra.isHidden = true

                    imgviewTop1.constant = 64.5
                    imgviewTop2.constant = -12
                    imgviewTop3.constant = -12
                    imgviewTop4.constant = 81.5
                    imgviewTop5.constant = -12
                    imgviewTop6.constant = -12
                    imgviewTop7.constant = -12
                    imgviewTop8.constant = -12
                    imgviewTopExtra.constant = -12

                    stackviewStatus.constant = 103.5
                         
                }
                    
                // 13/1/20 temp comment

              /*  imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0
                imgviewHight6.constant = 0 */
             
           /*  lbldateintime.isHidden = false
             lblintime.isHidden = true
             lblouttime.isHidden = true
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
             lblWrongEntry.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra


             imgview1.isHidden = false
             imgview2.isHidden = true
             imgview3.isHidden = true
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
             imgview7.isHidden = true
             imgview8.isHidden = true
             imgviewExtra.isHidden = true

             imgviewTop1.constant = 64.5
             imgviewTop2.constant = -12
             imgviewTop3.constant = -12
             imgviewTop4.constant = 81.5
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = -12
             imgviewTop8.constant = -12
             imgviewTopExtra.constant = -12

             stackviewStatus.constant = 103.5 */
                  
             constraintHightStackBtn.constant = 50
             constraintHightStacklbl.constant = 0.5
             lblHightStacklblMiddle.isHidden = false
             

                btnCancel.isHidden = false
                btnEdit.isHidden = false
                
                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = true
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            }
            else if lblStatus.text == "LEFT" {
                lblStatus.backgroundColor = AppColor.cancelColor
                
                if activity.activityIn != nil {
                    
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                   // lblintime.text =  strTime + " , " + strDate
                   
                   lblintime.text = "\(strTime) , \(strDate)"

                    lblintime.isHidden = false

                }else{
                    lblintime.isHidden = true
                }
             
             if activity.out != nil {
                 
                 let lblDate = activity.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = activity.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                // lblouttime.text =  strTime + " , " + strDate
                
                lblouttime.text = "\(strTime) , \(strDate)"

                 lblouttime.isHidden = false

             }else{
                 lblouttime.isHidden = true
             }
                
                if activity.approvedBy != nil {
                    lbladdedby.text = "Pre Approved by " + (activity.approvedBy)!
                }else {
                    lbladdedby.text = "Pre Approved by "
                }
                
                constraintHightStackBtn.constant = 0

                constraintHightStacklbl.constant = 0

                lblHightStacklblMiddle.isHidden = true
                
                if wrong.isWrongEntry == 0 {
                    lblWrongEntry.isHidden = true
                    imgview8.isHidden = true
                    
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                 
                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = false
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
               //  imgview8.isHidden = true
                  imgviewExtra.isHidden = true

                 imgviewTop1.constant = -12
                 imgviewTop2.constant = 64.5
                 imgviewTop3.constant = 81.5
                 imgviewTop4.constant = 98.5
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = -12
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 120.5
                      

                }else{
                    lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    lblWrongEntry.isHidden = false
                    imgview8.isHidden = false
                    
                    btnWrong_Entry_Red.isHidden = false
                    btnWrong_Entry.isHidden = true
                 
                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = false
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
               //  imgview8.isHidden = true
                  imgviewExtra.isHidden = true

                 imgviewTop1.constant = -12
                 imgviewTop2.constant = 64.5
                 imgviewTop3.constant = 81.5
                 imgviewTop4.constant = 98.5
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = 115.5
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 137.5
                                  

                }
                
                // 13/1/20 temp comment
                
               /* imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0 */

             lbldateintime.isHidden = true
           //  lblintime.isHidden = false
            // lblouttime.isHidden = false
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
           //  lblWrongEntry.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra


           
                 btnDeliveryInfo.isHidden = true
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnAlertInfo.isHidden = true

            }
            else if lblStatus.text == "CHECKED IN" {
                lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if activity.activityIn != nil {
                        let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                       // lblintime.text =  strTime + " , " + strDate
                  
                        lblintime.text = "\(strTime) , \(strDate)"

                        lblintime.isHidden = false
                }else{
                    lblintime.isHidden = true
                }
                
                if activity.approvedBy != nil {
                    lbladdedby.text = "Pre Approved by " + (activity.approvedBy)!
                }else {
                    lbladdedby.text = "Pre Approved by "
                }
                
             lbldateintime.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra
            // lblintime.isHidden = false
             lblouttime.isHidden = true
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
             lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0
                imgviewHight6.constant = 0 */

                imgview1.isHidden = true
                imgview2.isHidden = false
                imgview3.isHidden = true
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                 imgview7.isHidden = true
                 imgview8.isHidden = true
                 imgviewExtra.isHidden = true
                  
             imgviewTop1.constant = -12
             imgviewTop2.constant = 64.5
             imgviewTop3.constant = -12
             imgviewTop4.constant = 81.5
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = -12
             imgviewTop8.constant = -12
             imgviewTopExtra.constant = -12

             stackviewStatus.constant = 103.5
             
             
             constraintHightStackBtn.constant = 50
             constraintHightStacklbl.constant = 0.5
             lblHightStacklblMiddle.isHidden = true
             

                btnRenew.isHidden = true
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = false
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true
                
            }
            else if lblStatus.text == "CHECKED OUT" {
                
                lblStatus.backgroundColor = UIColor.systemRed

                if activity.activityIn != nil {
                    
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                //    lblintime.text = strTime + " , " + strDate
                    
                    lblintime.text = "\(strTime) , \(strDate)"
                    
                    lblintime.isHidden = false

                }else{
                    lblintime.isHidden = true
                }
                
                if activity.out != nil {
                    
                    let lblDate = activity.out?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.out?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                   // lblouttime.text =  strTime + " , " + strDate
                    
                    lblouttime.text = "\(strTime) , \(strDate)"

                    lblouttime.isHidden = false

                }else{
                    lblouttime.isHidden = true
                }
                
                if activity.approvedBy != nil {
                    lbladdedby.text = "Pre Approved by " + (activity.approvedBy)!
                }else {
                    lbladdedby.text = "Pre Approved by "
                }
                
                if wrong.isWrongEntry == 0 {
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                }else{
                   // lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false
                }
                
             lbldateintime.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra
            // lblintime.isHidden = false
           //  lblouttime.isHidden = false
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
             lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0
                imgviewHight6.constant = 0 */

                imgview1.isHidden = true
                imgview2.isHidden = false
                imgview3.isHidden = false
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                 imgview7.isHidden = true
                 imgview8.isHidden = true
                 imgviewExtra.isHidden = true
                  
             imgviewTop1.constant = -12
             imgviewTop2.constant = 64.5
             imgviewTop3.constant = 81.5
             imgviewTop4.constant = 98.5
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = -12
             imgviewTop8.constant = -12
             imgviewTopExtra.constant = -12

                stackviewStatus.constant = 120.5
             
             
             constraintHightStackBtn.constant = 50
             constraintHightStacklbl.constant = 0.5
             lblHightStacklblMiddle.isHidden = false
             

                btnRenew.isHidden = true
                btnCancel.isHidden = true
                btnEdit.isHidden = true
               // btnWrong_Entry.isHidden = false
               // btnWrong_Entry_Red.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = false
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true
                             
            }
          /*  else if lblStatus.text == "DELIVERED" || lblStatus.text == "ATTENDED" {
                
                lblStatus.backgroundColor = AppColor.cancelColor
                
                if activity.activityIn != nil {
                    
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    lblintime.text = strTime + " , " + strDate
                    
                    lblintime.isHidden = false

                }else{
                    lblintime.isHidden = true
                }
                
                if activity.out != nil {
                    
                    let lblDate = activity.out?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.out?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    lblouttime.text =  strTime + " , " + strDate
                    
                    lblouttime.isHidden = false

                }else{
                    lblouttime.isHidden = true
                }
                
                if activity.approvedBy != nil {
                    lbladdedby.text = "Pre Approved by " + (activity.approvedBy)!
                }else {
                    lbladdedby.text = "Pre Approved by "
                }
                
             lbldateintime.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra
             lblintime.isHidden = false
             lblouttime.isHidden = false
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
             lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0
                imgviewHight6.constant = 0 */

                imgview1.isHidden = true
                imgview2.isHidden = false
                imgview3.isHidden = false
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                 imgview7.isHidden = true
                 imgview8.isHidden = true
                 imgviewExtra.isHidden = true
                  
             imgviewTop1.constant = -12
             imgviewTop2.constant = 64.5
             imgviewTop3.constant = 81.5
             imgviewTop4.constant = 98.5
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = -12
             imgviewTop8.constant = -12
             imgviewTopExtra.constant = -12

                stackviewStatus.constant = 120.5
             
             
             constraintHightStackBtn.constant = 0
             constraintHightStacklbl.constant = 0
             lblHightStacklblMiddle.isHidden = true
             

                btnRenew.isHidden = true
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true

            } */
            else{
                lblStatus.backgroundColor = AppColor.pollborderSelect
                
                 
                  lbldateintime.isHidden = true
                  lblintime.isHidden = true
                  lblouttime.isHidden = true
                  lbladdedby.isHidden = true
                  lblparceltime.isHidden = true
                  lblLeaveatGate.isHidden = true
                  lblcancelby.isHidden = true
                  lblWrongEntry.isHidden = true
                  lbldateintimeMulti.isHidden = true // Extra


                  imgview1.isHidden = true
                  imgview2.isHidden = true
                  imgview3.isHidden = true
                  imgview4.isHidden = true
                  imgview5.isHidden = true
                  imgview6.isHidden = true
                  imgview7.isHidden = true
                  imgview8.isHidden = true
                  imgviewExtra.isHidden = true

             constraintHightStackBtn.constant = 0
             
             constraintHightStacklbl.constant = 0

             lblHightStacklblMiddle.isHidden = true
          
             
             imgviewTop1.constant = -12
             imgviewTop2.constant = -12
             imgviewTop3.constant = -12
             imgviewTop4.constant = -12
             imgviewTop5.constant = -12
             imgviewTop6.constant = -12
             imgviewTop7.constant = -12
             imgviewTop8.constant = -12
             imgviewTopExtra.constant = -12

                stackviewStatus.constant = 80.5 // 69.5
               
             
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 btnWrong_Entry.isHidden = true
                 btnWrong_Entry_Red.isHidden = true
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true

            }
            
            btnInviteShare.isHidden = true
            btnExtraShow.isHidden = false

           btnIn_OnDemand.isHidden = true
           btnCancel_OnDemand.isHidden = true
           btnOut_OnDemand.isHidden = true
           btnEdit_OnDemand.isHidden = true
             
    }
    
    func setDailyEntry(activity:ActivityAll,wrong:UserActivityAll) // Daily
    {
        
            lblStatus.isHidden = false
            
            btnInviteShare.isHidden = true
            btnExtraShow.isHidden = false

            imgviewCompanyLogo.isHidden = true
            
             if activity.profilePic == "" || activity.profilePic == nil {
                 imgview.image = UIImage(named: "vendor-1")
             }else{
                 imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
             }

            lblname.text = activity.name
            
            if activity.vendorServiceTypeName == "" || activity.vendorServiceTypeName == nil {
                lblguest.text = ""
            }else{
                lblguest.text = activity.vendorServiceTypeName
            }
            
            lblStatus.text = activity.status
            
            if lblStatus.text == "CHECKED IN" {
                
                lblStatus.backgroundColor = AppColor.pollborderSelect

                    if activity.activityIn != nil {
                        
                        let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        lblintime.text = "\(strTime) , \(strDate)"

                       // lblintime.text =  strTime + " , " + strDate
                        
                    }
                
                lbladdedby.text = "Added by " + (activity.addedBy)!
                
                if wrong.isWrongEntry == 0 {
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                }else{
                   // lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false
                }
                

                lbldateintime.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra
                lblintime.isHidden = false
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = true

                   // 13/1/20 temp comment

                 /*  imgviewHight1.constant = 12
                   imgviewHight2.constant = 0
                   imgviewHight3.constant = 12
                   imgviewHight4.constant = 0
                   imgviewHight5.constant = 0
                   imgviewHight6.constant = 0 */

                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = true
                   imgview4.isHidden = false
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = true
                    imgviewExtra.isHidden = true
                     
                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = -12
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5
                
                
                          btnCancel.isHidden = true
                          btnEdit.isHidden = true
                          
                        //  btnWrong_Entry.isHidden = false
                        //  btnWrong_Entry_Red.isHidden = true

                          btnRenew.isHidden = true
                          btnClose.isHidden = true
                          btnNote_Guard.isHidden = true
                          btnOut.isHidden = false
                          btnDeliveryInfo.isHidden = true
                          btnAlertInfo.isHidden = true
                          
                   constraintHightStackBtn.constant = 50
                   
                   constraintHightStacklbl.constant = 0.5

                   lblHightStacklblMiddle.isHidden = false

            }else if lblStatus.text == "CHECKED OUT" {
                
                lblStatus.backgroundColor = UIColor.systemRed

                if activity.activityIn != nil {
                    
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                   // lblintime.text =  strTime + " , " + strDate
                 
                    lblintime.text = "\(strTime) , \(strDate)"

                    lblintime.isHidden = false

                }else{
                    lblintime.isHidden = true
                }
                
                if activity.out != nil {
                    
                    let lblDate = activity.out?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.out?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                   // lblouttime.text =  strTime + " , " + strDate
                 
                   lblouttime.text = "\(strTime) , \(strDate)"
                    
                }
                
                lbladdedby.text = "Added by " + (activity.addedBy)!
                
                if wrong.isWrongEntry == 0 {
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                }else{
                   // lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = false
                }
                

                lbldateintime.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra
                lblintime.isHidden = false
                lblouttime.isHidden = false
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = true

                   // 13/1/20 temp comment

                 /*  imgviewHight1.constant = 12
                   imgviewHight2.constant = 0
                   imgviewHight3.constant = 12
                   imgviewHight4.constant = 0
                   imgviewHight5.constant = 0
                   imgviewHight6.constant = 0 */

                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = false
                   imgview4.isHidden = false
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = true
                    imgviewExtra.isHidden = true
                     
                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = 81.5
                imgviewTop4.constant = 98.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = -12
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 120.5
                
                
                          btnCancel.isHidden = true
                          btnEdit.isHidden = true
                          
                         // btnWrong_Entry.isHidden = false
                       //   btnWrong_Entry_Red.isHidden = true

                          btnRenew.isHidden = true
                          btnClose.isHidden = true
                          btnNote_Guard.isHidden = false
                          btnOut.isHidden = true
                          btnDeliveryInfo.isHidden = true
                          btnAlertInfo.isHidden = true
                          
                   constraintHightStackBtn.constant = 50
                   
                   constraintHightStacklbl.constant = 0.5

                   lblHightStacklblMiddle.isHidden = false
                       

                
            }
            else if lblStatus.text == "DENIED" {
            
                   lblStatus.backgroundColor = UIColor.systemRed
                
                if activity.activityIn != nil {
                    
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                  //  lblintime.text =  strTime + " , " + strDate
                    
                     lblintime.text = "\(strTime) , \(strDate)"

                    lblintime.isHidden = false

                }else{
                    lblintime.isHidden = true
                }
                  
                         if activity.deniedBy != nil {
                            
                             lblWrongEntry.text = "Denied by " + (activity.deniedBy)!
                         
                             btnWrong_Entry.isHidden = false
                            
                             btnWrong_Entry_Red.isHidden = true
                             
                         }else{
                            
                            lblWrongEntry.text = "Denied by "
                             
                             btnWrong_Entry.isHidden = true
                             
                             btnWrong_Entry_Red.isHidden = false
                             
                }
                
                    
                lbldateintime.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra
                lblintime.isHidden = false
                lblouttime.isHidden = true
                lbladdedby.isHidden = true
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = false

                   // 13/1/20 temp comment

                 /*  imgviewHight1.constant = 12
                   imgviewHight2.constant = 0
                   imgviewHight3.constant = 12
                   imgviewHight4.constant = 0
                   imgviewHight5.constant = 0
                   imgviewHight6.constant = 0 */

                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = true
                   imgview4.isHidden = true
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = false
                    imgviewExtra.isHidden = true
                     
                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = -12
                imgviewTop4.constant = -12
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = 81.5
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5
                
                
                          btnCancel.isHidden = true
                          btnEdit.isHidden = true
                          
                         // btnWrong_Entry.isHidden = false
                        //  btnWrong_Entry_Red.isHidden = true

                          btnRenew.isHidden = true
                          btnClose.isHidden = true
                          btnNote_Guard.isHidden = true
                          btnOut.isHidden = true
                          btnDeliveryInfo.isHidden = true
                          btnAlertInfo.isHidden = true
                    
                    constraintHightStackBtn.constant = 50
                    
                    constraintHightStacklbl.constant = 0.5

                    lblHightStacklblMiddle.isHidden = true
            
            
            }else if lblStatus.text == "NOT RESPONDED" {
                
                lblStatus.backgroundColor = AppColor.cancelColor // ratingBorderColor

                if activity.activityIn != nil {
                    
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                   // lblintime.text =  strTime + " , " + strDate
                 
                     lblintime.text = "\(strTime) , \(strDate)"

                    
                }
                
                
                      if wrong.isWrongEntry == 0 {
                         
                          lblWrongEntry.text = "No Response"
                                               
                          btnWrong_Entry.isHidden = false
                          btnWrong_Entry_Red.isHidden = true

                         
                          
                      }else{
                                                
                          lblWrongEntry.text = "No Response" + (activity.wrongEntryBy)!
                        
                        btnWrong_Entry.isHidden = true
                        btnWrong_Entry_Red.isHidden = false

                          
                      }
                
                lbldateintime.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra
                lblintime.isHidden = false
                lblouttime.isHidden = true
                lbladdedby.isHidden = true
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = false

                   // 13/1/20 temp comment

                 /*  imgviewHight1.constant = 12
                   imgviewHight2.constant = 0
                   imgviewHight3.constant = 12
                   imgviewHight4.constant = 0
                   imgviewHight5.constant = 0
                   imgviewHight6.constant = 0 */

                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = true
                   imgview4.isHidden = true
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = false
                    imgviewExtra.isHidden = true
                     
                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = -12
                imgviewTop4.constant = -12
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = 81.5
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5
                
                
                          btnCancel.isHidden = true
                          btnEdit.isHidden = true
                          
                          btnRenew.isHidden = true
                          btnClose.isHidden = true
                          btnNote_Guard.isHidden = true
                          btnOut.isHidden = true
                          btnDeliveryInfo.isHidden = true
                          btnAlertInfo.isHidden = true
                
                constraintHightStackBtn.constant = 50
                
                constraintHightStacklbl.constant = 0.5

                lblHightStacklblMiddle.isHidden = true

                
            }else if lblStatus.text == "ADDED"{
                
                   lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if activity.addedOn != nil {
                    
                    let lblDate = activity.addedOn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.addedOn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    // lblintime.text =  strTime + " , " + strDate
                 
                    lblintime.text = "\(strTime) , \(strDate)"

                }
                   
                lbladdedby.text = "Added by " + (activity.addedBy)!

                      
                if wrong.isWrongEntry == 0 {
                                         
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true

                    
              lbldateintime.isHidden = true
              lbldateintimeMulti.isHidden = true // Extra
              lblintime.isHidden = false
              lblouttime.isHidden = true
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = true
              lblWrongEntry.isHidden = true

                 // 13/1/20 temp comment

               /*  imgviewHight1.constant = 12
                 imgviewHight2.constant = 0
                 imgviewHight3.constant = 12
                 imgviewHight4.constant = 0
                 imgviewHight5.constant = 0
                 imgviewHight6.constant = 0 */

                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = true
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
                  imgview8.isHidden = true
                  imgviewExtra.isHidden = true
                       
                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = -12
                  imgviewTop4.constant = 81.5
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = -12
                  imgviewTop7.constant = -12
                  imgviewTop8.constant = -12
                  imgviewTopExtra.constant = -12

                  stackviewStatus.constant = 103.5

                    
                        btnCancel.isHidden = true
                        btnEdit.isHidden = true
                        
                        btnRenew.isHidden = true
                        btnClose.isHidden = true
                        btnNote_Guard.isHidden = true
                        btnOut.isHidden = true
                        btnDeliveryInfo.isHidden = true
                        btnAlertInfo.isHidden = true
                                                                
                }else{
                                          
                    lblWrongEntry.text = "Wrong Entry Reported by" + (activity.wrongEntryBy)!
                  
                  btnWrong_Entry.isHidden = true
                  btnWrong_Entry_Red.isHidden = false

                    
              lbldateintime.isHidden = true
              lbldateintimeMulti.isHidden = true // Extra
              lblintime.isHidden = false
              lblouttime.isHidden = true
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = true
              lblWrongEntry.isHidden = false

                 // 13/1/20 temp comment

               /*  imgviewHight1.constant = 12
                 imgviewHight2.constant = 0
                 imgviewHight3.constant = 12
                 imgviewHight4.constant = 0
                 imgviewHight5.constant = 0
                 imgviewHight6.constant = 0 */

                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = true
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
                  imgview8.isHidden = false
                  imgviewExtra.isHidden = true
                   
              imgviewTop1.constant = -12
              imgviewTop2.constant = 64.5
              imgviewTop3.constant = -12
              imgviewTop4.constant = 81.5
              imgviewTop5.constant = -12
              imgviewTop6.constant = -12
              imgviewTop7.constant = -12
              imgviewTop8.constant = 98.5
              imgviewTopExtra.constant = -12

              stackviewStatus.constant = 120.5
              
              
                        btnCancel.isHidden = true
                        btnEdit.isHidden = true
                        
                        btnRenew.isHidden = true
                        btnClose.isHidden = true
                        btnNote_Guard.isHidden = true
                        btnOut.isHidden = true
                        btnDeliveryInfo.isHidden = true
                        btnAlertInfo.isHidden = true
                    
                    
                }
                      
                                
                   
                   constraintHightStackBtn.constant = 50
                   
                   constraintHightStacklbl.constant = 0.5

                   lblHightStacklblMiddle.isHidden = true
               
            }else if lblStatus.text == "VISITED" {
                
                lblStatus.backgroundColor = AppColor.cancelColor
                
                if activity.activityIn != nil {
                    
                    let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                  //  lblintime.text =  strTime + " , " + strDate
                    
                    lblintime.text = "\(strTime) , \(strDate)"

                }
             
             if activity.out != nil {
                 
                 let lblDate = activity.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = activity.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                // lblouttime.text =  strTime + " , " + strDate

                 lblouttime.text = "\(strTime) , \(strDate)"

             }
                
                lbladdedby.text = "Added by " + (activity.addedBy)!
                
                constraintHightStackBtn.constant = 50

                constraintHightStacklbl.constant = 0.5

                lblHightStacklblMiddle.isHidden = true
                
                if wrong.isWrongEntry == 0 {
                    lblWrongEntry.isHidden = true
                    imgview8.isHidden = true
                    
                    btnWrong_Entry.isHidden = false
                    btnWrong_Entry_Red.isHidden = true
                 
                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = false
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
               //  imgview8.isHidden = true
                  imgviewExtra.isHidden = true

                 imgviewTop1.constant = -12
                 imgviewTop2.constant = 64.5
                 imgviewTop3.constant = 81.5
                 imgviewTop4.constant = 98.5
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = -12
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 120.5
                      

                }else{
                    lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
                    lblWrongEntry.isHidden = false
                    imgview8.isHidden = false
                    
                    btnWrong_Entry_Red.isHidden = false
                    btnWrong_Entry.isHidden = true
                 
                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = false
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
               //  imgview8.isHidden = true
                  imgviewExtra.isHidden = true

                 imgviewTop1.constant = -12
                 imgviewTop2.constant = 64.5
                 imgviewTop3.constant = 81.5
                 imgviewTop4.constant = 98.5
                 imgviewTop5.constant = -12
                 imgviewTop6.constant = -12
                 imgviewTop7.constant = -12
                 imgviewTop8.constant = 115.5
                 imgviewTopExtra.constant = -12

                 stackviewStatus.constant = 137.5
                                  

                }
                
                // 13/1/20 temp comment
                
               /* imgviewHight1.constant = 12
                imgviewHight2.constant = 0
                imgviewHight3.constant = 12
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0 */

             lbldateintime.isHidden = true
             lblintime.isHidden = false
             lblouttime.isHidden = false
             lbladdedby.isHidden = false
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
           //  lblWrongEntry.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra


           
                 btnDeliveryInfo.isHidden = true
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnAlertInfo.isHidden = true
                
            }
            else if lblStatus.text == "REMOVED" {
               lblStatus.backgroundColor = UIColor.systemRed
                
                if activity.addedOn != nil {
                    
                    let lblDate = activity.addedOn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = activity.addedOn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                   // lblintime.text =  strTime + " , " + strDate
                 
                    lblintime.text = "\(strTime) , \(strDate)"


                }
                
                lblWrongEntry.text = "Removed by " + (activity.removedBy)!

                
                lbldateintime.isHidden = true
                lblintime.isHidden = false
                lblouttime.isHidden = true
                lbladdedby.isHidden = true
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = false
                lbldateintimeMulti.isHidden = true // Extra


                imgview1.isHidden = true
                imgview2.isHidden = false
                imgview3.isHidden = true
                imgview4.isHidden = true
                imgview5.isHidden = true
                imgview6.isHidden = true
                imgview7.isHidden = true
                imgview8.isHidden = false
                imgviewExtra.isHidden = true

          
                imgviewTop1.constant = -12
           imgviewTop2.constant = 64.5
           imgviewTop3.constant = -12
                imgviewTop4.constant = -12
           imgviewTop5.constant = -12
           imgviewTop6.constant = -12
           imgviewTop7.constant = -12
                imgviewTop8.constant = 81.5
           imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5 // 69.5
             
                         
                     constraintHightStackBtn.constant = 0
                     
                     constraintHightStacklbl.constant = 0

                     lblHightStacklblMiddle.isHidden = true
                     
                     btnCancel.isHidden = true
                     btnEdit.isHidden = true
                     btnWrong_Entry.isHidden = true
                     btnWrong_Entry_Red.isHidden = true
                     btnRenew.isHidden = true
                     btnClose.isHidden = true
                     btnNote_Guard.isHidden = true
                     btnOut.isHidden = true
                     btnDeliveryInfo.isHidden = true
                     btnAlertInfo.isHidden = true
         
                    btnInviteShare.isHidden = true
                    btnExtraShow.isHidden = false

                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                 
                
                
                constraintHightStackBtn.constant = 0
                
                constraintHightStacklbl.constant = 0

                lblHightStacklblMiddle.isHidden = true
                
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnAlertInfo.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnWrong_Entry.isHidden = true
                btnWrong_Entry_Red.isHidden = true
                
            }
            
            else {
               
                   lblStatus.backgroundColor = UIColor.systemRed
                    
                    if activity.activityIn != nil {
                        
                        let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                       // lblintime.text =  strTime + " , " + strDate
                        
                         lblintime.text = "\(strTime) , \(strDate)"

                    }
                    
                    
                    lbldateintime.isHidden = true
                    lblintime.isHidden = false
                    lblouttime.isHidden = true
                    lbladdedby.isHidden = true
                    lblparceltime.isHidden = true
                    lblLeaveatGate.isHidden = true
                    lblcancelby.isHidden = true
                    lblWrongEntry.isHidden = true
                    lbldateintimeMulti.isHidden = true // Extra


                    imgview1.isHidden = true
                    imgview2.isHidden = false
                    imgview3.isHidden = true
                    imgview4.isHidden = true
                    imgview5.isHidden = true
                    imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = true
                    imgviewExtra.isHidden = true

              
                    imgviewTop1.constant = -12
               imgviewTop2.constant = 64.5
               imgviewTop3.constant = -12
                    imgviewTop4.constant = -12
               imgviewTop5.constant = -12
               imgviewTop6.constant = -12
               imgviewTop7.constant = -12
               imgviewTop8.constant = -12
               imgviewTopExtra.constant = -12

                    stackviewStatus.constant = 86.5 // 69.5
                 
                             
                         constraintHightStackBtn.constant = 0
                         
                         constraintHightStacklbl.constant = 0

                         lblHightStacklblMiddle.isHidden = true
                         
                         btnCancel.isHidden = true
                         btnEdit.isHidden = true
                         btnWrong_Entry.isHidden = true
                         btnWrong_Entry_Red.isHidden = true
                         btnRenew.isHidden = true
                         btnClose.isHidden = true
                         btnNote_Guard.isHidden = true
                         btnOut.isHidden = true
                         btnDeliveryInfo.isHidden = true
                         btnAlertInfo.isHidden = true
             
                        btnInviteShare.isHidden = true
                        btnExtraShow.isHidden = false

                         btnIn_OnDemand.isHidden = true
                         btnCancel_OnDemand.isHidden = true
                         btnOut_OnDemand.isHidden = true
                         btnEdit_OnDemand.isHidden = true
                     
                        lblStatus.isHidden = true
                    
                    constraintHightStackBtn.constant = 0
                    
                    constraintHightStacklbl.constant = 0

                    lblHightStacklblMiddle.isHidden = true
                    
                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    btnRenew.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnAlertInfo.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = true
                    
                
            }

            btnInviteShare.isHidden = true
            btnExtraShow.isHidden = false

            btnIn_OnDemand.isHidden = true
            btnCancel_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true
        
        
    }
    
    func setOnDemandEntry(activity:ActivityAll,wrong:UserActivityAll) // OnDemand
    {
         
                btnInviteShare.isHidden = true
                btnExtraShow.isHidden = false

                imgviewCompanyLogo.isHidden = true
                
                 if activity.profilePic == nil || activity.profilePic == "" {
                     imgview.image = UIImage(named: "vendor-1")
                 }else{
                     imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
                 }

                lblname.text = activity.name
                
                if activity.vendorServiceTypeName == nil || activity.vendorServiceTypeName == "" {
                        lblguest.text = ""
                }else{
                    lblguest.text = activity.vendorServiceTypeName
                }

                lblStatus.isHidden = false
                
                lblStatus.text = activity.status
                
               /* if lblStatus.text == "VISITED" || lblStatus.text == "EXPIRED" || lblStatus.text == "ATTENDED"{
                   lblStatus.backgroundColor = AppColor.cancelColor
                }else{
                    lblStatus.backgroundColor = UIColor.systemRed
                } */
   
       if lblStatus.text == "CANCELLED" {
            lblStatus.backgroundColor = AppColor.cancelColor
            
         lbladdedby.text = "Added by " + (activity.addedBy)!

            lblcancelby.text = "Cancelled by " + (activity.cancelledBy)!

            if activity.activityIn != nil {
                
                let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                let strDate = strChangeDateFormate(strDateeee: lblDate!)
                
                let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                let strTime = strChangeTimeFormate(strDateeee: lblTime!)

              //  lbldateintime.text =  strTime + " , " + strDate
             
             lbldateintime.text = "\(strTime) , \(strDate)"
                
                lbldateintime.isHidden = false

            }else{
                lbldateintime.isHidden = true
            }
            
        if wrong.isWrongEntry == 0 {
                                 
            btnWrong_Entry.isHidden = false
            btnWrong_Entry_Red.isHidden = true

            
              lbldateintime.isHidden = false
              lblintime.isHidden = true
              lblouttime.isHidden = true
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = false
              lblWrongEntry.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra


                 imgview1.isHidden = false
                 imgview2.isHidden = true
                 imgview3.isHidden = true
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = false
                  imgview8.isHidden = true
                  imgviewExtra.isHidden = true
                   
              imgviewTop1.constant = 64.5
              imgviewTop2.constant = -12
              imgviewTop3.constant = -12
              imgviewTop4.constant = 81.5
              imgviewTop5.constant = -12
              imgviewTop6.constant = -12
              imgviewTop7.constant = 98.5
              imgviewTop8.constant = -12
              imgviewTopExtra.constant = -12

              stackviewStatus.constant = 120.5
              
              
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true
                                                        
        }else{
                                  
            lblWrongEntry.text = "Wrong Entry Reported by" + (activity.wrongEntryBy)!
          
              btnWrong_Entry.isHidden = true
              btnWrong_Entry_Red.isHidden = false

            
            lbldateintime.isHidden = false
            lblintime.isHidden = true
            lblouttime.isHidden = true
            lbladdedby.isHidden = false
            lblparceltime.isHidden = true
            lblLeaveatGate.isHidden = true
            lblcancelby.isHidden = false
            lblWrongEntry.isHidden = false
              lbldateintimeMulti.isHidden = true // Extra

        
             imgview1.isHidden = false
             imgview2.isHidden = true
             imgview3.isHidden = true
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
              imgview7.isHidden = false
              imgview8.isHidden = false
              imgviewExtra.isHidden = true
               
              imgviewTop1.constant = 64.5
              imgviewTop2.constant = -12
              imgviewTop3.constant = -12
              imgviewTop4.constant = 81.5
              imgviewTop5.constant = -12
              imgviewTop6.constant = -12
              imgviewTop7.constant = 98.5
                imgviewTop8.constant = 115.5
              imgviewTopExtra.constant = -12

              stackviewStatus.constant = 137.5
              
      
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = true
            
            
        }
            
            constraintHightStackBtn.constant = 50
            
            constraintHightStacklbl.constant = 0.5

            lblHightStacklblMiddle.isHidden = true
        
            btnCancel_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true
            btnIn_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            
        }
         else if lblStatus.text == "COMPLETED" {
            lblStatus.backgroundColor = AppColor.cancelColor
            
           if activity.activityIn != nil {
                
                let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                let strDate = strChangeDateFormate(strDateeee: lblDate!)
                
                let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                lblintime.text = "\(strTime) , \(strDate)"

              //  lblintime.text =  strTime + " , " + strDate
                
                lblintime.isHidden = false

            }else{
                lblintime.isHidden = true
            }
            
            if activity.out != nil {
                 
                 let lblDate = activity.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = activity.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

               //  lblouttime.text =  strTime + " , " + strDate
                 
                lblouttime.text = "\(strTime) , \(strDate)"

                 lblouttime.isHidden = false

             }else{
                 lblouttime.isHidden = true
             }
            
            lbladdedby.text = "Pre-Approved by " + (activity.addedBy)!

            
            if wrong.isWrongEntry == 0 {
                                     
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true

                
          lbldateintime.isHidden = true
          lblintime.isHidden = false
          lblouttime.isHidden = false
          lbladdedby.isHidden = false
          lblparceltime.isHidden = true
          lblLeaveatGate.isHidden = true
          lblcancelby.isHidden = true
          lblWrongEntry.isHidden = true
            lbldateintimeMulti.isHidden = true // Extra


             imgview1.isHidden = true
             imgview2.isHidden = false
             imgview3.isHidden = false
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
              imgview7.isHidden = true
              imgview8.isHidden = true
              imgviewExtra.isHidden = true
               
          imgviewTop1.constant = -12
          imgviewTop2.constant = 64.5
          imgviewTop3.constant = 81.5
          imgviewTop4.constant = 98.5
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

          stackviewStatus.constant = 120.5
          
                                                            
            }else{
                                      
                lblWrongEntry.text = "Wrong Entry Reported by" + (activity.wrongEntryBy)!
              
              btnWrong_Entry.isHidden = true
              btnWrong_Entry_Red.isHidden = false

                
                lbldateintime.isHidden = true
                lblintime.isHidden = false
                lblouttime.isHidden = false
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = false
                  lbldateintimeMulti.isHidden = true // Extra


                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = false
                   imgview4.isHidden = false
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = false
                    imgviewExtra.isHidden = true
                     
                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = 81.5
                imgviewTop4.constant = 98.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = 115.5
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 137.5
                
                
            }
            
            btnCancel.isHidden = true
            btnEdit.isHidden = true
            
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = true
            
            btnNote_Guard.isHidden = true
           
            
            constraintHightStackBtn.constant = 50
            
            constraintHightStacklbl.constant = 0.5
            
            lblHightStacklblMiddle.isHidden = true
        
            btnCancel_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true
            btnIn_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            
        
         }
        else if lblStatus.text == "SERVING" {
           lblStatus.backgroundColor = AppColor.pollborderSelect
            
             if activity.activityIn != nil {
                
                let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                let strDate = strChangeDateFormate(strDateeee: lblDate!)
                
                let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                let strTime = strChangeTimeFormate(strDateeee: lblTime!)

               // lblintime.text =  strTime + " , " + strDate
                 
                 lblintime.text = "\(strTime) , \(strDate)"

                lblintime.isHidden = false

            }else{
                lblintime.isHidden = true
            }
            
            lbladdedby.text = "Pre-Approved  by " + (activity.addedBy)!

            
            if wrong.isWrongEntry == 0 {
                                     
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true

                
                  lbldateintime.isHidden = true
                  lblintime.isHidden = false
                  lblouttime.isHidden = true
                  lbladdedby.isHidden = false
                  lblparceltime.isHidden = true
                  lblLeaveatGate.isHidden = true
                  lblcancelby.isHidden = true
                  lblWrongEntry.isHidden = true
                    lbldateintimeMulti.isHidden = true // Extra


             imgview1.isHidden = true
             imgview2.isHidden = false
             imgview3.isHidden = true
             imgview4.isHidden = false
             imgview5.isHidden = true
             imgview6.isHidden = true
              imgview7.isHidden = true
              imgview8.isHidden = true
              imgviewExtra.isHidden = true
               
              imgviewTop1.constant = -12
              imgviewTop2.constant = 64.5
              imgviewTop3.constant = -12
              imgviewTop4.constant = 81.5
              imgviewTop5.constant = -12
              imgviewTop6.constant = -12
              imgviewTop7.constant = -12
              imgviewTop8.constant = -12
              imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5
          
                                                            
            }else{
                                      
                lblWrongEntry.text = "Wrong Entry Reported by" + (activity.wrongEntryBy)!
              
                  btnWrong_Entry.isHidden = true
                  btnWrong_Entry_Red.isHidden = false

                
                lbldateintime.isHidden = true
                lblintime.isHidden = false
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = false
                  lbldateintimeMulti.isHidden = true // Extra


                   imgview1.isHidden = true
                   imgview2.isHidden = false
                   imgview3.isHidden = true
                   imgview4.isHidden = false
                   imgview5.isHidden = true
                   imgview6.isHidden = true
                    imgview7.isHidden = true
                    imgview8.isHidden = false
                    imgviewExtra.isHidden = true
                     
                imgviewTop1.constant = -12
                imgviewTop2.constant = 64.5
                imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = 98.5
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 120.5
                
                
            }
            
            btnCancel.isHidden = true
            btnEdit.isHidden = true
            
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = true
            
            btnNote_Guard.isHidden = true
        
            btnCancel_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true
            btnIn_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = false
            
            constraintHightStackBtn.constant = 50
            
            constraintHightStacklbl.constant = 0.5
            
            lblHightStacklblMiddle.isHidden = false
        }
        else if lblStatus.text == "REQUESTED" {
            lblStatus.backgroundColor = AppColor.pollborderSelect
            
             if activity.activityIn != nil {
                
                let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                let strDate = strChangeDateFormate(strDateeee: lblDate!)
                
                let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                
                let lblTime1 = activity.out?.components(separatedBy: " ")[1]
                let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

               // lbldateintime.text =  strTime + " - " + strTime1 + " , " + strDate
                
                 lbldateintime.text = "\(strTime) - \(strTime1) , \(strDate)"

            }
            
            lbladdedby.text = "Added by " + (activity.addedBy)!

            
              lbldateintime.isHidden = false
              lblintime.isHidden = true
              lblouttime.isHidden = true
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = true
              lblWrongEntry.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra


         imgview1.isHidden = false
         imgview2.isHidden = true
         imgview3.isHidden = true
         imgview4.isHidden = false
         imgview5.isHidden = true
         imgview6.isHidden = true
          imgview7.isHidden = true
          imgview8.isHidden = true
          imgviewExtra.isHidden = true
           
          imgviewTop1.constant = 64.5
          imgviewTop2.constant = -12
          imgviewTop3.constant = -12
          imgviewTop4.constant = 81.5
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = -12
          imgviewTopExtra.constant = -12

            stackviewStatus.constant = 103.5
      
              
            constraintHightStackBtn.constant = 50
            
            constraintHightStacklbl.constant = 0.5
            
            lblHightStacklblMiddle.isHidden = true
            
            btnCancel.isHidden = true
            btnEdit.isHidden = true
            btnWrong_Entry.isHidden = true
            btnWrong_Entry_Red.isHidden = true
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnNote_Guard.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = true
            
            btnCancel_OnDemand.isHidden = false
            btnEdit_OnDemand.isHidden = false
            btnIn_OnDemand.isHidden = false
            btnOut_OnDemand.isHidden = true
            
        }
        else if lblStatus.text == "ADDED" {
           lblStatus.backgroundColor = AppColor.pollborderSelect
                            
         
         if activity.activityIn != nil {
             
             let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
             let strDate = strChangeDateFormate(strDateeee: lblDate!)
             
             let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
             let strTime = strChangeTimeFormate(strDateeee: lblTime!)

            // lblintime.text =  strTime + " , " + strDate
             
             lblintime.text = "\(strTime) , \(strDate)"

         }
            
         lbladdedby.text = "Added by " + (activity.addedBy)!
            
            if wrong.isWrongEntry == 0 {
                                     
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true

                
              lbldateintime.isHidden = true
              lbldateintimeMulti.isHidden = true // Extra
              lblintime.isHidden = false
              lblouttime.isHidden = true
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = true
              lblWrongEntry.isHidden = true

                 // 13/1/20 temp comment

               /*  imgviewHight1.constant = 12
                 imgviewHight2.constant = 0
                 imgviewHight3.constant = 12
                 imgviewHight4.constant = 0
                 imgviewHight5.constant = 0
                 imgviewHight6.constant = 0 */

                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = true
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
                  imgview8.isHidden = true
                  imgviewExtra.isHidden = true
                   
                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = -12
                  imgviewTop4.constant = 81.5
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = -12
                  imgviewTop7.constant = -12
                  imgviewTop8.constant = -12
                  imgviewTopExtra.constant = -12

                  stackviewStatus.constant = 103.5
                  
                  
                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    
                    btnRenew.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true
                                                            
            }else{
                                      
                lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!
              
                  btnWrong_Entry.isHidden = true
                  btnWrong_Entry_Red.isHidden = false

                
              lbldateintime.isHidden = true
              lbldateintimeMulti.isHidden = true // Extra
              lblintime.isHidden = false
              lblouttime.isHidden = true
              lbladdedby.isHidden = false
              lblparceltime.isHidden = true
              lblLeaveatGate.isHidden = true
              lblcancelby.isHidden = true
              lblWrongEntry.isHidden = false

                 // 13/1/20 temp comment

               /*  imgviewHight1.constant = 12
                 imgviewHight2.constant = 0
                 imgviewHight3.constant = 12
                 imgviewHight4.constant = 0
                 imgviewHight5.constant = 0
                 imgviewHight6.constant = 0 */

                 imgview1.isHidden = true
                 imgview2.isHidden = false
                 imgview3.isHidden = true
                 imgview4.isHidden = false
                 imgview5.isHidden = true
                 imgview6.isHidden = true
                  imgview7.isHidden = true
                  imgview8.isHidden = false
                  imgviewExtra.isHidden = true
                   
                  imgviewTop1.constant = -12
                  imgviewTop2.constant = 64.5
                  imgviewTop3.constant = -12
                  imgviewTop4.constant = 81.5
                  imgviewTop5.constant = -12
                  imgviewTop6.constant = -12
                  imgviewTop7.constant = -12
                  imgviewTop8.constant = 98.5
                  imgviewTopExtra.constant = -12

                  stackviewStatus.constant = 120.5
                  
          
                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    
                    btnRenew.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true
                
            }
            
            constraintHightStackBtn.constant = 50
            
            constraintHightStacklbl.constant = 0.5
            
            lblHightStacklblMiddle.isHidden = true
            
                  
            btnCancel_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true
            btnIn_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            
               
        }
        else{
            
            lblStatus.backgroundColor = UIColor.systemRed
             
             if activity.activityIn != nil {
                 
                 let lblDate = activity.activityIn?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = activity.activityIn?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                // lblintime.text =  strTime + " , " + strDate
                 
                 lblintime.text = "\(strTime) , \(strDate)"


             }
             
             
             lbldateintime.isHidden = true
             lblintime.isHidden = false
             lblouttime.isHidden = true
             lbladdedby.isHidden = true
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
             lblWrongEntry.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra


             imgview1.isHidden = true
             imgview2.isHidden = false
             imgview3.isHidden = true
             imgview4.isHidden = true
             imgview5.isHidden = true
             imgview6.isHidden = true
             imgview7.isHidden = true
             imgview8.isHidden = true
             imgviewExtra.isHidden = true

       
             imgviewTop1.constant = -12
        imgviewTop2.constant = 64.5
        imgviewTop3.constant = -12
             imgviewTop4.constant = -12
        imgviewTop5.constant = -12
        imgviewTop6.constant = -12
        imgviewTop7.constant = -12
        imgviewTop8.constant = -12
        imgviewTopExtra.constant = -12

             stackviewStatus.constant = 86.5 // 69.5
          
                      
                  
                  btnCancel.isHidden = true
                  btnEdit.isHidden = true
                  btnWrong_Entry.isHidden = true
                  btnWrong_Entry_Red.isHidden = true
                  btnRenew.isHidden = true
                  btnClose.isHidden = true
                  btnNote_Guard.isHidden = true
                  btnOut.isHidden = true
                  btnDeliveryInfo.isHidden = true
                  btnAlertInfo.isHidden = true
      
                 btnInviteShare.isHidden = true
                 btnExtraShow.isHidden = false

                  btnIn_OnDemand.isHidden = true
                  btnCancel_OnDemand.isHidden = true
                  btnOut_OnDemand.isHidden = true
                  btnEdit_OnDemand.isHidden = true
              
             
             
             constraintHightStackBtn.constant = 0
             
             constraintHightStacklbl.constant = 0

             lblHightStacklblMiddle.isHidden = true
             
             btnCancel.isHidden = true
             btnEdit.isHidden = true
             btnRenew.isHidden = true
             btnClose.isHidden = true
             btnNote_Guard.isHidden = true
             btnOut.isHidden = true
             btnAlertInfo.isHidden = true
             btnDeliveryInfo.isHidden = true
             btnWrong_Entry.isHidden = true
             btnWrong_Entry_Red.isHidden = true
             
         
        }

        
    }
    
    func setEmergencyAlert(activity:ActivityAll,message:UserActivityAll) // EmergencyAlert 
    {
        
            lblname.text = "Emergency"
            
            lblguest.text = "Alert"
          
            imgview.image = UIImage(named: "Group 16679")

            
            imgviewCompanyLogo.isHidden = true
            
            lblStatus.isHidden = false

            
            let lblDate = message.inTime?.components(separatedBy: " ")[0]
            let strDate = strChangeDateFormate(strDateeee: lblDate!)
            
            let lblTime = message.inTime?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

          //  lbldateintime.text =  strTime + " , " + strDate

            lbldateintime.text = "\(strTime) , \(strDate)"

            lblStatus.text = activity.messageStatus
            
           

            lblHightStacklblMiddle.isHidden = true
            
            constraintHightStackBtn.constant = 50
            
            constraintHightStacklbl.constant = 0.5

            lbladdedby.text =  "Alert from " + (activity.messageBy)!
            
             if lblStatus.text == "RESOLVED" {
                lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if lblStatus.text == "SENT" {
                lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if lblStatus.text == "IN PROGRESS" {
                lblStatus.backgroundColor = UIColor.systemRed
             }
             else{
                lblStatus.backgroundColor = UIColor.systemRed
             }
            
            lbldateintime.isHidden = false
            lblintime.isHidden = true
            lblouttime.isHidden = true
            lbladdedby.isHidden = false
            lblparceltime.isHidden = true
            lblLeaveatGate.isHidden = true
            lblcancelby.isHidden = true
            lblWrongEntry.isHidden = true
            lbldateintimeMulti.isHidden = true // Extra


            imgview1.isHidden = false
            imgview2.isHidden = true
            imgview3.isHidden = true
            imgview4.isHidden = false
            imgview5.isHidden = true
            imgview6.isHidden = true
            imgview7.isHidden = true
            imgview8.isHidden = true
            imgviewExtra.isHidden = true

            imgviewTop1.constant = 64.5
            imgviewTop2.constant = -12
            imgviewTop3.constant = -12
            imgviewTop4.constant = 81.5
            imgviewTop5.constant = -12
            imgviewTop6.constant = -12
            imgviewTop7.constant = -12
            imgviewTop8.constant = -12
            imgviewTopExtra.constant = -12

            stackviewStatus.constant = 103.5
                 
            
            btnCancel.isHidden = true
            btnEdit.isHidden = true
            
            btnWrong_Entry.isHidden = true
            btnWrong_Entry_Red.isHidden = true
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnNote_Guard.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = false
            
            btnInviteShare.isHidden = true
            btnExtraShow.isHidden = false

            btnIn_OnDemand.isHidden = true
            btnCancel_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true

    }
    
    func setComplaintToGuard(activity:ActivityAll,message:UserActivityAll) // "ComplainttoGuard"
    {
               
               lblStatus.isHidden = false

               lblname.text = "Complaint"
            
               imgview.image = UIImage(named: "ic_complaint")

               lblguest.text = "Alert"
               
               imgviewCompanyLogo.isHidden = true

              // lblintime.text = arrGuestList[indexPath.row].inTime!
               
               let lblDate = message.inTime?.components(separatedBy: " ")[0]
               let strDate = strChangeDateFormate(strDateeee: lblDate!)
               
               let lblTime = message.inTime?.components(separatedBy: " ")[1]
               let strTime = strChangeTimeFormate(strDateeee: lblTime!)

              // lbldateintime.text =  strTime + " , " + strDate
 
               lbldateintime.text = "\(strTime) , \(strDate)"

               lblStatus.text = activity.messageStatus
               
             
              
               lblHightStacklblMiddle.isHidden = true
               
               constraintHightStackBtn.constant = 50
               
               constraintHightStacklbl.constant = 0.5

               lbladdedby.text =  "Alert from " + (activity.messageBy)!
               
                if lblStatus.text == "RESOLVED" {
                   lblStatus.backgroundColor = AppColor.pollborderSelect
                }else if lblStatus.text == "SENT" {
                   lblStatus.backgroundColor = AppColor.pollborderSelect
                }else if lblStatus.text == "IN PROGRESS" {
                    lblStatus.backgroundColor = UIColor.systemRed
                }else{
                   lblStatus.backgroundColor = UIColor.systemRed
                }
               
            lbldateintime.isHidden = false
            lblintime.isHidden = true
            lblouttime.isHidden = true
            lbladdedby.isHidden = false
            lblparceltime.isHidden = true
            lblLeaveatGate.isHidden = true
            lblcancelby.isHidden = true
            lblWrongEntry.isHidden = true
            lbldateintimeMulti.isHidden = true // Extra


            imgview1.isHidden = false
            imgview2.isHidden = true
            imgview3.isHidden = true
            imgview4.isHidden = false
            imgview5.isHidden = true
            imgview6.isHidden = true
            imgview7.isHidden = true
            imgview8.isHidden = true
            imgviewExtra.isHidden = true

            imgviewTop1.constant = 64.5
            imgviewTop2.constant = -12
            imgviewTop3.constant = -12
            imgviewTop4.constant = 81.5
            imgviewTop5.constant = -12
            imgviewTop6.constant = -12
            imgviewTop7.constant = -12
            imgviewTop8.constant = -12
            imgviewTopExtra.constant = -12

            stackviewStatus.constant = 103.5
                 
            
            btnCancel.isHidden = true
            btnEdit.isHidden = true
            
            btnWrong_Entry.isHidden = true
            btnWrong_Entry_Red.isHidden = true
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnNote_Guard.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = false
            
            btnInviteShare.isHidden = true
            btnExtraShow.isHidden = false

            btnIn_OnDemand.isHidden = true
            btnCancel_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true

        
    }
    
    func setMessageToGuard(activity:ActivityAll,message:UserActivityAll) // "MessagetoGuard"
    {
            
            lblStatus.isHidden = false

            lblname.text = "Message to Guard"
          
            imgview.image = UIImage(named: "ic_message")

            lblguest.text = "Alert"
            
            imgviewCompanyLogo.isHidden = true
            

           // lblintime.text = arrGuestList[indexPath.row].inTime!
            
            let lblDate = message.inTime?.components(separatedBy: " ")[0]
            let strDate = strChangeDateFormate(strDateeee: lblDate!)
            
            let lblTime = message.inTime?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

            // lbldateintime.text =  strTime + " , " + strDate

            lbldateintime.text = "\(strTime) , \(strDate)"

            
            lblStatus.text = activity.messageStatus
            
            lblHightStacklblMiddle.isHidden = false

            constraintHightStackBtn.constant = 50
            
            constraintHightStacklbl.constant = 0.5

            lbladdedby.text =  "Alert from " + (activity.messageBy)!
            
             if lblStatus.text == "RESOLVED" {
                lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if lblStatus.text == "SENT" {
                lblStatus.backgroundColor = AppColor.pollborderSelect
             }else{
                lblStatus.backgroundColor = UIColor.systemRed
             }
            
            if message.isWrongEntry == 0 {
                

                // 13/1/20 temp comment

               /* imgviewHight1.constant = 12

                imgviewHight2.constant = 0
                imgviewHight4.constant = 0
                imgviewHight5.constant = 0
                imgviewHight6.constant = 0
                imgviewHight3.constant = 12 */


                lbldateintime.isHidden = false
                lblintime.isHidden = true
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra


                imgview1.isHidden = false
                imgview2.isHidden = true
                imgview3.isHidden = true
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                imgview7.isHidden = true
                imgview8.isHidden = true
                imgviewExtra.isHidden = true

                imgviewTop1.constant = 64.5
                imgviewTop2.constant = -12
                imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = -12
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 103.5
                     
               

                btnCancel.isHidden = true
                btnEdit.isHidden = true
                
                btnWrong_Entry.isHidden = false
                btnWrong_Entry_Red.isHidden = true

                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = false
                
            }else{
                
                lblWrongEntry.text = "Wrong Entry Reported by " + (activity.wrongEntryBy)!

               
                lbldateintime.isHidden = false
                lblintime.isHidden = true
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = false
                lbldateintimeMulti.isHidden = true // Extra

                
                imgview1.isHidden = false
                imgview2.isHidden = true
                imgview3.isHidden = true
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                imgview7.isHidden = true
                imgview8.isHidden = false
                imgviewExtra.isHidden = true

                imgviewTop1.constant = 64.5
                imgviewTop2.constant = -12
                imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
                imgviewTop5.constant = -12
                imgviewTop6.constant = -12
                imgviewTop7.constant = -12
                imgviewTop8.constant = 98.5
                imgviewTopExtra.constant = -12

                stackviewStatus.constant = 120.5
                
                btnCancel.isHidden = true
                btnEdit.isHidden = true
                btnWrong_Entry.isHidden = true
                
                btnWrong_Entry_Red.isHidden = false
                
                btnRenew.isHidden = true
                btnClose.isHidden = true
                btnNote_Guard.isHidden = true
                btnOut.isHidden = true
                btnDeliveryInfo.isHidden = true
                btnAlertInfo.isHidden = false
            }
            
            btnInviteShare.isHidden = true
            btnExtraShow.isHidden = false

            btnIn_OnDemand.isHidden = true
            btnCancel_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true

        
    }
    
    func setVehicleAdded(activity:ActivityAll,message:UserActivityAll) // "VehicleAdded"
    {

            imgview.image = UIImage(named: "scooter")

             lblStatus.isHidden = true

             if activity.vehicleTypeID != nil {
                 lblname.text = activity.vehicleTypeID
             }else{
                 lblname.text = ""
             }
            
            imgviewCompanyLogo.isHidden = true

             lblguest.text = activity.vehicleNumber

             if activity.addedBy != nil {
                 lbladdedby.text = "Added by " + (activity.addedBy)!
             }
         
                 if activity.creationDate != nil {
                     
                     let lblDate = activity.creationDate?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = activity.creationDate?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    lbldateintime.text = "\(strTime) , \(strDate)"

                     
                 }
                 
           
            lbldateintime.isHidden = false
            lblintime.isHidden = true
            lblouttime.isHidden = true
            lbladdedby.isHidden = false
            lblparceltime.isHidden = true
            lblLeaveatGate.isHidden = true
            lblcancelby.isHidden = true
            lblWrongEntry.isHidden = true
            lbldateintimeMulti.isHidden = true // Extra


            imgview1.isHidden = false
            imgview2.isHidden = true
            imgview3.isHidden = true
            imgview4.isHidden = false
            imgview5.isHidden = true
            imgview6.isHidden = true
            imgview7.isHidden = true
            imgview8.isHidden = true
            imgviewExtra.isHidden = true

      
            imgviewTop1.constant = 64.5
       imgviewTop2.constant = -12
       imgviewTop3.constant = -12
            imgviewTop4.constant = 81.5
       imgviewTop5.constant = -12
       imgviewTop6.constant = -12
       imgviewTop7.constant = -12
       imgviewTop8.constant = -12
       imgviewTopExtra.constant = -12

            stackviewStatus.constant = 95 // 69.5
         
                     
                 constraintHightStackBtn.constant = 0
                 
                 constraintHightStacklbl.constant = 0

                 lblHightStacklblMiddle.isHidden = true
                 
                 btnCancel.isHidden = true
                 btnEdit.isHidden = true
                 btnWrong_Entry.isHidden = true
                 btnWrong_Entry_Red.isHidden = true
                 btnRenew.isHidden = true
                 btnClose.isHidden = true
                 btnNote_Guard.isHidden = true
                 btnOut.isHidden = true
                 btnDeliveryInfo.isHidden = true
                 btnAlertInfo.isHidden = true
     
                btnInviteShare.isHidden = true
                btnExtraShow.isHidden = true

                 btnIn_OnDemand.isHidden = true
                 btnCancel_OnDemand.isHidden = true
                 btnOut_OnDemand.isHidden = true
                 btnEdit_OnDemand.isHidden = true
             
    }
    
    func setAddFamilyMember(activity:ActivityAll,message:UserActivityAll) // setAddFamilyMember
    {
            
                if activity.profilePic == "" || activity.profilePic == nil  {
                    imgview.image = UIImage(named: "vendor-1")
                }else{
                    imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
                }

                 lblStatus.isHidden = true

                 if activity.name != nil {
                     lblname.text = activity.name
                 }else{
                     lblname.text = ""
                 }
                
                imgviewCompanyLogo.isHidden = true

            if activity.relation != nil {
                lblguest.text = activity.relation
            }else{
                lblguest.text = "Family Member"
            }

                 if activity.addedBy != nil {
                     lbladdedby.text = "Added by " + (activity.addedBy)!
                 }else{
                    lbladdedby.text = "Added by "
                 }
             
                     if activity.addedOn != nil {
                         
                         let lblDate = activity.addedOn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = activity.addedOn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        // lbldateintime.text =  strTime + " , " + strDate
                         
                        lbldateintime.text = "\(strTime) , \(strDate)"

                     }
                     
               // 13/1/20 temp comment

                   /* imgviewHight1.constant = 12
                     imgviewHight3.constant = 12
                     imgviewHight2.constant = 12
                     imgviewHight4.constant = 0
                     imgviewHight5.constant = 0
                     imgviewHight6.constant = 0 */
                     
                lbldateintime.isHidden = false
                lblintime.isHidden = true
                lblouttime.isHidden = true
                lbladdedby.isHidden = false
                lblparceltime.isHidden = true
                lblLeaveatGate.isHidden = true
                lblcancelby.isHidden = true
                lblWrongEntry.isHidden = true
                lbldateintimeMulti.isHidden = true // Extra


                imgview1.isHidden = false
                imgview2.isHidden = true
                imgview3.isHidden = true
                imgview4.isHidden = false
                imgview5.isHidden = true
                imgview6.isHidden = true
                imgview7.isHidden = true
                imgview8.isHidden = true
                imgviewExtra.isHidden = true

          
                imgviewTop1.constant = 64.5
           imgviewTop2.constant = -12
           imgviewTop3.constant = -12
                imgviewTop4.constant = 81.5
           imgviewTop5.constant = -12
           imgviewTop6.constant = -12
           imgviewTop7.constant = -12
           imgviewTop8.constant = -12
           imgviewTopExtra.constant = -12

                stackviewStatus.constant = 95 // 69.5
             
                         
                     constraintHightStackBtn.constant = 0
                     
                     constraintHightStacklbl.constant = 0

                     lblHightStacklblMiddle.isHidden = true
                     
                     btnCancel.isHidden = true
                     btnEdit.isHidden = true
                     btnWrong_Entry.isHidden = true
                     btnWrong_Entry_Red.isHidden = true
                     btnRenew.isHidden = true
                     btnClose.isHidden = true
                     btnNote_Guard.isHidden = true
                     btnOut.isHidden = true
                     btnDeliveryInfo.isHidden = true
                     btnAlertInfo.isHidden = true
         
                    btnInviteShare.isHidden = true
                        btnExtraShow.isHidden = true

                     btnIn_OnDemand.isHidden = true
                     btnCancel_OnDemand.isHidden = true
                     btnOut_OnDemand.isHidden = true
                     btnEdit_OnDemand.isHidden = true
                 
    }
    
    func setRemoveFamilyMember(activity:ActivityAll,message:UserActivityAll) // setRemoveFamilyMember
    {
           
               if (activity.profilePic == "" || activity.profilePic == nil ) {
                   imgview.image = UIImage(named: "vendor-1")

               }else{
                   imgview.sd_setImage(with: URL(string: (activity.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
               }

                lblStatus.isHidden = true

                if activity.name != nil {
                    lblname.text = activity.name
                }else{
                    lblname.text = ""
                }
               
               imgviewCompanyLogo.isHidden = true

           if activity.relation != nil {
               lblguest.text = activity.relation
           }else{
               lblguest.text = "Family Member"
           }

                if activity.wrongEntryBy != nil {
                    lblWrongEntry.text = "Removed by " + (activity.wrongEntryBy)!
                }else{
                   lblWrongEntry.text = "Removed by "
                }
            
                    if activity.deletedOn != nil {
                        
                        let lblDate = activity.deletedOn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = activity.deletedOn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                       lbldateintime.text = "\(strTime) , \(strDate)"

                     //   lbldateintime.text =  strTime + " , " + strDate
                        
                    }
                    
              // 13/1/20 temp comment

                  /* imgviewHight1.constant = 12
                    imgviewHight3.constant = 12
                    imgviewHight2.constant = 12
                    imgviewHight4.constant = 0
                    imgviewHight5.constant = 0
                    imgviewHight6.constant = 0 */
                    
               lbldateintime.isHidden = false
               lblintime.isHidden = true
               lblouttime.isHidden = true
               lbladdedby.isHidden = true
               lblparceltime.isHidden = true
               lblLeaveatGate.isHidden = true
               lblcancelby.isHidden = true
               lblWrongEntry.isHidden = false
               lbldateintimeMulti.isHidden = true // Extra


               imgview1.isHidden = false
               imgview2.isHidden = true
               imgview3.isHidden = true
               imgview4.isHidden = true
               imgview5.isHidden = true
               imgview6.isHidden = true
               imgview7.isHidden = true
               imgview8.isHidden = false
               imgviewExtra.isHidden = true

         
           imgviewTop1.constant = 64.5
          imgviewTop2.constant = -12
          imgviewTop3.constant = -12
           imgviewTop4.constant = -12
          imgviewTop5.constant = -12
          imgviewTop6.constant = -12
          imgviewTop7.constant = -12
          imgviewTop8.constant = 81.5
          imgviewTopExtra.constant = -12

               stackviewStatus.constant = 95 // 69.5
            
                        
                    constraintHightStackBtn.constant = 0
                    
                    constraintHightStacklbl.constant = 0

                    lblHightStacklblMiddle.isHidden = true
                    
                    btnCancel.isHidden = true
                    btnEdit.isHidden = true
                    btnWrong_Entry.isHidden = true
                    btnWrong_Entry_Red.isHidden = true
                    btnRenew.isHidden = true
                    btnClose.isHidden = true
                    btnNote_Guard.isHidden = true
                    btnOut.isHidden = true
                    btnDeliveryInfo.isHidden = true
                    btnAlertInfo.isHidden = true
        
                   btnInviteShare.isHidden = true
                   btnExtraShow.isHidden = true

                    btnIn_OnDemand.isHidden = true
                    btnCancel_OnDemand.isHidden = true
                    btnOut_OnDemand.isHidden = true
                    btnEdit_OnDemand.isHidden = true
                
        
    }
    
    func setOtherCard(activity:ActivityAll,message:UserActivityAll) // setOtherCard
    {
            
            if (activity.name == "" || activity.name == nil ) {
                lblname.text = ""
            }else{
                lblname.text = activity.name
            }

            if activity.companyName == "" || activity.companyName == nil {
                 lblguest.text = ""
            }else{
                 lblguest.text = activity.companyName
            }
            
            imgview.image = UIImage(named: "vendor-1")

          // imgview.sd_setImage(with: URL(string: "vendor-1"), placeholderImage: UIImage(named: "vendor-1"))
            
             lbldateintime.isHidden = true
             lblintime.isHidden = true
             lblouttime.isHidden = true
             lbladdedby.isHidden = true
             lblparceltime.isHidden = true
             lblLeaveatGate.isHidden = true
             lblcancelby.isHidden = true
             lblWrongEntry.isHidden = true
             lbldateintimeMulti.isHidden = true // Extra

            lblStatus.isHidden = true

             imgview1.isHidden = true
             imgview2.isHidden = true
             imgview3.isHidden = true
             imgview4.isHidden = true
             imgview5.isHidden = true
             imgview6.isHidden = true
             imgview7.isHidden = true
             imgview8.isHidden = true
             imgviewExtra.isHidden = true
            
            imgviewTop1.constant = -12
            imgviewTop2.constant = -12
            imgviewTop3.constant = -12
            imgviewTop4.constant = -12
            imgviewTop5.constant = -12
            imgviewTop6.constant = -12
            imgviewTop7.constant = -12
            imgviewTop8.constant = -12
            imgviewTopExtra.constant = -12

            stackviewStatus.constant = 69.5
              
            imgviewCompanyLogo.isHidden = true

            constraintHightStackBtn.constant = 0
            
            constraintHightStacklbl.constant = 0

            lblHightStacklblMiddle.isHidden = true
         
            btnCancel.isHidden = true
            btnEdit.isHidden = true
            btnWrong_Entry.isHidden = true
            btnWrong_Entry_Red.isHidden = true
            btnRenew.isHidden = true
            btnClose.isHidden = true
            btnNote_Guard.isHidden = true
            btnOut.isHidden = true
            btnDeliveryInfo.isHidden = true
            btnAlertInfo.isHidden = true

            btnInviteShare.isHidden = true
            btnExtraShow.isHidden = true

            btnIn_OnDemand.isHidden = true
            btnCancel_OnDemand.isHidden = true
            btnOut_OnDemand.isHidden = true
            btnEdit_OnDemand.isHidden = true

        
    }
    
    
}
