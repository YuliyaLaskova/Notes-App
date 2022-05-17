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
    let session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func fetchNotes(completion: @escaping ([NoteDataModel]) -> Void) {
        let task = session.dataTask(with: createURLRequest()) { data, response, error in
            guard let data = data else { return }
            do {
                let responses = try JSONDecoder().decode([Note].self, from: data)
                for response in responses {
                    var notes = [NoteDataModel]()
                    let note = NoteDataModel(
                        noteTitle: response.header,
                        noteText: response.text,
                        noteDate: self.formatDate(date: Date())
                    )
                    notes.append(note)
                    DispatchQueue.main.async {
                        completion(notes)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    private func createURLRequest() -> URLRequest {
        var request = URLRequest(url: createURLComponents()!)
        request.httpMethod = "GET"
        return request
    }

    private func createURLComponents() -> URL? {
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

struct Note: Decodable {
    var header: String?
    var text: String?
    var date: Int?
}

extension Worker {
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd.MM.YYYY EEEE HH:mm"
        return formatter.string(from: date)
    }
}
