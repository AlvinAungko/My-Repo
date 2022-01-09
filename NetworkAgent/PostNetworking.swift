//
//  PostNetworking.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 29/07/2021.
//

import Foundation

//Sample multipart/form-data:
// --Boundary-3A4GHH-0142-4DDE-42356
//   Content-Disposition: form-data;name="name"
//
//   Thet Tun
// --Boundary-3A4GHH-0142-4DDE-42356
//   Content-Disposition: form-data;name="township"
//
//   Yangon
// --Boundary-3A4GHH-0142-4DDE-42356
//   Content-Disposition: form-data;name = "file";filename="somefileName.png"
//   Content-Type:image/png
//
//   a long string of image data
// --Boundary-3A4GHH-0142-4DDE-42356
//
//Boundary
//Content-type
//Blank Line(space)
//value

import UIKit

struct MultiPartFileData
{
    let formFieldName:String
    let fileName:String
    let data:Data
    let mimeType:String
}

class Multipart
{
    static let shared = Multipart()
    
    private init() {}
    
    func buildFormData(urlString:String,params:[String:Any]?,fileData:[MultiPartFileData]?)->(URLRequest,Data?)
    {
        
        //set Boundary
        let boundary = "Boundary-\(UUID().uuidString)"
        
        //configure the request
        var request = URLRequest(url:URL(string: urlString)!)
        request.httpMethod = "POST"
        
        //set Content Type
        let contentType = "multipart/form-data;boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        //create Body
        let httpBody:Data = createBody(withBoundary: boundary, parameters: params, filesData: fileData)
       
        return (request,httpBody)
    }
}

fileprivate func createBody(withBoundary boundary:String,parameters:[String:Any]?,filesData:[MultiPartFileData]?)->Data
{
    let httpBody = NSMutableData()
    
    //add text form field
    if let parameters = parameters
    {
        for(parameterKey,parameterValue) in parameters
        {
            httpBody.append("\(boundary)\r\n")
            httpBody.append("Content-Disposition: form-data; name=\"\(parameterKey)\"\r\n")
            httpBody.append("\r\n")
            httpBody.append("\(parameterValue)\r\n")
//
        }
    }
    if let list = filesData
    {
        list.forEach { item in
            httpBody.append("\(boundary)\r\n")
            httpBody.append("Content-Disposition: form-data; name=\"\(item.formFieldName)")
            httpBody.append("Content-Type: \(item.mimeType)\r\n")
            httpBody.append("\r\n")
            httpBody.append(item.data)
            httpBody.append("\r\n")
            
        }
    }
    
    //close boundary
    httpBody.append("--\(boundary)--")
    
    return httpBody as Data
}

