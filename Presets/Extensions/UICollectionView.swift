import UIKit

extension UICollectionView {
    
    func registerCell(_ cell: Cell) {
        self.register(cell.nib, forCellWithReuseIdentifier: cell.rawValue)
    }
    
}
