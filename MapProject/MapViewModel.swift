//
//  MapViewModel.swift
//  MapProject
//
//  Created by Consultant on 8/2/23.
//

import Foundation
import Combine
import MapKit


class MapViewModel: ObservableObject {
    
    @Published var mapModel:[MapModel] = []
    @Published var geolocation:Geo?
    @Published var customError: NetworkError?
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    var networkManager:NetworkProtocol
    private var cancelable = Set<AnyCancellable>()
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    
    // This is the Combine function
    func getProductsFromAPI() {
        guard let url = URL(string: APICall.MapAPI) else {
                return
            }
            let request = URLRequest(url: url)

        self.networkManager.dataFromAPI(urlRequest: request, type: [MapModel].self)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Task finished")
                    
                    case .failure(let error):
                        print(error.localizedDescription)
                                    switch error{
                                    case is DecodingError:
                                        self.customError = NetworkError.parsingError
                        
                                    case NetworkError.doNotFoundError:
                                        self.customError = NetworkError.doNotFoundError
                        
                                    case NetworkError.inValidError:
                                        self.customError = NetworkError.inValidError
                        
                                    default:
                                        self.customError = NetworkError.doNotFoundError
                                    }
                    }
                }, receiveValue:{ val in
                    self.mapModel = val
    
                    print(self.mapModel)
                    
//                    guard let geoLocation = self.mapModel?.address.geo else {
//                        return
//                        
//                    }
//                    print(geoLocation)
                    
                    
                    
                }).store(in: &cancelable)
                
        }
    
    
    func cancelAPICall(){
        print("Cancelled the request")
        cancelable.first?.cancel()
    }

    
    }



    
