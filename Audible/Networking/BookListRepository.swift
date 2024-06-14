import UIKit

struct FirebasePostResponseDTO: Codable {
    let name: String
}

class BookListRepository {
    
    typealias BookListRespone = [String: BookListDTO]
    
    private lazy var booksUrl = baseUrl.appending(path: "books.json")
    
    private let baseUrl = URL(string: "https://audible-194a7-default-rtdb.europe-west1.firebasedatabase.app/")!
    
    private lazy var decoder = {
        let decorer = JSONDecoder()
        decorer.dateDecodingStrategy = .millisecondsSince1970
        return decorer
    }()
    
    
    private lazy var encoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return encoder
    }()
    
    func fetchBookList() async throws -> [Book] {
        
        let request = URLRequest(url: booksUrl)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try decoder.decode(BookListRespone.self, from: data)
        
        return toDomain(decoded)
    }
    
    func addBookToLibary(_ book: Book) async throws {
        var request = URLRequest(url: booksUrl)
        request.httpMethod = "POST"
        let bookDTO = book.toData
        request.httpBody = try encoder.encode(bookDTO)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try decoder.decode(FirebasePostResponseDTO.self, from: data)
        print("Added \(book.title) to database with id \(decoded.name)")
    }
    
    func postReview(_ review: String, to book: Book) async throws {
        var request = URLRequest(url: baseUrl.appending(path: "books/\(book.id)/reviews.json"))
        request.httpMethod = "POST"
        request.httpBody = try encoder.encode(BookListDTO.ReviewDTO(createDate: Date(), content: review))
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try decoder.decode(FirebasePostResponseDTO.self, from: data)
        print("Added review to book \(book.title) with review id \(decoded.name)")
    }
    
    func deleteBook(_ book: Book) async throws {
        var request = URLRequest(url: baseUrl.appending(path: "books/\(book.id).json"))
        request.httpMethod = "DELETE"
        
        let _ = try await URLSession.shared.data(for: request)
        
        print("Deleted book with id \(book.id)")
    }
    
    private func toDomain(_ bookListResponse: BookListRespone) -> [Book] {
        var result = [Book]()
        
        for (id, book) in bookListResponse {
            result.append(book.toDomain(with: id))
        }
        
        return result
    }
}

extension BookReview {
    var toData: BookListDTO.ReviewDTO {
        BookListDTO.ReviewDTO(
            createDate: createDate,
            content: content
        )
    }
}

extension BookListDTO {
    func toDomain(with id: String) -> Book {
        
        var reviews: [BookReview] = []
        for (id, review) in self.reviews {
            reviews.append(BookReview(id: id, createDate: review.createDate, content: review.content))
        }
        
        return Book(
            id: id,
            imageName: image,
            title: self.title,
            description: self.description,
            authors: [],
            reviews: reviews.sorted(by: { $0.createDate < $1.createDate} ),
            rating: self.rating,
            priceCredit: priceCredit,
            isInLibrary: true
        )
    }
}

extension Book {
    var toData: BookListDTO {
        
        var reviews: [String: BookListDTO.ReviewDTO] = [:]
        for review in self.reviews {
            reviews[review.id] = review.toData
        }
        
        return BookListDTO(
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
