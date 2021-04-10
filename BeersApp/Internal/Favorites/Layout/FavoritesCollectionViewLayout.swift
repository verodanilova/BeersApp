//
//  FavoritesCollectionViewLayout.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import UIKit

private struct Constants {
    let multiViewsMultiplier: CGFloat = 0.8
}
private let constants = Constants()

class FavoritesCollectionViewLayout: UICollectionViewFlowLayout {
    private var recentOffset: CGPoint = .zero
    private var framesCache: [Int:CGRect] = [:]

    private var numberOfItems: Int {
        guard let collectionView = collectionView else { return 1 }
        return collectionView.numberOfItems(inSection: 0)
    }
    
    private var itemWidth: CGFloat {
        guard let collectionView = collectionView else { return 1 }
        return ceil(collectionView.bounds.size.width * multiplier)
    }
    
    private var itemBorderOffset: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let multiplier = (1 - constants.multiViewsMultiplier) / 2
        return ceil(collectionView.bounds.size.width * multiplier)
    }
    
    private var multiplier: CGFloat {
        return numberOfItems == 1 ? 1 : constants.multiViewsMultiplier
    }
    
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.size.height
    }

    private var contentWidth: CGFloat {
        let numberOfItems = CGFloat(self.numberOfItems)
        let itemsSpacing = (numberOfItems - 1) * minimumInteritemSpacing
        return CGFloat(itemWidth * numberOfItems) + itemsSpacing
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    func getVisibleFrames() -> [Int:CGRect] {
        guard let collectionView = collectionView else { return [:] }
        let visibleRect = collectionView.bounds
        return framesCache.filter { visibleRect.contains($0.value) }
    }
  
    private func frameForItem(at indexPath: IndexPath) -> CGRect {
        var cellFrame = CGRect.zero
        cellFrame.origin.x = CGFloat(indexPath.row) * (itemWidth + minimumInteritemSpacing)
        cellFrame.origin.y = 0
        cellFrame.size.width = itemWidth
        cellFrame.size.height = contentHeight
        framesCache[indexPath.row] = cellFrame
        return cellFrame
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        framesCache = [:]
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        framesCache = [:]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy()
            as? UICollectionViewLayoutAttributes
        attributes?.frame = frameForItem(at: indexPath)
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
        if numberOfItems == 0 { return nil }
        
        return (0..<numberOfItems)
            .compactMap { self.layoutAttributesForItem(at: IndexPath(row: $0, section: 0)) }
            .filter { $0.frame.intersects(rect) }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let cvSize = collectionView.bounds.size

        let cvBounds = CGRect(
            x: proposedContentOffset.x,
            y: proposedContentOffset.y,
            width: cvSize.width,
            height: cvSize.height
        )

        guard let visibleAttributes = layoutAttributesForElements(in: cvBounds) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }

        var candidate: UICollectionViewLayoutAttributes?
        for attributes in visibleAttributes {
            if attributes.center.x < proposedContentOffset.x {
                continue
            }

            candidate = attributes
            break
        }
        
        let endOfContentIncludingProposed = proposedContentOffset.x
            + cvSize.width
            - collectionView.contentInset.left
            - minimumInteritemSpacing

        if endOfContentIncludingProposed > collectionView.contentSize.width {
            candidate = visibleAttributes.last
        }

        if let candidate = candidate {
            self.recentOffset = CGPoint(
                x: candidate.frame.origin.x - itemBorderOffset,
                y: proposedContentOffset.y)
            return recentOffset
        } else {
            return recentOffset
        }
    }
}
