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
    let footerViewHeight: CGFloat = 60
    let errorDisplayThrottle: RxTimeInterval = .seconds(4)
    let errorDisplayDuration: TimeInterval = 0.25
    let errorHidingDuration: TimeInterval = 0.25
    let errorHidingDelay: TimeInterval = 3.5
}
private let constants = Constants()

class BeersListViewController: UIViewController {
    
    typealias Cell = BeersListItemCell
    
    private let tableView = UITableView()
    private let filtersButton = FiltersButton()
    private let baseHeaderView = BeerListBaseHeaderView()
    private let filteredHeaderView = BeerListFilteredHeaderView()
    private var footerView: BeersListFooterView?
    
    var viewModel: BeersListViewModelType?
    var style: BeersListStyleType?

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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderSize()
    }
}

// MARK: - View configuration
private extension BeersListViewController {
    func applyStyle() {
        guard let style = style else { return }
        
        view.backgroundColor = style.backgroundColor
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = style.tableViewBackgroundColor
    }
    
    func configureViewComponents() {
        /* Table view */
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        tableView.registerCell(Cell.reuseId, Cell.nibName)
        filteredHeaderView.style = style?.filteredHeaderStyle
        filteredHeaderView.delegate = self
        baseHeaderView.style = style?.baseHeaderStyle
        
        let footerViewFrame = CGRect(x: 0, y: 0, width: view.frame.width,
            height: constants.footerViewHeight)
        self.footerView = BeersListFooterView(frame: footerViewFrame)
        footerView?.style = style?.footerStyle
        tableView.tableFooterView = footerView
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
            .drive(onNext: updateActivityState)
            .disposed(by: disposeBag)
        
        viewModel.headerFilters
            .drive(onNext: updateHeader)
            .disposed(by: disposeBag)
        
        viewModel.errorOccurredSignal
            .throttle(constants.errorDisplayThrottle)
            .emit(onNext: showError)
            .disposed(by: disposeBag)
                
        let filtersTapSignals = [filtersButton.rx.tap.asSignal(),
            baseHeaderView.filtersTap, filteredHeaderView.filtersTap]
        Signal.merge(filtersTapSignals)
            .emit(onNext: { [weak self] _ in self?.feedbackGenerator.impactOccurred() })
            .disposed(by: disposeBag)
        
        viewModel.bindViewEvents(
            itemSelected: tableView.rx.itemSelected.asSignal(),
            filtersTap: Signal.merge(filtersTapSignals),
            resetFilterTap: filteredHeaderView.resetFilterTap,
            resetFiltersTap: filteredHeaderView.resetButtonTap)
    }
    
    func updateActivityState(isInActivity: Bool, isEmptyList: Bool) {
        footerView?.isInitialLoading = isEmptyList
        tableView.tableFooterView?.isHidden = !isInActivity
    }
    
    func updateHeader(with headerFilters: HeaderFilters) {
        tableView.tableHeaderView = nil
        
        if headerFilters.isEmpty {
            tableView.tableHeaderView = baseHeaderView
        } else {
            tableView.tableHeaderView = filteredHeaderView
            filteredHeaderView.configure(with: headerFilters)
            filteredHeaderView.setNeedsLayout()
        }

        view.setNeedsLayout()
    }
}

// MARK: - UITableViewDelegate conformance
extension BeersListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateFiltersButtonState(offsetY: scrollView.contentOffset.y)
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let delta = maximumOffset - currentOffset
                
        if delta <= 0 {
            viewModel?.loadMoreData()
        }
    }
    
    private func updateFiltersButtonState(offsetY: CGFloat) {
        if offsetY > baseHeaderView.frame.height {
            if navigationItem.rightBarButtonItems == nil {
                let barFilters = UIBarButtonItem(customView: filtersButton)
                navigationItem.setRightBarButtonItems([barFilters], animated: true)
            }
        } else {
            if navigationItem.rightBarButtonItems != nil {
                navigationItem.setRightBarButtonItems(nil, animated: true)
            }
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

// MARK: - BeerListHeaderDelegate conformance
extension BeersListViewController: BeerListHeaderDelegate {
    func updateHeaderSize() {
        guard let header = tableView.tableHeaderView else {
            return
        }
        
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if header.frame.size.height != size.height {
            header.frame.size.height = size.height
            self.tableView.tableHeaderView = header
            self.tableView.layoutIfNeeded()
        }
    }
}
