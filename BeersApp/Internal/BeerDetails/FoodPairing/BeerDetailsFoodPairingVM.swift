//
//  BeerDetailsFoodPairingViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 22.03.2021.
//

import Foundation
import RxSwift
import RxCocoa


protocol BeerDetailsFoodPairingViewModelType {
    var foodPairings: Driver<[String]> {get}

    func bindViewEvents(chipTapped: Driver<Int>)
}

final class BeerDetailsFoodPairingViewModel: BeerDetailsFoodPairingViewModelType {
    let foodPairings: Driver<[String]>

    private let disposeBag = DisposeBag()
    
    init(foodPairings: Driver<[String]>) {
        self.foodPairings = foodPairings
    }
    
    func bindViewEvents(chipTapped: Driver<Int>) {
        chipTapped
            .withLatestFrom(foodPairings) { index, foodPairings -> String in
                guard index < foodPairings.count else { return "" }
                return foodPairings[index]
            }
            .filter { !$0.isEmpty }
            .drive(onNext: search)
            .disposed(by: disposeBag)
    }
}

private extension BeerDetailsFoodPairingViewModel {
    func search(_ foodName: String) {
        let query = foodName.toQuery()
        let urlString = "https://www.google.com/search?q=\(query)"
        
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
