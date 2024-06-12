import UIKit

class HomeBookCoversCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bookCovers: [Book] = []
    
    var didSelectBook: ((Book) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
    }
    
    func configure(with viewModel: BookCoversViewModel) {
        self.titleLbl.text = viewModel.title
        self.bookCovers = viewModel.bookCovers
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "BookCoverCell", bundle: nil), forCellWithReuseIdentifier: "BookCoverCell")
    }
}

extension HomeBookCoversCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookCovers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCoverCell", for: indexPath) as? BookCoverCell else { return UICollectionViewCell() }
        
        let bookCover = bookCovers[indexPath.item]
        cell.configure(with: bookCover)
        
        return cell
    }
}

extension HomeBookCoversCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 180, height: 231)
    }
}

extension HomeBookCoversCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = bookCovers[indexPath.item]
        
        didSelectBook?(book)
    }
}
