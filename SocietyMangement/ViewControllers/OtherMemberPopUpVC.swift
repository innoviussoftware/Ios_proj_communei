//
//  OtherMemberPopUpVC.swift
//  SocietyMangement
//
//  Created by Innovius on 19/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class OtherMemberPopUpVC: UIViewController {
    
    @IBOutlet weak var constraintEmailHight: NSLayoutConstraint!
    @IBOutlet weak var constraintContactHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintFlatTypeHeight: NSLayoutConstraint!
    
    
    
    
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var viewUserProfile: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgMember: UIImageView!
    
    @IBOutlet weak var lblFlatType: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!
    
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var lblProfession: UILabel!
    
    @IBOutlet weak var lblBloodGrpValue: UILabel!
    @IBOutlet weak var lblFlatNo: UILabel!
    @IBOutlet weak var lblFlatStatic: UILabel!
    @IBOutlet weak var lblBloodGroup: UILabel!
    @IBOutlet weak var lblProfessionDetail: UILabel!
    
    @IBOutlet weak var btnCall: UIButton!
    
    var member : Members?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        
        self.navigationController?.navigationBar.isHidden = true
        
        bgView.layer.cornerRadius = 12
        bgView.clipsToBounds = true
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        lblName.text = member?.name
        if member?.email != nil{
            lblEmailId.text = member?.email
        }else{
            lblEmailId.isHidden = true
        }
        
        
        if member?.memberStatus == 1{
            lblMobileNumber.text = member?.phone
            lblFlatType.text = member?.role
        }else{
            lblMobileNumber.isHidden = true
            btnCall.isHidden = true
            lblFlatType.text = member?.role
            
        }
        

        lblFlatNo.text = "\(member!.society?.parentProperty! ?? "")-\(member!.society?.property! ?? "")"
        lblBloodGrpValue.text = member?.bloodGroupName
        if(member?.profilePhotoPath != nil)
        {
            imgMember.layer.cornerRadius = imgMember.frame.size.height/2
            imgMember.clipsToBounds = true
            imgMember.sd_setImage(with: URL(string: (member?.profilePhotoPath)!), placeholderImage: UIImage(named: "vendor-1"))
        }
        
        if member?.professionName != nil {
            lblProfession.text = member?.professionName
        }else{
            lblProfession.text = ""
        }
        
        if member?.professionDetails != nil {
            lblProfessionDetail.text = String(format: "Profession Details: %@", (member?.professionDetails)!)
        }else{
            lblProfessionDetail.text = String(format: "Profession Details: %@", "")
        }
        
        
        viewUserProfile.layer.cornerRadius = viewUserProfile.frame.size.height/2
        viewUserProfile.clipsToBounds = true
        viewUserProfile.layer.borderWidth = 1
        viewUserProfile.layer.borderColor = UIColor.orange.cgColor
        
    }
    
    
    //MARK:- action method
    @IBAction func actionCall(_ sender: Any) {
    }
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
