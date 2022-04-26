//
//  ParseImage.swift
//  ReceiptSplitter(AUT)
//
//  Created by Autumn on 3/18/21.
//

import Foundation
import Vision
import VisionKit
class ParseImageModel:ObservableObject {
    var textRecognitionRequest = VNRecognizeTextRequest()
    var textParsed:[String] = []
    @Published var itemList: [Item] = []
    @Published var parsing = false
    
    init(){
        textRecognitionRequest = VNRecognizeTextRequest()
    }
    

    func processImage(image: UIImage) {
        parsing = true
        guard let cgImage = image.cgImage else {
            print("Failed to get cgimage from input image")
            return
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
        recognizeTextHandler(request: textRecognitionRequest, error:nil)
    }
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        print(recognizedStrings)
        
        // Process the recognized strings.
        self.textParsed = processResults(recognizedStrings)
        parsing = false
    }
    
    func processResults(_ str:[String]) -> [String]{
        var items:[String] = []
        var prices:[String] = []
        var pricesVal:[Float] = []
        var newStr:[String] = str
        var results:[String] = []
        if str.count == 0 {
            return results
        }
        for i in 0...str.count - 1 {
            let toRemove = i - (str.count - newStr.count)
            newStr.remove(at: toRemove)
            let pattern = "Member"
            let regex = try! NSRegularExpression(pattern: pattern)
            let result = regex.matches(in:str[i], range:NSMakeRange(0, str[i].utf16.count))
            if let _ = result.first {
                break
            }
        }
        
        if newStr.count == 0 {
            return results
        }
        
        for i in 0...newStr.count - 1{
            let pattern = "^([0-9]{1,}\\.[0-9]{2})"
            let regex = try! NSRegularExpression(pattern: pattern)
            let result = regex.matches(in:newStr[i], range:NSMakeRange(0, newStr[i].utf16.count))
            if let match = result.first {
                let range = match.range(at:1)
                if let swiftRange = Range(range, in: newStr[i]) {
                    let price = newStr[i][swiftRange]
                    prices.append(String(price))
                    pricesVal.append(Float(price)!)
                    print(price)
                }
            }
            
            let pattern2 = "^[0-9]+\\s([0-9a-zA-Z\\s#]+$)"
            let regex2 = try! NSRegularExpression(pattern: pattern2)
            let result2 = regex2.matches(in:newStr[i], range:NSMakeRange(0, newStr[i].utf16.count))
            if let match = result2.first {
                let range = match.range(at:1)
                if let swiftRange = Range(range, in: newStr[i]) {
                    let item = newStr[i][swiftRange]
                    items.append(String(item))
                    print(item)
                }
            }

        }
        for i in 0...items.count - 1 {
            results.append(makePrettyString(food: items[i], cost: prices[i]))
            itemList.append(Item(name: items[i], price: pricesVal[i]))
        }
        
        return results
    }
    
    func makePrettyString(food:String,cost:String) -> String {
        return String("\(food) $\(cost)")
    }
}
