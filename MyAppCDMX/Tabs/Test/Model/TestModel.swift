//
//  TestModel.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 08/08/24.
//

import Foundation
import UIKit

struct modelGrid {
    let id: Int
    let icon: String
    let color: UIColor
    let title: String
    let description: String
    
    init(id: Int, icon: String, color: UIColor, title: String, description: String) {
        self.id = id
        self.icon = icon
        self.color = color
        self.title = title
        self.description = description
    }
}
