
//
//  MainModelView.swift
//  Image Filterer
//
//  Created by Nguyen Bui An Trung on 31/7/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import Foundation
import UIKit
import AssetsLibrary


class MainViewModel {
	var affectsList: [FilterAffect] = []
	var appliedAffectCallback: ((UIImage) -> Void)?
	init() {
		self.initData()
	}
	
	func initData(){
		affectsList.append(FilterAffect(name: "CISepiaTone", code: "CISepiaTone"))
		affectsList.append(FilterAffect(name: "CIGaussianBlur", code: "CIGaussianBlur"))
		affectsList.append(FilterAffect(name: "CICMYKHalftone", code: "CICMYKHalftone"))
		affectsList.append(FilterAffect(name: "CICrystallize", code: "CICrystallize"))
		affectsList.append(FilterAffect(name: "CIBoxBlur", code: "CIBoxBlur"))
		affectsList.append(FilterAffect(name: "CIDiscBlur", code: "CIDiscBlur"))
		
		affectsList.append(FilterAffect(name: "CINoiseReduction", code: "CINoiseReduction"))
		//affectsList.append(FilterAffect(name: "CIZoomBlur", code: "CIZoomBlur"))
	}
	
	
	func applyAffectForImage(_ image: UIImage, affectName: String) {
		
		let beforeImage = CIImage(image: image)

		let filter = CIFilter(name: affectName)
		filter?.setValue(beforeImage, forKey: kCIInputImageKey)
		//filter?.setValue(0.5, forKey: kCIInputIntensityKey)

		let output = filter?.outputImage
		let newImage = UIImage(ciImage: output!)
		appliedAffectCallback!(newImage)
	}
	
	
	func saveImage(_ image: UIImage) {
		// IMplement this
	}
}
