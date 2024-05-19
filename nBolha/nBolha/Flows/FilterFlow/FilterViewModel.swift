//
//  FilterViewModel.swift
//  nBolha
//
//  Created by David Balažic on 25. 4. 24.
//

import Foundation
import nBolhaNetworking
import nBolhaUI

class FilterViewModel: ObservableObject {
    @Published var selectedRadioButton: SortBy
    @Published var selectedCheckBoxes: [Condition]
    
    init(
        selectedRadioButton: SortBy = .newest,
        selectedCheckBoxes: [Condition] = []
    ) {
        self.selectedCheckBoxes = selectedCheckBoxes
        self.selectedRadioButton = selectedRadioButton
    }
    
    func resetFilters() {
        selectedRadioButton = .newest
        selectedCheckBoxes = []
    }

    func toggleCondition(_ condition: Condition) {
        if let index = selectedCheckBoxes.firstIndex(of: condition) {
            selectedCheckBoxes.remove(at: index)
        } else {
            selectedCheckBoxes.append(condition)
        }
    }
}
