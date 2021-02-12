//
//  APIService.swift
//  GK
//
//  Created by Oscar on 2021/02/12.
//

import Foundation

class APIService :  NSObject {
    
    private let sourcesURL = URL(string: "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=\(ViewController.tag)&site=stackoverflow&filter=!9_bDDxJY5")!
    
    func apiToGetQuestionsData(completion : @escaping (Questions) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(Questions.self, from: data)
                completion(json)
            } catch let error {
                print("failed to decode: \(error)")
            }
        }.resume()
    }
}
