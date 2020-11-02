//
//  KhaViewController.swift
//  Khadamaaty
//
//  Created by Alisa Nekrasova on 22/12/2016.
//  Copyright © 2016 H2MStudio. All rights reserved.
//

import UIKit

class KhaViewController: UIViewController {
	
	var khaSpinner: KhaSpinner?
	
    func showKhaSpinner(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)) {
		hideKhaSpinner()
		
        khaSpinner = KhaSpinner(frame: frame)
		self.view.addSubview(khaSpinner!)
	}
	
	func showKhaSpinner(title: String) {
		showKhaSpinner()
	}
	
	func hideKhaSpinner() {
		if let khaSpinner = khaSpinner {
			khaSpinner.removeFromSuperview()
		}
		khaSpinner = nil
	}
	
}
