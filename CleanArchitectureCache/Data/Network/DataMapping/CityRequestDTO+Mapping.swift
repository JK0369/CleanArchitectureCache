//
//  CityRequestDTO+Mapping.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

struct CityRequestDTO: Encodable {
    let order: Order
    let sortOrder: SortOrder

    enum CodingKeys: String, CodingKey {
        case order
        case sortOrder = "sort_order"
    }
}
