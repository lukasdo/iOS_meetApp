//
//  APIWrapper.swift
//  LoginForm
//
//  Created by Lukas on 16.04.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import Foundation
import UIKit

protocol APIDelegate {
    func updateUserProfile(users: [UserStruct])
}

class APIWrapper {
    

    var delegate: APIDelegate?
    let baseURL: String
    init(){
//        self.delegate = nil
        self.baseURL = "http://127.0.0.1:5000"
    }
    
    func likeProfile(body: Data){
            
            let endpoint = "/update/like"
    
            var urlRequ = URLRequest(url: URL(string: baseURL+endpoint)!)
            urlRequ.httpMethod = "POST"
            urlRequ.httpBody = body
        urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: urlRequ) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let jsonData = data
                    else {
                        
                        print("ResponseProblem")
                        return
                }
                do{
                    print(jsonData)
//                     let messageData = try JSONDecoder().decode(DetailQuery.self, from: jsonData)
//                    if messageData.ok == true {
//                        DispatchQueue.main.async {
//                            //UPdate UI
//                            self.delegateDetail.showDetailApi(station: messageData.station, append: true)
//                        }
//                    }
                }catch{
                    print(error)
                    print("DecoingProb")
                }
            }
            task.resume()
    }
    func createChat(body: Data){
            
            let endpoint = "/create/chat"
    
            var urlRequ = URLRequest(url: URL(string: baseURL+endpoint)!)
            urlRequ.httpMethod = "POST"
            urlRequ.httpBody = body
        urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: urlRequ) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let jsonData = data
                    else {
                        print(response)
                        print("ResponseProblem")
                        return
                }
                do{
                    print(jsonData)
//                     let messageData = try JSONDecoder().decode(DetailQuery.self, from: jsonData)
//                    if messageData.ok == true {
//                        DispatchQueue.main.async {
//                            //UPdate UI
//                            self.delegateDetail.showDetailApi(station: messageData.station, append: true)
//                        }
//                    }
                }catch{
                    print(error)
                    print("DecoingProb")
                }
            }
            task.resume()
    }
    
    
   
    func getProfiles(){
               
               let endpoint = "/retrieve/users"
       
               var urlRequ = URLRequest(url: URL(string: baseURL+endpoint)!)
               urlRequ.httpMethod = "GET"
           urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
           urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
               
               let task = URLSession.shared.dataTask(with: urlRequ) { data, response, _ in
                   guard let httpResponse = response as? HTTPURLResponse,
                       httpResponse.statusCode == 200,
                       let jsonData = data
                       else {
                           print(response)
                           print("ResponseProblem")
   //                    print(self.httpResponse)
                           return
                   }
                   do{
                       print(jsonData)
                        let messageData = try JSONDecoder().decode([Throwable<UserStruct>].self, from: jsonData)
                           
                           DispatchQueue.main.async {
                               let products = messageData.compactMap { try? $0.result.get() }
                               //UPdate UI
                               self.delegate?.updateUserProfile(users: products)
                       }
                   }catch{
                       print(error)
                       print("DecoingProb")
                   }
               }
               task.resume()
       }
    
    func getMatches(userId: String){
               
               let endpoint = "/retrieve/chats?username="+userId
       
               var urlRequ = URLRequest(url: URL(string: baseURL+endpoint)!)
               urlRequ.httpMethod = "GET"
           urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
           urlRequ.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
               
               let task = URLSession.shared.dataTask(with: urlRequ) { data, response, _ in
                   guard let httpResponse = response as? HTTPURLResponse,
                       httpResponse.statusCode == 200,
                       let jsonData = data
                       else {
                           print(response)
                           print("ResponseProblem")
   //                    print(self.httpResponse)
                           return
                   }
                   do{
                       print(jsonData)
                        let messageData = try JSONDecoder().decode([Throwable<UserStruct>].self, from: jsonData)
                           
                           DispatchQueue.main.async {
                               let products = messageData.compactMap { try? $0.result.get() }
                               //UPdate UI
                               self.delegate?.updateUserProfile(users: products)
                       }
                   }catch{
                       print(error)
                       print("DecoingProb")
                   }
               }
               task.resume()
       }
    
}

// STRUCTS to decode
//// MARK: - Welcome
struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}
// MARK: - Welcome
struct UserStruct: Codable {
    let id: ID
    let userId, image, name: String
    let likes: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "id"
        case image, name, likes
    }
}

// MARK: - ID
struct ID: Codable {
    let oid: String

    enum CodingKeys: String, CodingKey {
        case oid = "$oid"
    }
}
