//
//  MultipleItemSelectionFactory.swift
//  F1reKit
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import Foundation
import RxSwift

public struct MultipleSelectionFactory {
    public static func create<Titem: MultiSelectableItem>(items: [Titem],
                                                          selectedItems: [Titem],
                                                          itemSelectionBlock: @escaping ([Titem]) -> ()) -> UIViewController {
        let presenter = MultiSelectionItemPresenter<Titem>(items: items,
                                                           selectedItems: selectedItems,
                                                           itemSelectionBlock: itemSelectionBlock)
        let viewController = MultipleItemSelectionViewController(style: .grouped,
                                                                 presenter: presenter)
        return viewController
    }
}
