//
//  StorageUserDefaults.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 05.11.2024.
//

import UIKit

final class RecordArchiver {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private let key = "records"
    
    static let shared = RecordArchiver(encoder: JSONEncoder(), decoder: JSONDecoder())
    
    private init(encoder: JSONEncoder, decoder: JSONDecoder) {
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func save(order: [Order]) {
        do {
            let data = try self.encoder.encode(order)
            UserDefaults.standard.set(data, forKey: key)
        }catch {
            print(error)
        }
    }
    
    func load() -> [Order] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Order].self, from: data)
        }catch {
            print(error)
            return []
        }
    }
}
