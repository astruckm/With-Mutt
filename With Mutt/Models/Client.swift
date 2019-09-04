//
//  Client.swift
//  With Mutt
//
//  Created by ASM on 7/12/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import Foundation

//Yelp's API: need to get business ID first before getting its reviews

class Client {
    let apiKey = ""
    
    func buildURLRequest(forEndpoint endpoint: String, withQueries queries: [URLQueryItem]) -> URLRequest? {
        var components = URLComponents()
        components.scheme = StringLiterals.urlScheme
        components.host = StringLiterals.urlHost
        components.path = endpoint
        components.queryItems = queries
        
        if let url = components.url {
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: StringLiterals.authorization)
            return request
        }
        return nil
    }
    
    func businessSearch(atLocation location: String/*, completion: @escaping*/) {
        let queries = [URLQueryItem(name: StringLiterals.location, value: location)]
        let urlRequest = buildURLRequest(forEndpoint: StringLiterals.businessSearchEndpoint, withQueries: queries)
        
        if let request = urlRequest {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                //
            }.resume()

        }
    }
    
    func parseBusinessSearchResults() {
        
    }
}

extension Client {
    struct StringLiterals {
        //HTTP Headers
        static let authorization = "Authorization"
        
        //URL Constructors
        static let urlScheme = "https"
        static let urlHost = "api.yelp.com/v3"
        static let businessSearchEndpoint = "/business/search"
        
        //Queries
        static let searchTerm = "term"
        static let location = "location" //required if either latitude and longitude not specified
        static let latitude = "latitude" //required along with longitude if location not specified
        static let longitude = "longitude"
        static let suggestedSearchRadiusInMeters = "radius"
        static let businessCategories = "categories"
        static let languageCountry = "locale"
        static let numResults = "limit"
        static let offset = "offset"
        static let sortBy = "sort_by"
        static let priceLevel = "price"
        static let openNow = "open_now" //can't be used with openAt
        static let openAt = "open_at"
        static let otherAttributes = "attributes"
    }
}
