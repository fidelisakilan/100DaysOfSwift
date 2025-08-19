//
//  Bundle-Decoder.swift
//  Moonshot
//
//  Created by Fidelis Akilan on 6/25/25.
//

import Foundation


extension Bundle {
    func decode<T: Codable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        
        //        let decoder = JSONDecoder()
        //        guard let decoded = try? decoder.decode([String:Astronaut].self, from: data) else {
        //            fatalError()
        //        }
        //        return decoded
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(T.self, from: data)
        }
        catch DecodingError.typeMismatch(let type, let context) {
            fatalError("\(type) \(context)")
        }
        catch DecodingError.keyNotFound(let key, let context) {
            fatalError("\(key) \(context)")
        }
        catch DecodingError.dataCorrupted(let context) {
            fatalError("\(context)")
        }
        catch DecodingError.valueNotFound(let value, let context) {
            fatalError("\(value) \(context)")
        }
        catch {
            fatalError()
        }
    }
}
