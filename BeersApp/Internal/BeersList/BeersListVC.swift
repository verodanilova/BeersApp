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
    let filtersButtonHeight: CGFloat = 44.0
    let filtersButtonWidthRatio: CGFloat = 0.4
    let headerViewHeight: CGFloat = 60
    let footerViewHeight: CGFloat = 60
    let filtersButtonAnimationDuration: TimeInterval = 0.3
    let errorDisplayThrottle: RxTimeInterval = .seconds(4)
    let errorDisplayDuration: TimeInterval = 0.25
    let errorHidingDuration: TimeInterval = 0.25
    let errorHidingDelay: TimeInterval = 3.5
}
private let constants = Constants()

class BeersListViewController: UIViewController {
    
    typealias Cell = BeersListItemCell
    
    private let tableView = UITableView()
    private let filtersButton = UIButton()
    private var headerView = BeersListHeaderView()
    private var footerView: BeersListFooterView?
    
    var viewModel: BeersListViewModelType?
    var style: BeersListStyleType?
    
    private let itemAddedToFavorites = PublishRelay<IndexPath>()
    private let disposeBag = DisposeBag()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
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
        filtersButton.apply(style: style.filtersButtonStyle)
        
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = style.tableViewBackgroundColor
    }
    
    func configureViewComponents() {
        /* Table view */
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        tableView.registerCell(BeersListItemCell.reuseId, BeersListItemCell.nibName)
        
        let headerViewFrame = CGRect(x: 0, y: 0, width: view.frame.width,
            height: constants.headerViewHeight)
        headerView = BeersListHeaderView(frame: headerViewFrame)
        headerView.style = style?.headerStyle
        
        let footerViewFrame = CGRect(x: 0, y: 0, width: view.frame.width,
            height: constants.footerViewHeight)
        self.footerView = BeersListFooterView(frame: footerViewFrame)
        footerView?.style = style?.footerStyle
        tableView.tableFooterView = footerView
        
        /* Filters button */
        view.addSubview(filtersButton)
        filtersButton.translatesAutoresizingMaskIntoConstraints = false
        filtersButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-constants.offset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(constants.filtersButtonHeight)
            $0.width.equalToSuperview().multipliedBy(constants.filtersButtonWidthRatio)
        }
        
        let filtersButtonTitle = NSLocalizedString(
            "Beers list.Filters button.Title",
            comment: "Beers list: filters button title")
        filtersButton.setTitle(filtersButtonTitle, for: .normal)
        
        filtersButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in self?.feedbackGenerator.impactOccurred() })
            .disposed(by: disposeBag)
    }
    
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.items
            .drive(tableView.rx.items(
                cellIdentifier: Cell.reuseId, cellType: Cell.self)) {
                [weak self] (index, item, cell) in
                    cell.style = self?.style?.itemStyle
                    cell.configure(with: item)
                    cell.toFavoritesAction = { [weak self] in
                        self?.viewModel?.itemAddedToFavorites(index)
                    }
                }
                .disposed(by: disposeBag)
        
        let isEmptyList = viewModel.items.map { $0.isEmpty }
        Driver.combineLatest(viewModel.isInActivity, isEmptyList)
            .drive(onNext: { [weak self] in
                self?.updateActivityState(isInActivity: $0, isEmptyList: $1)
            })
            .disposed(by: disposeBag)
        
        viewModel.showFiltersInfo
            .drive(onNext: weakly(self, type(of: self).showFiltersInfo))
            .disposed(by: disposeBag)
        
        viewModel.errorOccurredSignal
            .throttle(constants.errorDisplayThrottle)
            .emit(onNext: weakly(self, type(of: self).showError))
            .disposed(by: disposeBag)
                
        viewModel.bindViewEvents(
            itemSelected: tableView.rx.itemSelected.asSignal(),
            itemAddedToFavorites: itemAddedToFavorites.asSignal(),
            filtersTap: filtersButton.rx.tap.asSignal(),
            resetFiltersTap: headerView.resetButtonTap)
    }
    
    func updateActivityState(isInActivity: Bool, isEmptyList: Bool) {
        footerView?.isInitialLoading = isEmptyList
        tableView.tableFooterView?.isHidden = !isInActivity
    }
    
    func showFiltersInfo(_ show: Bool) {
        if show {
            tableView.tableHeaderView = headerView
        } else {
            tableView.tableHeaderView = nil
        }
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
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: constants.filtersButtonAnimationDuration) {
            self.filtersButton.alpha = 0
        } completion: { _ in
            self.filtersButton.isHidden = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        filtersButton.isHidden = false
        UIView.animate(withDuration: constants.filtersButtonAnimationDuration) {
            self.filtersButton.alpha = 1
        }
    }
}

// MARK: - Error display
extension BeersListViewController {
    func showError() {
        guard let style = style else { return }
        let errorView = UIView()
        errorView.backgroundColor = style.errorBackgroundColor
        errorView.alpha = 0
        
        let errorLabel = UILabel()
        errorLabel.apply(style: style.errorTextStyle)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.text = NSLocalizedString(
            "Beers list.Common error.Title",
            comment: "Beers list: common error text")
        
        errorView.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.offset)
        }
        
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        UIView.animate(withDuration: constants.errorDisplayDuration) {
            errorView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: constants.errorHidingDuration,
                delay: constants.errorHidingDelay) {
                errorView.alpha = 0
            } completion: { _ in
                errorView.removeFromSuperview()
            }
        }
    }
}
