import UIKit

struct BookListDTO: Codable {
    let title: String
    let description: String
    let rating: String
    let image: String
    let reviews: [String]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.rating = try container.decode(String.self, forKey: .rating)
        self.image = try container.decode(String.self, forKey: .image)
        self.reviews = try container.decode([String].self, forKey: .reviews)
    }
}

class BookListRepository {
    
    typealias BookListRespone = [String: BookListDTO]
    
    func fetchBookList() async throws -> [AudibleList] {
        let url = URL(string: "https://audible-194a7-default-rtdb.europe-west1.firebasedatabase.app/books.json")!
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try JSONDecoder().decode(BookListRespone.self, from: data)
        
        return toDomain(decoded)
    }
    
    private func toDomain(_ bookListResponse: BookListRespone) -> [AudibleList] {
        var result = [AudibleList]()
        
        for (_, bookListDTO) in bookListResponse {
            result.append(bookListDTO.toDomain)
        }
        
        return result
    }
}

extension BookListDTO {
    var toDomain: AudibleList {
        AudibleList(
            image: UIImage(named: image) ?? UIImage(),
            title: self.title,
            description: self.description,
            reviews: reviews,
            rating: self.rating
        )
    }
}
