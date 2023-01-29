////
////  Network.swift
////  CountryApp
////
////  Created by Fikrat on 22.11.22.
////
//
//import Foundation
//import Alamofire
//
//
//class Network {
//
//    func putMethod(url: String, method: https, param: [String: Any]? = nil) {
//        let params: Parameters = [
//            "name": "Nicole",
//            "job": "iOS Developer"
//        ]
//
//        AF.request("https://reqres.in/api/users/2", method: .put, parameters: params, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
//            switch response.result {
//                case .success(let data):
//                    do {
//                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                            print("Error: Cannot convert data to JSON object")
//                            return
//                        }
//                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                            print("Error: Cannot convert JSON object to Pretty JSON data")
//                            return
//                        }
//                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                            print("Error: Could print JSON in String")
//                            return
//                        }
//
//                        print(prettyPrintedJson)
//                    } catch {
//                        print("Error: Trying to convert JSON data to string")
//                        return
//                    }
//                case .failure(let error):
//                    print(error)
//            }
//        }
//    }
//
//    }
//    */
//
//}
