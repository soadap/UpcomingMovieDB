import UIKit

// custom parallax collection view

class ParallaxCollectionViewLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.flatMap { $0.copy() as? UICollectionViewLayoutAttributes }.flatMap(addParallaxToAttributes)
    }

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func addParallaxToAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let width = collectionView.frame.width
        let centerX = width / 2
        let offset = collectionView.contentOffset.x
        let itemX = attributes.center.x - offset
        let position = (itemX - centerX) / width
        let contentView = collectionView.cellForItem(at: attributes.indexPath)?.contentView
        
        if abs(position) >= 1 {
            contentView?.transform = .identity
        } else {
            let transitionX = -(width * 0.5 * position)
            contentView?.transform = CGAffineTransform(translationX: transitionX, y: 0)
        }
        
        return attributes
    }
}
