import UIKit

class AudibleListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func configure(with book: Book) {
        iconImageView.image = UIImage(named: book.imageName)
        titleLbl.text = "\(book.title) (\(book.rating))"
    }
}
