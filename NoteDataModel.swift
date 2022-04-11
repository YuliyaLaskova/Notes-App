//
//  NoteModel.swift
//  Notes App
//
//  Created by Yuliya Laskova on 09.04.2022.
//

import UIKit

struct NoteDataModel: Codable {

    let noteTitle: String
    let noteText: String
    let noteDate: String?

    var isNoteEmpty: Bool {
        noteTitle == "" && noteText == ""
    }
}
