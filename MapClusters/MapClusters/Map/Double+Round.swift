//
//  Double+Round.swift
//  MapClusters
//
//  Created by Radi Shikerov on 29.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import MapKit

extension Double {
    func withPrecision(count: Double = 2) -> Double {
        let precision = 10 * count
        return (self * precision).rounded() / precision
    }
}

extension MKCoordinateRegion {
    /// confirms that a region contains a location
    func contains(_ coordinate: CLLocationCoordinate2D) -> Bool {
        let deltaLat = abs(self.center.latitude - coordinate.latitude)
        let deltalong = abs(self.center.longitude - coordinate.longitude)
        return self.span.latitudeDelta/2.0 >= deltaLat && self.span.longitudeDelta/2.0 >= deltalong
    }
}
