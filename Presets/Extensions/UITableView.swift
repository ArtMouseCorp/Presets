import UIKit

extension UITableView {
    
    func registerCell(_ cell: Cell) {
        self.register(cell.nib, forCellReuseIdentifier: cell.rawValue)
    }
    
}
