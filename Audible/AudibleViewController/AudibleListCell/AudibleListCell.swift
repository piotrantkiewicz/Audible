import UIKit

class AudibleListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func configure(with book: Book) {
        iconImageView.image = book.image
        titleLbl.text = "\(book.title) (\(book.rating))"
    }
}
