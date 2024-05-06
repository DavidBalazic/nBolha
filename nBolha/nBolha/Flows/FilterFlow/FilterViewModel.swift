//
//  FilterViewModel.swift
//  nBolha
//
//  Created by David Balažic on 25. 4. 24.
//

import Foundation

protocol FilterNavigationDelegate: AnyObject {
 
}

final class FilterViewModel: ObservableObject {
    private let navigationDelegate: FilterNavigationDelegate?
    @Published var selectedRadioButton: FilterView.SortBy = FilterView.SortBy.newest
    @Published var selectedCheckBoxes: [FilterView.Condition] = []
    
    init(
        navigationDelegate: FilterNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
    
    func setSelectedOptions(selectedCheckBoxes: [FilterView.Condition], selectedRadioButton: FilterView.SortBy) {
        self.selectedCheckBoxes = selectedCheckBoxes
        self.selectedRadioButton = selectedRadioButton
    }
}
