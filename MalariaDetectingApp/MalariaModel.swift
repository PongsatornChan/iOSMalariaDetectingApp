//
//  MalariaModel.swift
//  MalariaDetectingApp
//
//  Created by Mark Chanpanichravee on 4/28/20.
//  Copyright © 2020 Mark Chanpanichravee. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Vision

class MalariaModel {
    
    var testResults = TestResults()
    var imageLst:[UIImage] = []
    var validResult = false
    
    func setImages(images:[UIImage]) {
        imageLst = images
        validResult = false
        testResults = TestResults()
    }
    
    func addImage(images:[UIImage]) {
        for image in images {
            imageLst.append(image)
        }
        validResult = false
    }

    func removeImage(at index:Int) {
        imageLst.remove(at: index)
        validResult = false
    }

    func removeAll() {
        imageLst.removeAll()
        testResults = TestResults()
        validResult = false
    }
    
    func imagesCount()->Int {
        return imageLst.count
    }

    func imageAt(index: Int)->UIImage {
        return imageLst[index]
    }

    func isValid()->Bool {
        return validResult
    }
    
    // return empty array if imageLst is empty
    func process()->TestResults {
        if (validResult) {
            return testResults
        } else if (imagesCount() > 0) {
            let results = processImages(images: imageLst)
            validResult = true
            testResults.pResults = results[0]
            testResults.uResults = results[1]
            testResults.imageLst = imageLst
            return testResults
        } else {
            return TestResults()
        }
    }
    
    func processImage(image:UIImage)->[Int] {
        var mlResults:[Int] = [0, 0]
        if let model = try? VNCoreMLModel(for: Malaria().model) {
            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    for result in results {
                        //print("\(result.identifier): \(result.confidence * 100)%")
                        if result.identifier == "Parasitized" {
                            let resultRounded = Int((result.confidence * 100.0).rounded())
                            mlResults[0] = resultRounded
                        }
                        if result.identifier == "Uninfected" {
                            let resultRounded = Int((result.confidence * 100.0).rounded())
                            mlResults[1] = resultRounded
                        }
                    }

                }
            }

            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let handler = VNImageRequestHandler(data: imageData, options: [:])
                try? handler.perform([request])
            }
        }
        return mlResults
    }
    
    func processImages(images:[UIImage])->[[Int]] {
        var pResults:[Int] = []
        var uResults:[Int] = []
        for imageI in images {
            let results = processImage(image: imageI)
            pResults.append(results[0])
            uResults.append(results[1])
        }
        return [pResults, uResults]
    }
}
