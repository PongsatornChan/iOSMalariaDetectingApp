//
//  PatientProfileVC.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/30/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit

class PatientProfileVC: UIViewController,
        UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var testButton: UIButton!
    
    var patientIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let patient = patientsModel.patientLst[patientIndex]
        profileImageView.image = patient.image
        nameLabel.text = "\(patient.firstname) \(patient.lastname)"
        ageLabel.text = (patient.age < 0) ? "" : "Age: \(patient.age)"
        genderLabel.text = (patient.gender == "") ? "" : "Gender: \(patient.gender)"
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        // this function messes the Tab bar controller
        testButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadInputViews()
        profileTableView.reloadData()
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "profileToTestSegue", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let patient = patientsModel.patientLst[patientIndex]
        return patient.results.resultCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.item
        let patient = patientsModel.patientLst[patientIndex]
        let image = patient.results.imageLst[index]
        let pResult = patient.results.pResults[index]
        let uResult = patient.results.uResults[index]
        
        if let cell = profileTableView.dequeueReusableCell(withIdentifier: "profileTableCell", for: indexPath) as? ProfileTableViewCell {
            
            print("In profile make new cell")
            cell.cellImageView.image = image
            cell.parasitLabel.text = "Parasitized: \(pResult) %"
            cell.uninfectLabel.text = "Uninfected: \(uResult) %"
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
