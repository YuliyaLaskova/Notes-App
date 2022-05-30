//
//  Worker.swift
//  Notes App
//
//  Created by Yuliya Laskova on 16.05.2022.
//

import Foundation

protocol WorkerType {
    func fetchNotes(completion: @escaping ([NoteDataModel]) -> Void)
}

class Worker: WorkerType {
    func fetchNotes(completion: @escaping ([NoteDataModel]) -> Void) {
        NetManager.shared.fetchNotes(completion: completion)
    }
}
