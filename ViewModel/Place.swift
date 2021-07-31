//
//  Place.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 7/30/21.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    
    var id = UUID().uuidString
    var place: CLPlacemark
}
