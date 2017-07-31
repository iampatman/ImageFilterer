//
//  AffectCell.swift
//  Image Filterer
//
//  Created by Nguyen Bui An Trung on 31/7/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class AffectCell: UICollectionViewCell {
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	override func awakeFromNib() {
		imageView.contentMode = .scaleAspectFit
	}
}
