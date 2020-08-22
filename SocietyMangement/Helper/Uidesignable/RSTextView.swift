//
//  RSTextView.swift
//  HPProTrain
//
//  Created by Valet2You on 06/10/19.
//  Copyright © 2019 XantaTech. All rights reserved.
//

import UIKit

@IBDesignable
class RSTextViewCustomisation: UITextView {
  
  // MARK:- Layout -
  override public func layoutSubviews() {
    
    super.layoutSubviews()
  }
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = false
    }
  }
  
  @IBInspectable var isCircle: Bool = false {
    
    didSet {
      layer.masksToBounds = cornerRadius > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    
    didSet {
      layer.borderColor = borderColor?.cgColor
    }
  }
}
