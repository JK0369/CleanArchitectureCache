//
//  CityViewController.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation
import UIKit
import RxSwift

class CityViewController: UITableViewController {

    static func create(with viewModel: CityViewModel) -> CityViewController {
        let viewController = CityViewController(viewModel: viewModel)

        return viewController
    }

    private let disposeBag = DisposeBag()
    private var viewModel: CityViewModel!

    init(viewModel: CityViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
        setupViews()
        bindOutput()
    }

    private func setupViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func bindOutput() {
        viewModel.items.subscribe(onNext: { [weak self] _ in self?.updateItems() }).disposed(by: disposeBag)
    }

    private func updateItems() {
        tableView.reloadData()
    }

    // Delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.items.value[indexPath.row].name
        cell.detailTextLabel?.text = viewModel.items.value[indexPath.row].subName

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
