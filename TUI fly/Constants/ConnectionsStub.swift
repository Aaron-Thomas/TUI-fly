//
//  ConnectionsStub.swift
//  TUI fly
//
//  Created by Aaron Taylor on 12/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import Foundation

protocol ConnectionsStub {
    
    func getConnectionsStub(completion: @escaping (Result<Connections, Error>) -> Void)
}

extension ConnectionsStub {
    
    func getConnectionsStub(completion: @escaping (Result<Connections, Error>) -> Void) {
    
        guard let fileUrl = Bundle.main.url(forResource: "connections", withExtension: "json") else {
            completion(.failure(NSError(domain: "Error creating file url", code: -1, userInfo: nil)))
            return
        }
        
        guard let data = try? Data(contentsOf: fileUrl) else {
            completion(.failure(NSError(domain: "Error retrieving data from file", code: -1, userInfo: nil)))
            return
        }
        
        do {
            let connections = try JSONDecoder().decode(Connections.self, from: data)
            completion(.success(connections))
        } catch {
            completion(.failure(error))
        }
    }
}
