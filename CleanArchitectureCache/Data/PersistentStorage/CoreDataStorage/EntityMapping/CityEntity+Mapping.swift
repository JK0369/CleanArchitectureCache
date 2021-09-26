//
//  CityEntity+Mapping.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/25.
//

import Foundation
import CoreData

extension CityEntity {
    convenience init(city: City, insertInto context: NSManagedObjectContext) {
        self.init(context: context)

        name = city.name
        subName = city.subName
        createdAt = Date()
    }
}

extension CityEntity {
    func toDomain() -> City {
        return .init(id: name ?? "", name: name ?? "", subName: subName ?? "")
    }
}
