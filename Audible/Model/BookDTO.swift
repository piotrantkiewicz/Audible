import Foundation

struct BookListDTO: Codable {
    
    struct ReviewDTO: Codable {
        let createDate: Date
        let content: String
    }
    
    let authors: [String]
    let title: String
    let description: String
    let rating: String
    let image: String
    let reviews: [String: ReviewDTO]
    let priceCredit: Int
    
    init(
        authors: [String],
        title: String,
        description: String,
        rating: String,
        image: String,
        reviews: [String: ReviewDTO],
        priceCredit: Int
    ) {
        self.authors = authors
        self.title = title
        self.description = description
        self.rating = rating
        self.image = image
        self.reviews = reviews
        self.priceCredit = priceCredit
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authors = try container.decode([String].self, forKey: .authors)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.rating = try container.decode(String.self, forKey: .rating)
        self.image = try container.decode(String.self, forKey: .image)
        self.reviews = (try? container.decode([String: ReviewDTO].self, forKey: .reviews)) ?? [:]
        self.priceCredit = try container.decode(Int.self, forKey: .priceCredit)
    }
}
