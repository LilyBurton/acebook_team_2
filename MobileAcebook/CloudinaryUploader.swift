//
//  CloudinaryUploader.swift
//  MobileAcebook
//
//  Created by Rachel Wall on 11/10/2023.
//

import Foundation
import Cloudinary
import UIKit

class CloudinaryUploader {
    private let cloudinary: CLDCloudinary
    let apiKey: String
    let apiSecret: String
    let cloudName: String
//    let uploadPreset: String


    init() {
         if let apiKey = ProcessInfo.processInfo.environment["API_KEY"] {
                    self.apiKey = apiKey
         } else {
             fatalError("API Key not found")}
        if let apiSecret = ProcessInfo.processInfo.environment["API_SECRET"] {
                   self.apiSecret = apiSecret
        } else {
            fatalError("API Secret Key not found")}
        if let cloudName = ProcessInfo.processInfo.environment["CLOUD_NAME"] {
                   self.cloudName = cloudName
        } else {
            fatalError("API cloud name not found")}
//        if let uploadPreset = ProcessInfo.processInfo.environment["UPLOAD_PRESET"] {
//                   self.uploadPreset = uploadPreset
//        }
//        else {
//            fatalError("API upload preset not found")}
        let config = CLDConfiguration(cloudName: cloudName, apiKey: apiKey, apiSecret: apiSecret)
        self.cloudinary = CLDCloudinary(configuration: config)
    }

    func upload(image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            completion(nil, NSError(domain: "app", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"]))
            return
        }

        let params = CLDUploadRequestParams()
        cloudinary.createUploader().upload(data: imageData, uploadPreset: "dpbejzbt", params: params).response { (response, error) in
            if let error = error {
                completion(nil, error)
            } else if let publicId = response?.publicId {
                completion(publicId, nil)
            }
        }
    }
}
