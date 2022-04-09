//
//  NoteModel.swift
//  Notes App
//
//  Created by Yuliya Laskova on 09.04.2022.
//

import UIKit

class NoteDataModel {

    let noteTitle: String = ""
    let noteText: String = ""
    let noteDate: String? = nil

        var isNoteEmpty: Bool {
            noteTitle == "" && noteText == ""
        }
    }
