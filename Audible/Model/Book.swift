import UIKit

struct BookReview {
    let id: String
    let createDate: Date
    let content: String
    
    init(id: String = UUID().uuidString, createDate: Date = Date(), content: String) {
        self.id = id
        self.createDate = createDate
        self.content = content
    }
}

struct Book {
    let id: String
    let imageName: String
    let title: String
    let description: String
    let authors: [String]
    var reviews: [BookReview]
    let rating: String
    let isInLibrary: Bool
    let priceCredit: Int
    
    init(
        id: String = UUID().uuidString,
        imageName: String,
        title: String,
        description: String,
        authors: [String],
        reviews: [BookReview],
        rating: String,
        priceCredit: Int,
        isInLibrary: Bool = false
    ) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.description = description
        self.authors = authors
        self.reviews = reviews
        self.rating = rating
        self.priceCredit = priceCredit
        self.isInLibrary = isInLibrary
    }
}
