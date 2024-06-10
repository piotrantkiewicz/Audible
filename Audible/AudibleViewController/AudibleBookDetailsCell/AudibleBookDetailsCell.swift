import UIKit

class AudibleBookDetailsCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playButton.layer.cornerRadius = 22
        playButton.clipsToBounds = true
        selectionStyle = .none
    }
    
    func configure(with book: Book) {
        bookImageView.image = book.image
        titleLbl.text = book.title
        subTitleLbl.text = book.description
    }
}
