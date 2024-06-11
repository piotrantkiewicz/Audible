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
        configureButton(with: book)
    }
    
    private func configureButton(with book: Book) {
        if book.isInLibrary {
            playButton.setTitle("Play", for: .normal)
            playButton.setTitleColor(.black, for: .normal)
            playButton.backgroundColor = .secondaryButton
        } else {
            playButton.setTitle(configurePurchaseButtonTitle(with: book.priceCredit), for: .normal)
            playButton.setTitleColor(.white, for: .normal)
            playButton.backgroundColor  = .primaryButton
        }
        
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func configurePurchaseButtonTitle(with credits: Int) -> String {
        if credits <= 1 {
            return "Purchase (\(credits) credit)"
        } else {
            return "Purchase (\(credits) credits)"
        }
    }
}
