//
//  DateTimeManager.swift
//  Notes App
//
//  Created by Yuliya Laskova on 23.05.2022.
//

import Foundation

class DateTimeManager {
    class func formatDate(date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd.MM.YYYY EEEE HH:mm"
        return formatter.string(from: date)
    }
}
