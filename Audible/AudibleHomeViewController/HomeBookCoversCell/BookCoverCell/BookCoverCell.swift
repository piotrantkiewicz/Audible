import UIKit

struct BookCover {
    let image: UIImage
    let title: String
    let authors: [String]
}

class BookCoverCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with bookCover: BookCover) {
        imageView.image = bookCover.image
        titleLbl.text = bookCover.title
        authorLbl.text = authorsSubtitle(from: bookCover.authors)
    }
    
    private func authorsSubtitle(from authors: [String]) -> String {
        "By " + authors.joined(separator: ", ")
    }

}
