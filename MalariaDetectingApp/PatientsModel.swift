//
//  PatientsModel.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/30/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit

var patientsModel = PatientsModel()

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
    
    mutating func addResults(results: TestResults) {
        imageLst.append(contentsOf: results.imageLst)
        pResults.append(contentsOf: results.pResults)
        uResults.append(contentsOf: results.uResults)
    }
    
    func resultCount()->Int {
        return max(imageLst.count, pResults.count, uResults.count)
    }
}

struct Patient {
    var firstname:String
    var lastname:String
    var age:Int
    var gender:String
    var image:UIImage
    var results:TestResults
    
    init() {
        firstname = ""
        lastname = ""
        age = -1
        gender = ""
        image = UIImage()
        results = TestResults()
    }
    
    init(firstname: String, lastname: String, age:Int, gender:String, image:UIImage, results: TestResults) {
        self.firstname = firstname
        self.lastname = lastname
        self.age = age
        self.gender = gender
        self.image = image
        self.results = results
    }
    
    func resultCount()->Int {
        return results.resultCount()
    }
}

