//
//  JsonHandling.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 20/02/2023.
//

import Foundation

class JsonHandling<T> where T : Decodable{
    
    func Encoder(_ forResource:String)->T? {
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            var url = URL(fileURLWithPath: path)
            
            url = url.appendingPathComponent(forResource + ".json")
                let jsonData = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let persons = try jsonDecoder.decode(T.self, from: jsonData)
                
                return persons
            
        }catch let error{
            print(error)
        }
        
        return nil
    }
    
    func Decoder(_ forResource:String,_ resource:Codable){
        
        guard let encoded = try? JSONEncoder().encode(resource) else{
            return
        }
        
        if let jsonString = String(data: encoded, encoding: .utf8) {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
                
            if let pathComponent = url.appendingPathComponent(forResource + ".json") {
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                fileManager.createFile(atPath: filePath, contents: Data(jsonString.utf8), attributes: nil)
            }
        }
    }
}
