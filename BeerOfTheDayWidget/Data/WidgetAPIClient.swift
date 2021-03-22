//
//  WidgetAPIClient.swift
//  BeersApp
//
//  Created by Veronica Danilova on 20.03.2021.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa


class WidgetAPIClient: NSObject {
    
    struct Constants {
        static let beerURL = "https://api.punkapi.com/v2/beers/random"
        static let maxBeersCount: Int = 3
    }

    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        return SessionManager(configuration: configuration)
    }()
    
    private let disposeBag = DisposeBag()
    
    func loadBeers(completion: @escaping ([WidgetBeerInfo]) -> ()) {
        guard let url = URL(string: Constants.beerURL) else {
            completion([])
            return
        }

        let requests = Array(repeating: loadBeer(url), count: Constants.maxBeersCount)
        Observable.zip(requests)
            .map { $0.compactMap { $0 } }
            .subscribe { completion($0) }
            .disposed(by: disposeBag)
    }
}

private extension WidgetAPIClient {
    func loadBeer(_ url: URL) -> Observable<WidgetBeerInfo?> {
        sessionManager.rx.request(.get, url)
            .data()
            .map(parseBeers)
            .flatMap(loadImage)
            .catchErrorJustReturn(nil)
    }

    func parseBeers(_ data: Data) -> [WidgetBeerInfo] {
        let decoder = JSONDecoder()
        let beers = try? decoder.decode([WidgetBeerInfo].self, from: data)
        return beers ?? []
    }

    func loadImage(for beers: [WidgetBeerInfo]) -> Observable<WidgetBeerInfo?> {
        guard var beer = beers.first else {
            return .just(nil)
        }

        guard let url = beer.imageURL else {
            return .just(beer)
        }

        return sessionManager.rx.request(.get, url)
            .data()
            .map { imageData in
                beer.imageData = imageData
                return beer
            }
            .catchErrorJustReturn(beer)
    }
}

