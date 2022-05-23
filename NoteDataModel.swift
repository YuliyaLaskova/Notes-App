//
//  NoteModel.swift
//  Notes App
//
//  Created by Yuliya Laskova on 09.04.2022.
//

import UIKit

struct NoteDataModel: Codable {

    let noteTitle: String?
    let noteText: String?
    let noteDate: String?
    var index: IndexPath?

    var isNoteEmpty: Bool {
        noteTitle == "" && noteText == ""
    }

    mutating func update(index: IndexPath?) -> NoteDataModel {
        self.index = index
        return self
    }
}

struct Note: Decodable {
    let header: String?
    let text: String?
    let date: Int?

    var dataModel: NoteDataModel {
        NoteDataModel(
            noteTitle: header,
            noteText: text,
            noteDate: DateTimeManager.formatDate(
                date: date == nil ? Date() : Date(timeIntervalSince1970: TimeInterval(date!))))
    }
}
