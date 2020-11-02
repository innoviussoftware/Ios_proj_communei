//
//  KhaSpinner.swift
//  Khadamaaty
//
//  Created by Alisa Nekrasova on 22/12/2016.
//  Copyright © 2016 H2MStudio. All rights reserved.
//

import UIKit
import SwiftHEXColors
class KhaSpinner: UIView {
    
    var ivProgress: UIImageView?
    var progressImgs: [ UIImage ] = [
        #imageLiteral(resourceName: "ic_logo_trasparent"),
        #imageLiteral(resourceName: "ic_logo_trasparent"),
        #imageLiteral(resourceName: "ic_logo_trasparent"),
        #imageLiteral(resourceName: "ic_logo_trasparent"),
        #imageLiteral(resourceName: "ic_logo_trasparent")
    ]
    var timer: Timer?
    var currentImg = 0
    var customFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)) {
        customFrame = frame
        super.init(frame: frame)
        prepareSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareSubView()
    }
    
    func prepareSubView() {
        backgroundColor = UIColor(hex: 0xffffff, alpha: 0.6)
        ivProgress = UIImageView(frame: CGRect(x: (customFrame.width - 107) / 2, y: (customFrame.height - 82) / 2, width: 107, height: 82))
        ivProgress!.image = progressImgs[0]
        addSubview(ivProgress!)
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        self.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1.0
        }) { (_) in
            self.alpha = 1.0
        }
    }
    
    @objc func tick() {
        currentImg = (currentImg + 1) % progressImgs.count
        ivProgress!.image = progressImgs[currentImg]
    }
    
    override func removeFromSuperview() {
        timer?.invalidate()
        
        super.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = customFrame
        self.bounds = customFrame
    }
    
}
