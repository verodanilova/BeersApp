//
//  BeersListViewController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


private struct Constants {
    let offset: CGFloat = 16.0
    let sortButtonHeight: CGFloat = 44.0
    let footerViewHeight: CGFloat = 60
}
private let constants = Constants()

class BeersListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let sortButton = UIButton()
    private var footerView: BeersListFooterView?
    
    var viewModel: BeersListViewModelType?
    var style: BeersListStyleType?
    
    private let itemAddedToFavorites = PublishRelay<IndexPath>()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        applyStyle()
        configureViewComponents()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.prepare()
    }
}

// MARK: - View configuration
private extension BeersListViewController {
    func applyStyle() {
        guard let style = style else { return }
        
        view.backgroundColor = style.backgroundColor
        sortButton.apply(style: style.sortButtonStyle)
        
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = style.separatorInset
        tableView.separatorColor = style.separatorColor
        tableView.backgroundColor = style.tableViewBackgroundColor
    }
    
    func configureViewComponents() {
        let navigationBarTitle = NSLocalizedString(
            "Beers list.Navigation bar.Title",
            comment: "Navigation bar title for beers list")
        navigationItem.title = navigationBarTitle
        
        view.addSubview(sortButton)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(constants.offset)
            $0.leading.equalToSuperview().offset(constants.offset)
            $0.trailing.equalToSuperview().offset(-constants.offset)
            $0.height.equalTo(constants.sortButtonHeight)
        }
        
        let sortButtonTitle = NSLocalizedString(
            "Beers list.Sort button.Title",
            comment: "Beers list: sort button title")
        sortButton.setTitle(sortButtonTitle, for: .normal)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(constants.offset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.registerCell(BeersListItemCell.reuseId, BeersListItemCell.nibName)
        
        let footerViewFrame = CGRect(x: 0, y: 0, width: view.frame.width,
            height: constants.footerViewHeight)
        self.footerView = BeersListFooterView(frame: footerViewFrame)
        footerView?.style = style?.footerStyle
        tableView.tableFooterView = footerView
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
        
        let isEmptyList = viewModel.items.map { $0.isEmpty }
        Driver.combineLatest(viewModel.isInActivity, isEmptyList)
            .drive(onNext: { [weak self] in
                self?.updateActivityState(isInActivity: $0, isEmptyList: $1)
            })
            .disposed(by: disposeBag)
        
        viewModel.bindViewEvents(
            itemSelected: tableView.rx.itemSelected.asSignal(),
            itemAddedToFavorites: itemAddedToFavorites.asSignal(),
            sortTap: sortButton.rx.tap.asSignal())
    }
    
    func updateActivityState(isInActivity: Bool, isEmptyList: Bool) {
        footerView?.isInitialLoading = isEmptyList
        tableView.tableFooterView?.isHidden = !isInActivity
    }
}

// MARK: - UITableViewDelegate conformance
extension BeersListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let delta = maximumOffset - currentOffset
                
        if delta <= 0 {
            viewModel?.loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
        indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let title = viewModel?.swipeActionTitle(at: indexPath) else {
            return nil
        }
        
        let addToFavorites = UIContextualAction(style: .normal, title: title) {
            [weak self] (_, _, completion) in
                self?.itemAddedToFavorites.accept(indexPath)
                completion(true)
        }
        addToFavorites.backgroundColor = style?.swipeActionBackgroundColor

        let configuration = UISwipeActionsConfiguration(actions: [addToFavorites])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
