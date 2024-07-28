//
//  TabItem.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation

enum TabItem: Identifiable, CaseIterable {
    case deals
    case browse

    var id: TabItem { self }
}
