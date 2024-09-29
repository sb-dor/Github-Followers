//
//  UIHelper.swift
//  testapp
//
//  Created by Avaz on 29/09/24.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnLayout(view: UIView, padding: CGFloat) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.minimumInteritemSpacing = 10 // Spacing between items in a row
        flowLayout.minimumLineSpacing = 10 // Spacing between rows
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: padding)
        return flowLayout
    }
    
}
