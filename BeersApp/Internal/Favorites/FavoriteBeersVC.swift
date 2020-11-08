//
//  FavoriteBeersViewController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class FavoriteBeersViewController: UIViewController {
    
    var viewModel: FavoriteBeersViewModelType?
    var style: FavoriteBeersStyleType?
    
    private let tableView = UITableView()
    private let itemRemovedFromFavorites = PublishRelay<IndexPath>()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyle()
        configureViewComponents()
        bindViewModel()
    }
}

private extension FavoriteBeersViewController {
    func applyStyle() {
        guard let style = style else { return }
        
        view.backgroundColor = style.backgroundColor

        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = style.separatorInset
        tableView.separatorColor = style.separatorColor
        tableView.backgroundColor = style.tableViewBackgroundColor
    }
    
    func configureViewComponents() {
        let navigationBarTitle = NSLocalizedString(
            "Favorites.Navigation bar.Title",
            comment: "Navigation bar title for favorite beers")
        navigationItem.title = navigationBarTitle
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        tableView.registerCell(BeersListItemCell.reuseId, BeersListItemCell.nibName)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.items
            .drive(tableView.rx.items(
                cellIdentifier: BeersListItemCell.reuseId,
                cellType: BeersListItemCell.self))
                { [weak self] (_, model, cell) in
                    cell.style = self?.style?.itemStyle
                    cell.viewModel = model
                }
                .disposed(by: disposeBag)
        
        viewModel.bindViewEvents(
            itemSelected: tableView.rx.itemSelected.asSignal(),
            itemDeleted: itemRemovedFromFavorites.asSignal())
    }
}

// MARK: - UITableViewDelegate conformance
extension FavoriteBeersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
        indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let title = NSLocalizedString(
            "Favorites.Swipe action.Remove from favorite.Title",
            comment: "Favorites: swipe action title")
        
        let unfavorite = UIContextualAction(style: .destructive, title: title) {
            [weak self] (_, _, completion) in
                self?.itemRemovedFromFavorites.accept(indexPath)
                completion(true)
        }
        unfavorite.backgroundColor = style?.swipeActionBackgroundColor

        let configuration = UISwipeActionsConfiguration(actions: [unfavorite])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
