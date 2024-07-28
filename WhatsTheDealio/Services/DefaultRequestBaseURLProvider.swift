//
//  DefaultRequestBaseURLProvider.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import Networking

struct DefaultRequestBaseURLProvider: RequestBaseURLProvider {
    let baseURL = URL(string: "https://fritzammon.com")!
}
