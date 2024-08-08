//
//  NetworkManager.swift
//  MapProject
//
//  Created by Consultant on 8/2/23.
//

import Foundation
import Combine

class NetworkManager:NetworkProtocol{
    // This is the Combine method To be used when using Combine
    func dataFromAPI<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap({ (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.inValidError
                    }
                    return data
                })
                .delay(for: .seconds(3), scheduler: DispatchQueue.main)
                .decode(type: type.self, decoder: JSONDecoder()) // - Parsing
                .eraseToAnyPublisher()
        }
}

