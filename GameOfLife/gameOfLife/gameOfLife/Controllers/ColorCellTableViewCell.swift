//
//  ColorCellTableViewCell.swift
//  gameOfLife
//
//  Created by Keri Levesque on 7/31/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class ColorCellTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

     //MARK:Outlets
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    //MARK: Properties
    
    let colorViewSize = 64
    let colorViewMargein:CGFloat = 8
      
    var currentColor:UIColor = CellColor.shared.cellColor

    //MARK: View Lifecycle
    
      override func awakeFromNib() {
          super.awakeFromNib()
          self.colorCollectionView.delegate = self
          self.colorCollectionView.dataSource = self
          
          let layout = UICollectionViewFlowLayout()
          layout.itemSize = CGSize(width: colorViewSize, height: colorViewSize)
          layout.sectionInset = UIEdgeInsets(top: CGFloat(colorViewMargein), left: colorViewMargein, bottom: colorViewMargein, right: colorViewMargein)
          layout.scrollDirection = .horizontal
          
          self.colorCollectionView.showsHorizontalScrollIndicator = false
          self.colorCollectionView.setCollectionViewLayout(layout, animated: false)
          self.colorCollectionView.reloadData()
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
      }
      
      // MARK: - Collection view data source
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return CellColor.shared.colors.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell

          cell.colorView.backgroundColor = CellColor.shared.colors[indexPath.item]
          if indexPath.item == CellColor.shared.cellColorIndex {
              cell.contentView.backgroundColor = .systemRed
          }
          else {
              cell.contentView.backgroundColor = .systemBackground
          }
          
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          CellColor.shared.cellColorIndex = indexPath.item
          collectionView.reloadData()
      }
    
}
