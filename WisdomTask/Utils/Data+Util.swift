//
//  Data+Util.swift
//  WorkerlyAgent
//
//  Created by Raghava Dokala on 30/03/23.
//

import Foundation

extension Data {

    func write(with folderName:String, and name: String) -> URL {

        let url = URL(fileURLWithPath: createTempDirectory(with: folderName).absoluteString).appendingPathComponent(name)

        try! write(to: url, options: .atomicWrite)

        return url
    }
    func createTempDirectory(with folderName:String) -> URL {
        let tempDirectoryTemplate = URL(fileURLWithPath: NSTemporaryDirectory().appending(folderName))

        let fileManager = FileManager.default
        do{
            try fileManager.createDirectory(at: tempDirectoryTemplate, withIntermediateDirectories: true)
        }catch {
            print("Oops")
        }
        return tempDirectoryTemplate
    }
}
