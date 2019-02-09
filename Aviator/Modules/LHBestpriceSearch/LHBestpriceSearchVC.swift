//
//  FirstViewController.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import F1reKit

public class LHBestpriceSearchVC: UIViewController {

    private let disposeBag = DisposeBag()
    @IBOutlet private weak var collectionView: UICollectionView!
    private let presenter: LHBestPriceSearchPresenterProtocol

    // TODO
    private var origins: [String] = [] {
        didSet {
            presenter.getBestPrices(from: self.origins, to: self.destinations)
        }
    }
    private var destinations: [String] = [] {
        didSet {
            presenter.getBestPrices(from: self.origins, to: self.destinations)
        }
    }

    required init(presenter: LHBestPriceSearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "LHBestpriceSearchVC", bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        collectionView.register(UINib(nibName: "LHBestPriceCollectionViewCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: LHBestPriceCollectionViewCell.identifier)
        presenter.viewModelsObserver
        .bind(to: collectionView.rx.items(cellIdentifier: LHBestPriceCollectionViewCell.identifier,
                                         cellType: LHBestPriceCollectionViewCell.self)) {
            (index, model: LHBestPriceResultViewModel, cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)

        collectionView.rx.modelSelected(LHBestPriceResultViewModel.self).subscribe() { event in
            guard let urlString = event.element?.linkURLString,
                let url = URL(string: urlString) else { return }
            let webviewController = WebViewController(nibName: "WebViewController", bundle: nil)
            self.navigationController?.pushViewController(webviewController, animated: true)
            webviewController.configure(with: url)
        }.disposed(by: disposeBag)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Departures Airports", style: .plain, target: self, action: #selector(selectOrigins))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Destination Airports", style: .plain, target: self, action: #selector(selectDestinations))
    }

    @objc private func selectOrigins() {
        let selectionViewController = MultipleSelectionFactory.create(items: ["SFO","SIN"], selectedItems: self.origins) { selectedItems in
            self.origins = selectedItems
        }
        let navigationController = UINavigationController(rootViewController: selectionViewController)
        present(navigationController, animated: true, completion: nil)
    }

    @objc private func selectDestinations() {
        let selectionViewController = MultipleSelectionFactory.create(items: ["MIL","MUC"], selectedItems: self.destinations) { selectedItems in
            self.destinations = selectedItems
        }
        let navigationController = UINavigationController(rootViewController: selectionViewController)
        present(navigationController, animated: true, completion: nil)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func configureLayout() {
        let leftRightContentInset: CGFloat = 16.0
        let itemSpacing: CGFloat = 10.0
        collectionView.contentInset = UIEdgeInsets(top: leftRightContentInset, left: 20, bottom: 20, right: leftRightContentInset)
        collectionView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.itemSize = CGSize(width: collectionView.contentSize.width - leftRightContentInset * 2, height: 85)
    }

}
