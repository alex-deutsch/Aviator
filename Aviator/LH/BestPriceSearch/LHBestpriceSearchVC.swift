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

class LHBestpriceSearchVC: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!

    private var presenter: LHBestPriceSearchPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LHBestPriceSearchPresenter(interactor: LHBestPriceSearchInteractor())
        configureLayout()

        collectionView.register(UINib(nibName: "LHBestPriceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LHBestPriceCollectionViewCell.identifier)
        presenter.viewModelsObserver
        .bind(to: collectionView.rx.items(cellIdentifier: LHBestPriceCollectionViewCell.identifier,
                                         cellType: LHBestPriceCollectionViewCell.self)) {
            (index, model: LHBestPriceResultViewModel, cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)

        presenter.getBestPrices(from: ["MUC", "ROM", "MIL"], to: ["SFO", "SIN", "DPS", "MEL"])
        collectionView.rx.modelSelected(LHBestPriceResultViewModel.self).subscribe() { event in
            guard let urlString = event.element?.linkURLString,
                let url = URL(string: urlString) else { return }
            let webviewController = WebViewController(nibName: "WebViewController", bundle: nil)
            self.navigationController?.pushViewController(webviewController, animated: true)
            webviewController.load(url: url)
        }.disposed(by: disposeBag)
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
