//
//  BeersDataSourceType.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

public protocol BeersDataSourceType {
    func makeBaseBeersFRC() -> MultiFetchedResultsControllerDelegate<BeerInfo>
    func makeBeerInfoFRC(withID id: Int) -> FetchedResultsControllerDelegate<BeerInfo>
    func makeBeersFRC(withIDs ids: Set<Int>) -> MultiFetchedResultsControllerDelegate<BeerInfo>
    func makeFilteredBeersFRC(storage: BeerFiltersStorageType)
        -> MultiFetchedResultsControllerDelegate<BeerInfo>
}
