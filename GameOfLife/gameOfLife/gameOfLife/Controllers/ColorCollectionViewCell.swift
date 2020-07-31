//
//  ColorCollectionViewCell.swift
//  gameOfLife
//
//  Created by Keri Levesque on 7/31/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var colorView: UIView!
    
    //draw the circles 
    override func draw(_ rect: CGRect) {
          super.draw(rect)
          self.colorView.layer.cornerRadius = self.colorView.frame.size.width / 2
          self.colorView.clipsToBounds = true
          self.colorView.layer.masksToBounds = false
          
          self.frameView.layer.cornerRadius = self.frameView.frame.size.width / 2
          self.frameView.clipsToBounds = true
          self.frameView.layer.masksToBounds = false
          self.frameView.backgroundColor = UIColor.systemBackground

          self.contentView.layer.cornerRadius = self.frame.size.width / 2
          self.contentView.clipsToBounds = true
          self.contentView.layer.masksToBounds = false
          
      }
      
}
