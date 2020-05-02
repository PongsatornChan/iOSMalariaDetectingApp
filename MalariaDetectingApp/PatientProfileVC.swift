//
//  PatientProfileVC.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/30/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit

class PatientProfileVC: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var resultsTableView: UITableView!

    var patientIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let patient = patientsModel.patientLst[patientIndex]
        print("in Profile \(patient.resultCount())\n")
        profileImageView.image = patient.image
        nameLabel.text = "\(patient.firstname) \(patient.lastname)"
        ageLabel.text = "\(patient.age)"
        genderLabel.text = patient.gender
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear ProfileVC.\(patientsModel.patientLst[patientIndex].resultCount())\n")
        reloadInputViews()
        resultsTableView.reloadData()
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "profileToTestSegue", sender: sender)
    }
    
}

extension PatientProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let patient = patientsModel.patientLst[patientIndex]
        print("Patient have \(patient.results.resultCount()) results.\n")
        return patient.results.resultCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.item
        let patient = patientsModel.patientLst[patientIndex]
        let image = patient.results.imageLst[index]
        let pResult = patient.results.pResults[index]
        let uResult = patient.results.uResults[index]
        print("In profile table view \n")
        
        if let cell = resultsTableView.dequeueReusableCell(withIdentifier: "resultTableCell", for: indexPath) as? ResultTableViewCell {
            
            print("In profile make new cell")
            cell.resultImageView.image = image
            cell.parasitLabel.text = "Parasitized: \(pResult) %"
            cell.UninfectLabel.text = "Uninfected: \(uResult) %"
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
