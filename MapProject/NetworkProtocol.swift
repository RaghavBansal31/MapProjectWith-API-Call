//
//  NetworkProtocol.swift
//  MapProject
//
//  Created by Consultant on 8/2/23.
//

import Foundation
import Combine
protocol NetworkProtocol{
    func dataFromAPI<T: Decodable>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable
}
