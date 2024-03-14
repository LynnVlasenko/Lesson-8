//
//  ContainerModels.swift
//  Lesson8
//
//  Created by Алина Власенко on 14.03.2024.
//

import Foundation

struct APIStringRespone {
    
    var stringItems: [String] = []
    
    var date: Date = Date()
    
    // функція
    mutating func update(with items: [String]) {
        stringItems = items
    }
}

struct APIIntRespone {
    
    var intItems: [Int] = []
    
    var date: Date = Date()
    
    // функція
    mutating func update(with items: [Int]) {
        intItems = items
    }
}

struct APIUniversalResponse<Element> {  // або часто пишуть <T>
    var items: [Element] = []
    
    var date: Date = Date()
    
    // функція
    mutating func update(with newItems: [Element]) {
        items = newItems
    }
}


protocol APIResponse {
    associatedtype Item
    
    mutating func setup(with newItems: [Item])

}

struct APIDoubleResponse: APIResponse {
    
    var someDoubleValues: [Double] = []
    
    typealias Item = Double
    
    mutating func setup(with newItems: [Double]) {
        self.someDoubleValues = newItems
    }
    
   
    
    
    
}
