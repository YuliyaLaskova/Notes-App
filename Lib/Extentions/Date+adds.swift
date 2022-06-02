//
//  Date+adds.swift
//  Notes App
//
//  Created by Yuliya Laskova on 02.06.2022.
//

import Foundation
extension Date {

    init(timeIntervalSince1970Optional: Int?) {
        guard let periodInSeconds = timeIntervalSince1970Optional else { self.init(); return }
        self.init(timeIntervalSince1970: TimeInterval(periodInSeconds))
    }
}
