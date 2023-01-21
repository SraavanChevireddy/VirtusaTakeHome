//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 20/01/23.
//

import Foundation
import Combine

enum ApplicationEnvironment:String{
    case developmentEnvironment = "https://jmde6xvjr4.execute-api.us-east-1.amazonaws.com/"
}

enum NetworkControllers: String {
    case teams = "teams"
    case matches = "teams/matches"
    case mockTeams = "MockTeams"
    case mockMatches = "MockMatches"
}

class NetworkLayer {
    
    static let standard = NetworkLayer()
    func requestURL(to: requestType = .get, controller: NetworkControllers) -> URLRequest? {
        if let url = URL(string: ApplicationEnvironment.developmentEnvironment.rawValue.appending(controller.rawValue)) {
            return URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        } else {
            return nil
        }
    }
    
    func getInformationFromDatabase<T:Decodable>(for request:  NetworkControllers, and decode: T.Type) throws -> AnyPublisher<T, some Error> {
        guard let requestURL = requestURL(controller: request) else {
            throw URLError(.cannotFindHost)
        }

        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .tryMap() { element -> Data in
                return element.data
            }.decode(type: T.self, decoder: JSONDecoder())
            .subscribe(on: DispatchQueue(label: "backgroundThread", qos: .background))
            .mapError({$0})
            .map({$0})
            .eraseToAnyPublisher()
    }
    
//    func getMockInformationFromBundle<T:Decodable>(for request: NetworkControllers, and decode: T.Type) -> AnyPublisher<T, Never> {
//        guard let info = Bundle.main.url(forResource: request.rawValue, withExtension: "json") else {
//            fatalError("No Such")
//        }
//        do {
//            let decoder = try Data(contentsOf: info)
//        } catch {
//            fatalError("Unable to decode")
//        }
//
//    }
}

