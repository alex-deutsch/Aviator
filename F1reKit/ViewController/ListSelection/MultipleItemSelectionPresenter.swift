//
//  MultipleItemSelectionPresenter.swift
//  Aviator
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import Foundation
import RxSwift

public protocol MultiSelectableItem: Comparable {
    var title: String { get }
}

extension String: MultiSelectableItem {
    public var title: String { return self }
}

public protocol MultiSelectionItemPresenterProtocol {
    associatedtype Titem: MultiSelectableItem
    var itemsObservable: Observable<[Titem]> { get }
    var selectedItemsObservable: Observable<[Titem]> { get }
    func didSelect(item: Titem)
    func isItemSelected(item: Titem) -> Bool
    func viewWillDisappear()
}

class MultiSelectionItemPresenter<Titem: MultiSelectableItem>: MultiSelectionItemPresenterProtocol {

    public typealias ItemSelectionBlock = ([Titem]) -> ()

    var itemsObservable: Observable<[Titem]> {
        return items.asObservable()
    }

    var selectedItemsObservable: Observable<[Titem]> {
        return selectedItems.asObservable()
    }

    private let items: Variable<[Titem]> = Variable([])
    private var selectedItems: Variable<[Titem]> = Variable([])
    private let itemSelectionBlock: ItemSelectionBlock

    init(items: [Titem],
         selectedItems: [Titem],
         itemSelectionBlock: @escaping ItemSelectionBlock) {
        self.items.value = items
        self.selectedItems.value = selectedItems
        self.itemSelectionBlock = itemSelectionBlock
    }

    func didSelect(item: Titem) {
        if let index = selectedItems.value.firstIndex(of: item) {
            selectedItems.value.remove(at: index)
            return
        }
        selectedItems.value.append(item)
    }

    func isItemSelected(item: Titem) -> Bool {
        return selectedItems.value.contains(item)
    }

    func viewWillDisappear() {
        itemSelectionBlock(selectedItems.value)
    }
}
