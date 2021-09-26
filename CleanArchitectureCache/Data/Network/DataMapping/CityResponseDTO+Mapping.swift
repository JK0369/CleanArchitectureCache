//
//  CityResponseDTO+Mapping.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

struct CityResponseDTO: Decodable {
    let totalResults: Int
    let organizations: [Organization]
    let numPages, curPage, pageOffset, perPage: Int
    let searchQuery, selectedState, selectedNtee, selectedCode: String?
    let dataSource: String
    let apiVersion: Int

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case organizations
        case numPages = "num_pages"
        case curPage = "cur_page"
        case pageOffset = "page_offset"
        case perPage = "per_page"
        case searchQuery = "search_query"
        case selectedState = "selected_state"
        case selectedNtee = "selected_ntee"
        case selectedCode = "selected_code"
        case dataSource = "data_source"
        case apiVersion = "api_version"
    }
}

extension CityResponseDTO {
    struct Organization: Decodable {
        let ein: Int
        let strein, name, subName, city: String
        let state: String
        let nteeCode, rawNteeCode: String?
        let subseccd: Int
        let hasSubseccd: Bool
        let haveFilings, haveExtracts, havePdfs: Bool?
        let score: Int

        enum CodingKeys: String, CodingKey {
            case ein, strein, name
            case subName = "sub_name"
            case city, state
            case nteeCode = "ntee_code"
            case rawNteeCode = "raw_ntee_code"
            case subseccd
            case hasSubseccd = "has_subseccd"
            case haveFilings = "have_filings"
            case haveExtracts = "have_extracts"
            case havePdfs = "have_pdfs"
            case score
        }
    }
}

// Mapping: DTO to Domain

extension CityResponseDTO {
    func toDomain() -> [City] {
        var cities = [City]()

        organizations.forEach {
            let name = $0.name
            let subName = $0.subName
            let city = City(id: name,
                            name: name,
                            subName: subName)
            cities.append(city)
        }

        return cities
    }
}
