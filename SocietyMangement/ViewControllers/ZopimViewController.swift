//
//  ZopimViewController.swift
//  Khadamaaty
//
//  Created by Alisa Nekrasova on 11/12/2016.
//  Copyright © 2016 H2MStudio. All rights reserved.
//

import UIKit
// 28/11/20 app live process

//import ZDCChat
import SWRevealViewController

class ZopimViewController: KhaViewController {
	
	var firstAppear = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        // 28/11/20 app live process

		/*ZDCChat.updateVisitor { (user) in
            
            user?.name = UsermeResponse?.data!.name ?? ""

            // 22/10/20. temp comment
            user?.phone = UsermeResponse?.data!.phone ?? ""
            
            user?.email = UsermeResponse?.data!.email ?? ""
            
            let userid = UsermeResponse!.data!.guid
            
          //  let strUserId = (userid as NSNumber).stringValue

            // 22/10/20. temp comment
            // only 1 line
          //  user?.addNote(String(format: "Flat No: %@-%@ \nUser_id: %@", UsermeResponse!.data!.PropertyID ?? "" ,UsermeResponse!.data!.Society ?? "",userid))
            
            //
            ////////////
            
		//	let fullName = String(format: "%@ %@", User.me.profile?.firstName ?? "", User.me.profile?.lastName ?? "")
		//	user?.phone = User.me.profile?.mobile ?? ""
		//	user?.name = fullName
		//	user?.email = User.me.profile?.email ?? ""
		}
		ZDCChat.start(in: self.navigationController, withConfig: nil) */
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if firstAppear {
			firstAppear = false
		}
		else {
			let storyboard = self.storyboard ?? UIStoryboard(name: "Main", bundle: nil)
			let vc = storyboard.instantiateViewController(withIdentifier: "Root")
			present(vc, animated: true, completion: nil)
		}
	}
	
}
