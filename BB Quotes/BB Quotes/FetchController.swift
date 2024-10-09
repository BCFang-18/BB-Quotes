//
//  FetchController.swift
//  BB Quotes
//
//  Created by Baicheng Fang on 5/1/24.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse  // url means error in our side, resp means error in other side or internet
    }
    
    // htps://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURL = baseURL.appending(path: "quotes/random")
        var quoteComponents = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true)
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
        
        quoteComponents?.queryItems = [quoteQueryItem]
        
        guard let fetchURL = quoteComponents?.url else {
            throw NetworkError.badURL
        }
        
        while true{
            let (data, response) = try await URLSession.shared.data(from: fetchURL)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.badResponse
            }
            
            let quote = try JSONDecoder().decode(Quote.self, from: data)
            
//            if quote.character != "Jim McGill" {
//                throw NetworkError.badResponse // or define a more appropriate error
                return quote
//            }
            
        }
    }
    
//     https://breaking-bar-api-six.vercel.app/api/characters?name=Walter+White
    
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        var characterComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        
        characterComponents?.queryItems = [characterQueryItem]
        
        guard let fetchURL = characterComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
}
