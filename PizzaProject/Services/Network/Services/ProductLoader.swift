//
//  ProductLoader.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 08.11.2024.
//


import Foundation

protocol IProductLoader {
    func getProduct() async -> Result<[Pizza], RequestError>
}

class ProductLoader: HTTPClient, IProductLoader {
    
    func getProduct() async -> Result<[Pizza], RequestError> {
        return await sendRequest(endpoint: ProductEndpoint.product, responseModel: [Pizza].self)
    }
    
    func getFilter() async -> Result<[String], RequestError> {
        return await sendRequest(endpoint: ProductEndpoint.filter, responseModel: [String].self)
    }
    
    func getStory() async -> Result<[String], RequestError> {
        return await sendRequest(endpoint: ProductEndpoint.story, responseModel: [String].self)
    }
}
