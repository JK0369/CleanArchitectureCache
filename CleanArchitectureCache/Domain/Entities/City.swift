//
//  City.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

struct City: Equatable, Identifiable {
    typealias Identifer = String

    let id: Identifer
    let name: String
    let subName: String
}
