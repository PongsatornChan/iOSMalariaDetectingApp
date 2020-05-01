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
    
    var patientsModel = PatientsModel()
    
    @IBOutlet var patientTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let patient = patientsModel.patientLst[index]
        
        
        
    }
}

extension PatientListView: UINavigationControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
    
    

