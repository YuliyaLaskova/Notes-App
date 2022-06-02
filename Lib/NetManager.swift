//
//  NetManager.swift
//  Notes App
//
//  Created by Yuliya Laskova on 30.05.2022.
//

import Foundation
import UIKit

class NetManager {
    static let shared = NetManager()

    internal lazy var session: URLSession = {
        URLSession.shared
    }()

    func fetchNotes(completion: @escaping ([NoteDataModel]) -> Void) {
        guard let request = createURLRequest() else { completion([]); return }
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let responses = try JSONDecoder().decode([Note].self, from: data)
                DispatchQueue.main.async {
                    completion(responses.map { $0.dataModel })
                }
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
        task.resume()
    }

    func fetchUserIcon(userIconPath: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: userIconPath) else { completion(nil); return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { completion(nil); return }

            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                completion(image)
            }

        }
        task.resume()
    }

    private func createURLRequest() -> URLRequest? {
        guard let url = createURLWithComponents() else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

    private func createURLWithComponents() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "firebasestorage.googleapis.com"
        urlComponents.path = "/v0/b/ios-test-ce687.appspot.com/o/lesson8.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "215055df-172d-4b98-95a0-b353caca1424")
        ]
        return urlComponents.url
    }
}
