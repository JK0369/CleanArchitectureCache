//
//  APIEndpoints.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation
//https://projects.propublica.org/nonprofits/api/v2/search.json?order=revenue&sort_order=desc

struct APIEndpoints {

    static func getCities(with cityRequestDTO: CityRequestDTO) -> Endpoint<CityResponseDTO> {
        return Endpoint(path: "nonprofits/api/v2/search.json",
                        method: .get,
                        queryParametersEncodable: cityRequestDTO)
    }
}
