import UIKit

struct BookListDTO: Codable {
    let title: String
    let description: String
    let rating: String
    let image: String
    let reviews: [String]
    let priceCredit: Int
}

class BookListRepository {
    
    typealias BookListRespone = [String: BookListDTO]
    
    func fetchBookList() async throws -> [Book] {
        let url = URL(string: "https://audible-194a7-default-rtdb.europe-west1.firebasedatabase.app/books.json")!
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try JSONDecoder().decode(BookListRespone.self, from: data)
        
        return toDomain(decoded)
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
            image: UIImage(named: image) ?? UIImage(),
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
