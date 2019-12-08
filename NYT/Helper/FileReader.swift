//
//  FileReader.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 8/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation

class FileReader {

    static func contentsOfFileInBundle(_ fileName:String, type : String = "txt")->Data? {
        if let string = stringFromFileInBundle(fileName, type: type) {
            return string.data(using: .utf8, allowLossyConversion: false)
        }
        return nil
    }
    
    static func stringFromFileInBundle(_ fileName:String, type : String = "txt")->String? {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: type) {
            do {
                return try String(contentsOfFile: filepath)
            } catch {
                return nil
            }
        }
        return nil
    }
}
