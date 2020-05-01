//
//  NewPatientVC.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/30/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit

class NewPatientVC: UIViewController, UIImagePickerControllerDelegate,
                    UINavigationControllerDelegate {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var patientsModel:PatientsModel? = nil
    
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .photoLibrary
    }
    
    @IBAction func uploadButtonPressed(_ sender: UIButton) {
        present(imagePickerController, animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let firstname = firstnameTextField.text else {
            firstnameTextField.layer.borderColor = UIColor.red.cgColor
            firstnameTextField.layer.borderWidth = 1.0
            return
        }
        guard let lastname = lastnameTextField.text else {
            lastnameTextField.layer.borderColor = UIColor.red.cgColor
            lastnameTextField.layer.borderWidth = 1.0
            return
        }
        
        let age:Int = Int(ageTextField.text ?? "") ?? -1
        let gender = genderTextField.text ?? "N/A"
        let image = profileImageView.image ?? UIImage()
        
        let newPatient = Patient(firstname: firstname, lastname: lastname, age: age, gender: gender, image: image, results: TestResults())
        
        if (patientsModel != nil) {
            patientsModel?.addPatient(patient: newPatient)
        } else {
            print("patientsModel in NewPatientVC is nil")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}

