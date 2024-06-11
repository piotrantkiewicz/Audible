import UIKit

struct Book {
    let image: UIImage
    let title: String
    let description: String
    let authors: [String]
    var reviews: [String]
    let rating: String
    let isInLibrary: Bool
    let priceCredit: Int
    
    init(
        image: UIImage,
        title: String,
        description: String,
        authors: [String],
        reviews: [String],
        rating: String,
        priceCredit: Int,
        isInLibrary: Bool = false
    ) {
        self.image = image
        self.title = title
        self.description = description
        self.authors = authors
        self.reviews = reviews
        self.rating = rating
        self.priceCredit = priceCredit
        self.isInLibrary = isInLibrary
    }
}
