//
//  CityUDS+Mapping.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/25.
//

import Foundation

// UDS: UserDefaultsStorage
struct CityListUDS: Codable {
    var list: [CityUDS]
}

struct CityUDS: Codable {
    let name: String
    let subName: String

    init(city: City) {
        name = city.name
        subName = city.subName
    }
}

extension CityUDS {
    func toDomain() -> City {
        return .init(id: name, name: name, subName: subName)
    }
}
