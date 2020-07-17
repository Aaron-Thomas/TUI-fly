//
//  Networking.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import Foundation

protocol Networking {}

extension Networking {
    
   func networkRequest<T: Decodable>(returnType: T.Type, urlString: String, parameters: [String: Any]? = nil, headers: [String: String] = [:], httpMethod: String = "GET", decodedData: Decodable? = nil, urlSession: URLSession = URLSession(configuration: .default), completion: @escaping (Result<T, Error>) -> Void) {
    
        performRequest(url: urlString, parameters: parameters, httpMethod: httpMethod, headers: headers) { result in
            switch result {
            case .success(let data):
                                            
                self.parseData(returnType: returnType, data: data) { result in
                    switch result {
                    case .success(let decodedData):
                        completion(.success(decodedData))
                    case .failure(let error):
                        completion(.failure(NSError.createError(withMessage: error.localizedDescription)))
                        return
                    }
                }
                
            case .failure(let error):
                completion(.failure(NSError.createError(withMessage: error.localizedDescription)))
                return
            }
        }
    }
    
    func performRequest(url: String, parameters: [String: Any]? = nil, httpMethod: String = "GET", headers: [String: String] = [:], completion: @escaping (Result<Data, Error>) -> Void) {
                
        guard let url = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            completion(.failure(NSError.createError(withMessage: "URL Error")))
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: 30)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let params = parameters {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params as Any, options: .prettyPrinted) else {
                completion(.failure(NSError.createError(withMessage: "JSON Serialisation Fail")))
                return
            }
            request.httpBody = httpBody
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(error ?? NSError.createError(withMessage: "No data")))
                return
            }
            
            completion(.success(data))

        }.resume()
    }
    
    func parseData<T: Decodable>(returnType: T.Type, data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch let decodingError {
            completion(.failure(decodingError))
        }
    }
}
