//
//  FileManager.swift
//  ToDoTrainee
//
//  Created by Kostiantyn Kaniuka on 09.12.2022.
//

import Foundation

let fileName = "ToDos.json"

extension FileManager {
    static var docURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    func saveDocument(contents: String, docName: String, completion: (Error?) -> Void) {
        let url = Self.docURL.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            completion(error)
        }
    }
    
    func readDocment(docName: String, completion: (Result<Data, Error>) -> Void) {
        let url = Self.docURL.appendingPathComponent(docName)
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
    
    func docExists(named docName: String) -> Bool {
        fileExists(atPath: Self.docURL.appendingPathComponent(docName).path)
    }
}
