//
//  Connections.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import Foundation

struct Connections: Decodable {
    
    var connections: [Connection]
    
    enum CodingKeys: String, CodingKey {
        case connections
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        connections = try container.decodeIfPresent([Connection].self, forKey: .connections) ?? [Connection]()
    }
}

struct Connection: Decodable, Identifiable {

    var id: String
    var from: String
    var to: String
    var coordinates: Coordinates?
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case id, from, to, coordinates, price
    }
    
    init(id: String = UUID().uuidString, from: String = "", to: String = "", coorinates: Coordinates? = nil, price: Double = 0.0) {
        self.id = id
        self.from = from
        self.to = to
        self.coordinates = coorinates
        self.price = price
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        from = try container.decodeIfPresent(String.self, forKey: .from) ?? ""
        to = try container.decodeIfPresent(String.self, forKey: .to) ?? ""
        coordinates = try container.decodeIfPresent(Coordinates.self, forKey: .coordinates) ?? Coordinates()
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
    }
}

struct Coordinates: Decodable {
    
    var from: LatLong
    var to: LatLong
    
    init(from: LatLong = LatLong(), to: LatLong = LatLong()) {
        self.from = from
        self.to = to
    }
    
    enum CodingKeys: String, CodingKey {
        case from, to
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decodeIfPresent(LatLong.self, forKey: .from) ?? LatLong()
        to = try container.decodeIfPresent(LatLong.self, forKey: .to) ?? LatLong()
    }
}

struct LatLong: Decodable {
    
    var lat: Double
    var long: Double
    
    init(lat: Double = 0.0, long: Double = 0.0) {
        self.lat = lat
        self.long = long
    }
    
    enum CodingKeys: String, CodingKey {
        case lat, long
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
        long = try container.decodeIfPresent(Double.self, forKey: .long) ?? 0.0
    }
}
