//
//  Netmanager.swift
//  Login
//
//  Created by 金成四 on 2024/03/09.
//

import Foundation
//import Alamofire
struct Quote: Codable {
    let quote: String
    let author: String
    let category: String
}

struct UseQuote: Codable {
    let quoteMsg: Quote
    var isFaviorate: Bool = false
}

enum QuoteCategory: String, CaseIterable {
    case age
    case alone
    case amazing
    case anger
    case architecture
    case art
    case attitude
    case beauty
    case best
    case birthday
    case business
    case car
    case change
    case communication
    case computers
    case cool
    case courage
    case dad
    case dating
    case death
    case design
    case dreams
    case education
    case environmental
    case equality
    case experience
    case failure
    case faith
    case family
    case famous
    case fear
    case fitness
    case food
    case forgiveness
    case freedom
    case friendship
    case funny
    case future
    case god
    case good
    case government
    case graduation
    case great
    case happiness
    case health
    case history
    case home
    case hope
    case humor
    case imagination
    case inspirational
    case intelligence
    case jealousy
    case knowledge
    case leadership
    case learning
    case legal
    case life
    case love
    case marriage
    case medical
    case men
    case mom
    case money
    case morning
    case movies
    case success
}

class Netmanager {
    func commonNet(category: QuoteCategory,  onComplete: @escaping (Quote) -> Void) {
        let category = category.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category="+category!)!
        var request = URLRequest(url: url)
        request.setValue("1B7AcqtHA6S46nRBYzo+NQ==QJ0AfaKwb83EtIU4", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            do {
                // 将data类型转换成自建模型
                let responseMsg = try JSONDecoder().decode([Quote].self, from: data)
                print(responseMsg)
                onComplete(responseMsg[0])
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
//    func commonNet(quoteCategory: QuoteCategory) {
//        let category = quoteCategory.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category="+category!)!
//        var request = URLRequest(url: url)
//        request.setValue("1B7AcqtHA6S46nRBYzo+NQ==QJ0AfaKwb83EtIU4", forHTTPHeaderField: "X-Api-Key")
//        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//            if let error = error {
//                   print("Request error: \(error)")
//                   return
//               }
//               
//               guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                   print("Unexpected response status code: \(String(describing: response))")
//                   return
//               }
//
//               guard let data = data else {
//                   print("No data received")
//                   return
//               }
//               
//               do {
//                   let quotes = try JSONDecoder().decode([Quote].self, from: data)
//                   for quote in quotes {
//                       print("\(quote.quote) — \(quote.author)")
//                   }
//               } catch {
//                   print("Error decoding JSON: \(error)")
//               }
//        }
//        task.resume()
//    }
//   
//
//    func fetchQuotes(quoteCategory: QuoteCategory) {
//        let category = quoteCategory.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        let urlString = "https://api.api-ninjas.com/v1/quotes?category=" + category
//        let headers: HTTPHeaders = [
//            "X-Api-Key": "1B7AcqtHA6S46nRBYzo+NQ==QJ0AfaKwb83EtIU4"
//        ]
//        
//        AF.request(urlString, method: .get, headers: headers).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let quotes = try JSONDecoder().decode([Quote].self, from: data)
//                    for quote in quotes {
//                        print("\(quote.quote) — \(quote.author)")
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            case .failure(let error):
//                print("Error during request: \(error)")
//            }
//        }
//    }

}
