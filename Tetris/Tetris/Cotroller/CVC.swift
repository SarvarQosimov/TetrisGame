//
//  CVC.swift
//  Tetris
//
//  Created by Sarvar Qosimov on 08/04/23.
//

import UIKit

class CVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updataCell(color: UIColor){
        
        backView?.backgroundColor = color
    }

}
