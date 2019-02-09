//
//  MultipleItemSelectionViewController.swift
//  Aviator
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class MultipleItemSelectionViewController<TPresenter: MultiSelectionItemPresenterProtocol>: UITableViewController {

    private let MultipleSelectionCellIdentifier = "Cell"
    private let presenter: TPresenter
    private let disposeBag = DisposeBag()

    init(style: UITableView.Style, presenter: TPresenter) {
        self.presenter = presenter
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureForNavigationController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MultipleSelectionCellIdentifier)
        tableView.dataSource = nil
        tableView.delegate = nil
        presenter.itemsObservable
            .bind(to: tableView.rx.items(cellIdentifier: MultipleSelectionCellIdentifier)) { (index, item, cell) in
                cell.textLabel?.text = item.title
                cell.accessoryType = self.presenter.isItemSelected(item: item) ? .checkmark : .none
            }
            .disposed(by: disposeBag)

        presenter.selectedItemsObservable
            .bind { (_) in
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)

        tableView.rx
            .modelSelected(TPresenter.Titem.self).bind { (item) in
                self.presenter.didSelect(item: item)
            }
            .disposed(by: disposeBag)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }


    private func configureForNavigationController() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
    }

    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
