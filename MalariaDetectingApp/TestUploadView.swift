//
//  File.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/27/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit
import ImagePicker

class TestUploadView: UIViewController, ImagePickerDelegate {
    
    @IBOutlet weak var patientImageView: UIImageView!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var processButton: UIButton!
    
    var malariaModel = MalariaModel()
    var testResults = TestResults()
    
    let imagePickerController = ImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        patientNameLabel.alpha = 0
        patientImageView.alpha = 0
        
        processButton.alpha = 0.5
        processButton.isEnabled = false
        
        print("viewDidLoad finish.")
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("wrapperDidPress happen!")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        malariaModel.setImages(images: images)
        imagesCollectionView.reloadData()
        if (images.count > 0) {
            processButton.alpha = 1
            processButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        malariaModel.removeAll()
        imagesCollectionView.reloadData()
        processButton.alpha = 0.5
        processButton.isEnabled = false
        
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func processButtonPressed(_ sender: UIButton) {
        testResults = malariaModel.process()
        performSegue(withIdentifier: "testToResultSegue", sender: sender)
        
    }
    
    @IBAction func uploadButtonPressed(_ sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension TestUploadView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return malariaModel.imagesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       return CGSize(width: -10 + collectionView.frame.width/2, height: -20 + collectionView.frame.height/2)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let image = malariaModel.imageAt(index: index)

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionCell", for: indexPath) as? ImageCollectionViewCell {
            cell.imageView.image = image
            cell.filenameLabel.text = "\(index)"

            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}

extension TestUploadView: UINavigationControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "testToResultSegue" {
                if let dest = segue.destination as? MLResultView {
                    dest.testResults = testResults
                }
            }
        }
    }
}
