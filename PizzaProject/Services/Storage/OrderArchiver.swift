//
//  StorageUserDefaults.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 05.11.2024.
//

import UIKit

final class OrderArchiver {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private let key = "order"

    init(encoder: JSONEncoder, decoder: JSONDecoder) {
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
    
    func addPosition(order: Order) {
        var currentOrder = load()
        
        currentOrder.append(order)
        
        save(order: currentOrder)
    }
    
    func removePosition(index: Int) {
        var currentOrder = load()
        
        currentOrder.remove(at: index)
        
        currentOrder.isEmpty ? save(order: []) : save(order: currentOrder)
    }
    
    func addCountPosition(index: Int) {
        var currentOrder = load()
        
        currentOrder[index].count += 1
        
        save(order: currentOrder)
    }
    
    func removeCountPosition(index: Int) {
        var currentOrder = load()
        
        currentOrder[index].count -= 1
        
        currentOrder[index].count == 0 ? removePosition(index: index) : save(order: currentOrder)
    }
    
    
    
}
