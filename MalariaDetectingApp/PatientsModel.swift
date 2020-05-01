//
//  PatientsModel.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/30/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit

class PatientsModel {
    var patientLst:[Patient] = []
    
    func addPatient(patient:Patient) {
        patientLst.append(patient)
    }
    
    // return nil if patient with FIRSTNAME and LASTNAME does not exist in the list
    func findPatient(with firstname:String, lastname:String)->Patient? {
        for patient in patientLst {
            if (patient.firstname == firstname && patient.lastname == lastname) {
                return patient
            }
        }
        return nil
    }
    
    // return -1 if patient with given name does not exist in the list
    func findPatientIndex(with firstname:String, lastname:String)->Int {
        for (index, patient) in patientLst.enumerated() {
            if (patient.firstname == firstname && patient.lastname == lastname) {
                return index
            }
        }
        return -1
    }
    
}

struct TestResults {
    var imageLst:[UIImage]
    var pResults:[Int]
    var uResults:[Int]
    
    init() {
        imageLst = []
        pResults = []
        uResults = []
    }
}

struct Patient {
    var firstname:String
    var lastname:String
    var age:Int
    var gender:String
    var image:UIImage
    var results:TestResults
}

