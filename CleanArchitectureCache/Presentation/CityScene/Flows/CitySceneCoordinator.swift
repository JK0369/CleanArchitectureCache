//
//  CitySceneCoordinator.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation
import UIKit

protocol CitySceneCoordinatorDepoendencies {
    func makeCityViewController() -> UIViewController
}

final class CitySceneCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: CitySceneCoordinatorDepoendencies

    init(navigationController: UINavigationController, dependencies: CitySceneCoordinatorDepoendencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let vc = dependencies.makeCityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
