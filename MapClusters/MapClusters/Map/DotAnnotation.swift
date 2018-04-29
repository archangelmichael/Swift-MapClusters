//
//  DotAnnotation.swift
//  MapClusters
//
//  Created by Radi Shikerov on 29.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import MapKit

class DotAnnotation: MKPointAnnotation {
    
    init(coordinate: CLLocationCoordinate2D,
         title: String?,
         subtitle: String?)
    {
        super.init()
        self.coordinate = coordinate
        self.title = title ?? "Dot"
        self.subtitle = subtitle ?? "\(coordinate.latitude),\(coordinate.longitude)"
    }
}
