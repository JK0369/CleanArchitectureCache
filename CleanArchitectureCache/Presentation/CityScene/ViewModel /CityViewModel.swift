//
//  CityViewModel.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol CityViewModelInput {
    func viewDidLoad()
}

protocol CityViewModelOutput {
    var items: BehaviorRelay<[City]> { get }
    var error: BehaviorRelay<String> { get }
}

protocol CityViewModel: CityViewModelInput, CityViewModelOutput {}

final class CityViewModelImpl: CityViewModel {

    private let cityUseCase: CityUseCase

    init(cityUseCase: CityUseCase) {
        self.cityUseCase = cityUseCase
    }

    // Output

    var items: BehaviorRelay<[City]> = .init(value: [])
    var error: BehaviorRelay<String> = .init(value: "")

    // Input

    func viewDidLoad() {
        let _ = cityUseCase.execute(requestValue: .init(order: .revenue, sortOrder: .desc)) { [weak self] result in
            switch result {
            case .success(let cities):
                self?.updateCities(cities)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }

    // Private

    private func updateCities(_ cities: [City]) {
        items.accept(cities)
    }

    private func handle(error: Error) {
        self.error.accept(error.localizedDescription)
    }

}
