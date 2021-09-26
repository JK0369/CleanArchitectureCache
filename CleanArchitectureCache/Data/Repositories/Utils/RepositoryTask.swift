//
//  RepositoryTask.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false

    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
