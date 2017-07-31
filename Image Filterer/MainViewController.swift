//
//  ViewController.swift
//  Image Filterer
//
//  Created by Nguyen Bui An Trung on 31/7/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UINavigationControllerDelegate {
	static let CELL_IDENTIFIER = "AffectCell"
	@IBOutlet weak var thumbnailImageView: UIImageView!
	@IBOutlet weak var affectsCV: UICollectionView!
	var viewModel = MainViewModel()
	var selectedImage: UIImage?
	var appliedImage: UIImage?
	override func viewDidLoad() {
		super.viewDidLoad()
		affectsCV.delegate = self
		affectsCV.dataSource = self
		viewModel.appliedAffectCallback = appliedFilterCallback(image:)
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func imageTouchedDown(){
		guard appliedImage != nil, selectedImage != nil else {
			return
		}

		self.thumbnailImageView.image = selectedImage
		
	}
	
	@IBAction func imageTouchedCancel(){
		guard appliedImage != nil, selectedImage != nil else {
			return
		}
	
		self.thumbnailImageView.image = appliedImage
		
	}
	
	
	
	
	@IBAction func selectPhoto(){
		let picker = UIImagePickerController()
		picker.sourceType = .photoLibrary
		picker.allowsEditing = false
		picker.delegate = self
		self.present(picker, animated: true, completion: nil)

	}
	
	
	func appliedFilterCallback(image: UIImage){
		appliedImage = image
		thumbnailImageView.image = image
		
	}
	


}

extension MainViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			thumbnailImageView.image = image
			thumbnailImageView.contentMode = .scaleAspectFit
			selectedImage = image
			affectsCV.reloadData()
			
			
		}
		picker.dismiss(animated: true, completion: nil)
		
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	@available(iOS 6.0, *)
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewController.CELL_IDENTIFIER, for: indexPath) as? AffectCell
		
		cell?.lblName.text = viewModel.affectsList[indexPath.row].name
		cell?.imageView.image = selectedImage
		return cell!
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let pos = indexPath.row
		let affectName = viewModel.affectsList[pos].code
		if let image = self.selectedImage {
			viewModel.applyAffectForImage(image, affectName: affectName)
		}
		
		
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1;
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.affectsList.count
	}
	
}

