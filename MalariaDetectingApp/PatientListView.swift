//
//  PatientListView.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/30/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit

class PatientListView: UITableViewController {
    
    
    var testResults = TestResults()
    var wantToSave = false
    var patientIndex = 0
    
    @IBOutlet var patientTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        patientTableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addPatientSegue", sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientsModel.patientLst.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.item
        let patient = patientsModel.patientLst[index]
        
        if let cell = patientTableView.dequeueReusableCell(withIdentifier: "petientTableCell", for: indexPath) as? PatientTableViewCell {
            
            cell.patientImageView.image = patient.image
            cell.nameLabel.text = "\(patient.firstname) \(patient.lastname)"
            cell.ageLabel.text = "\(patient.age)"
            cell.genderLabel.text = patient.gender
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.item
        
        if (wantToSave) {
            print("attempt to save: \(testResults.resultCount())\n")
            patientsModel.patientLst[index].results.addResults(results: testResults)
            print("patientsModel: \(patientsModel.patientLst[index].resultCount())\n")
            wantToSave = false
            dismiss(animated: true, completion: nil)
        } else {
            patientIndex = index
            performSegue(withIdentifier: "patientListToPatientProfileSegue", sender: nil)
        }
    }
}

extension PatientListView: UINavigationControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "patientListToPatientProfileSegue" {
                if let dest = segue.destination as? PatientProfileVC {
                    // PatientProfileVC
                    dest.patientIndex = patientIndex
                }
            }
        }
    }
}
    
    

