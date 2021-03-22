//
//  BeerDetailsInteractor.swift
//  BeersApp
//
//  Created by Veronica Danilova on 22.03.2021.
//

import Foundation
import RxSwift
import RxCocoa
import BeersCore

protocol BeerDetailsInteractorType {
    var beerInfo: Driver<BeerInfo> {get}
    var isInActivity: Driver<Bool> {get}
    var errorOccurredSignal: Signal<Void> {get}
}

final class BeerDetailsInteractor: BeerDetailsInteractorType {
    typealias Context = BeersAPIContext & BeersDataSourceContext
    
    let beerInfo: Driver<BeerInfo>
    let isInActivity: Driver<Bool>
    let errorOccurredSignal: Signal<Void>
    
    private let context: Context
    private let beerFRC: FetchedResultsControllerDelegate<BeerInfo>
    private let isLoadingInProgressRelay = BehaviorRelay<Bool>(value: false)
    private let errorOccurredRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    init(context: Context, beerID: Int) {
        self.context = context
        self.beerFRC = context.beersDataSource.makeBeerInfoFRC(withID: beerID)
        self.beerInfo = beerFRC.fetchedItem
        self.isInActivity = isLoadingInProgressRelay.asDriver()
        self.errorOccurredSignal = errorOccurredRelay.asSignal()
        
        loadBeerDetailsIfNeeded(id: beerID)
    }
}

private extension BeerDetailsInteractor {
    func loadBeerDetailsIfNeeded(id: Int) {
        guard beerFRC.currentItem == nil else {
            return
        }
        
        isLoadingInProgressRelay.accept(true)
        
        context.beersAPI.getBeer(with: id)
            .subscribe(onSuccess: { [weak self] _ in
                self?.isLoadingInProgressRelay.accept(false)
            }, onError: { [weak self] error in
                self?.isLoadingInProgressRelay.accept(false)
                self?.errorOccurredRelay.accept(())
            })
            .disposed(by: disposeBag)
    }
}
