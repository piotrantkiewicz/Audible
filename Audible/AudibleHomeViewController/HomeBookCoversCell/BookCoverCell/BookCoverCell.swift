import UIKit

class BookCoverCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with book: Book) {
        imageView.image = UIImage(named: book.imageName)
        titleLbl.text = book.title
        authorLbl.text = authorsSubtitle(from: book.authors)
    }
    
    private func authorsSubtitle(from authors: [String]) -> String {
        "By " + authors.joined(separator: ", ")
    }

}
