//
//  FavoritesViewController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private struct Constants {
    let minimumInteritemSpacing: CGFloat = 16
    let baseInset: CGFloat = 16
    let collectionViewTopOffset: CGFloat = 32
    let collectionViewBottomInset: CGFloat = 24
}
private let constants = Constants()

class FavoritesViewController: UIViewController {
    
    typealias Cell = FavoritesCollectionViewCell

    private let style: FavoritesStyleType
    private let viewModel: FavoritesViewModelType
    private let collectionView: UICollectionView
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    init(style: FavoritesStyleType, viewModel: FavoritesViewModelType) {
        self.style = style
        self.viewModel = viewModel
        
        let layout = FavoritesCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = constants.minimumInteritemSpacing
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller can be created only in code")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        applyStyle()
        configureViewComponents()
        bindViewModel()
    }
}

private extension FavoritesViewController {
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    func applyStyle() {
        view.backgroundColor = .white
        titleLabel.apply(style: style.titleLabelStyle)
        descriptionLabel.apply(style: style.descriptionLabelStyle)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func configureViewComponents() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(constants.baseInset)
        }
        titleLabel.text = NSLocalizedString("Favorites.Title",
            comment: "Favorites: title").uppercased()
        titleLabel.numberOfLines = 0

        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(constants.baseInset)
        }
        descriptionLabel.text = NSLocalizedString("Favorites.Description",
            comment: "Favorites: description")
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
                .offset(constants.collectionViewTopOffset)
            $0.trailing.leading.equalToSuperview().inset(constants.baseInset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                .inset(constants.collectionViewBottomInset)
        }
        
        let cellNib = UINib(nibName: Cell.nibName, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Cell.reuseId)
    }
    
    func bindViewModel() {
        viewModel.items
            .drive(collectionView.rx.items(cellIdentifier: Cell.reuseId,
                cellType: Cell.self)) { [weak self] (_, item, cell) in
                    cell.style = self?.style.cellStyle
                    cell.configure(with: item)
                }
                .disposed(by: disposeBag)
        
        viewModel.bindViewEvents(
            itemSelected: collectionView.rx.itemSelected.asSignal())
    }
}
