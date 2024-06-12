import UIKit

// curl -X 'POST -d { "authors" } 'https://audible-194a7-default-rtdb.europe-west1.firebasedatabase.app/books.json'

struct BookListDTO: Codable {
    let authors: [String]
    let title: String
    let description: String
    let rating: String
    let image: String
    let reviews: [String]
    let priceCredit: Int
    
    init(
        authors: [String],
        title: String,
        description: String,
        rating: String,
        image: String,
        reviews: [String],
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
        self.reviews = (try? container.decode([String].self, forKey: .reviews)) ?? []
        self.priceCredit = try container.decode(Int.self, forKey: .priceCredit)
    }
}

struct FirebasePostResponseDTO: Codable {
    let name: String
}

class BookListRepository {
    
    typealias BookListRespone = [String: BookListDTO]
    
    private let url = URL(string: "https://audible-194a7-default-rtdb.europe-west1.firebasedatabase.app/books.json")!
    
    func fetchBookList() async throws -> [Book] {
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try JSONDecoder().decode(BookListRespone.self, from: data)
        
        return toDomain(decoded)
    }
    
    func addBookToLibary(_ book: Book) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bookDTO = book.toData
        request.httpBody = try JSONEncoder().encode(bookDTO)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try JSONDecoder().decode(FirebasePostResponseDTO.self, from: data)
        print("Added \(book.title) to database with id \(decoded.name)")
    }
    
    private func toDomain(_ bookListResponse: BookListRespone) -> [Book] {
        var result = [Book]()
        
        for (_, bookListDTO) in bookListResponse {
            result.append(bookListDTO.toDomain)
        }
        
        return result
    }
}

extension BookListDTO {
    var toDomain: Book {
        Book(
            imageName: image,
            title: self.title,
            description: self.description,
            authors: [],
            reviews: reviews,
            rating: self.rating, 
            priceCredit: priceCredit,
            isInLibrary: true
        )
    }
}

extension Book {
    var toData: BookListDTO {
        BookListDTO(
            authors: authors,
            title: title,
            description: description,
            rating: rating,
            image: imageName,
            reviews: reviews,
            priceCredit: priceCredit
        )
    }
}
