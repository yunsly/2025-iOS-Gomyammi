//
//  CellIdentifier.swift
//  Gomyammi
//
//  Created by yunsly on 4/21/25.
//

import SwiftUI

struct CellIdentifier: Identifiable {
    let id = UUID()
    let gridIndex: Int
    let cellIndex: Int
    
}
