//
//  BeersListViewController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit
import SnapKit
import RxSwift


private struct Constants {
    let offset: CGFloat = 16.0
    let sortButtonHeight: CGFloat = 44.0
}
private let constants = Constants()

class BeersListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let sortButton = UIButton()
    
    var viewModel: BeersListViewModelType?
    var style: BeersListStyleType?
    
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
extension BeersListViewController {
    func applyStyle() {
        guard let style = style else { return }
        
        view.backgroundColor = style.backgroundColor
        sortButton.apply(style: style.sortButtonStyle)
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = style.separatorInset
        tableView.separatorColor = style.separatorColor
        tableView.backgroundColor = style.tableViewBackgroundColor
    }
    
    func configureViewComponents() {
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
            sortTap: sortButton.rx.tap.asSignal())
    }
}
