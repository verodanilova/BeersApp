//
//  BeerDetailsViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation
import RxSwift
import RxCocoa


protocol BeerDetailsViewModelType {
    var imageURL: Driver<URL?> {get}
    var navigationBarTitle: Driver<String?> {get}
    var infoViewModel: BeerDetailsInfoViewModelType {get}
}

final class BeerDetailsViewModel: BeerDetailsViewModelType {
    typealias Context = DataContext
    let imageURL: Driver<URL?>
    let navigationBarTitle: Driver<String?>
    let infoViewModel: BeerDetailsInfoViewModelType
    
    private let dataSource: BeersDataSourceType
    private let beerFRC: FetchedResultsControllerDelegate<BeerInfo>

    init(context: Context, id: Int) {
        self.dataSource = BeersDataSource(context: context)
        self.beerFRC = dataSource.makeBeerInfoFRC(withID: id)
        
        let beerInfo = beerFRC.fetchedItem
        self.imageURL = beerInfo.map { $0.imageURL }
        self.navigationBarTitle = beerInfo.map { $0.name }
        self.infoViewModel = BeerDetailsInfoViewModel(info: beerInfo)
    }
}
