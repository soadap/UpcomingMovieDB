//
//  API.swift
//  Stack Overflow
//
//  Created by Peter Gustafson on 4/9/19.
//  Copyright © 2019 Peter Gustafson. All rights reserved.
//

import Foundation
import UIKit

class API {
    let baseURL: String
    let parameters: String
    
    init(baseURL: String, parameters: String) {
        self.baseURL = baseURL
        self.parameters = parameters
    }
    
    func get(completion: @escaping ([Movie]) -> Void) {
        // construct url object
        let base = URL(string: baseURL)
        guard let url = URL(string: parameters, relativeTo: base) else {
            // log error
            print("Bad url")
            return
        }
        // give that object to URLSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // we now get data back. what do we do?
            guard let unwrappedData = data else {
                print("Cannot unwrap data.")
                return
            }
            let decoder = JSONDecoder()
            do {
                let wrapper = try decoder.decode(Wrapper.self, from: unwrappedData)
                completion(wrapper.movies)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    //fetching image
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
