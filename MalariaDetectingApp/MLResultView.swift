//
//  MLResultView.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/28/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import UIKit

class MLResultView: UIViewController {
    
    var testResults = TestResults()
    
    @IBOutlet weak var resultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTableView.dataSource = self
        resultTableView.delegate = self
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "MLResultToPatientListSegue", sender: sender)
    }
    
}

extension MLResultView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testResults.imageLst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.item
        let image = testResults.imageLst[index]
        let pResult = testResults.pResults[index]
        let uResult = testResults.uResults[index]
        
        if let cell = resultTableView.dequeueReusableCell(withIdentifier: "resultTableCell", for: indexPath) as? ResultTableViewCell {
            
            cell.resultImageView.image = image
            cell.parasitLabel.text = "Parasitized: \(pResult) %"
            cell.UninfectLabel.text = "Uninfected: \(uResult) %"
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

extension MLResultView: UINavigationControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "MLResultToPatientListSegue" {
                if let dest = segue.destination as? PatientListView {
                    print("testResults \(testResults.resultCount())\n")
                    dest.testResults = testResults
                    dest.wantToSave = true
                }
            }
        }
    }
}
