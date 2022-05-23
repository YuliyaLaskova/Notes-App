//
//  Worker.swift
//  Notes App
//
//  Created by Yuliya Laskova on 16.05.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetchNotes(completion: @escaping ([NoteDataModel]) -> Void)
}

class Worker: WorkerType {
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
        urlComponents.path = "/v0/b/ios-test-ce687.appspot.com/o/Empty.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18")
        ]
        return urlComponents.url
    }
}
