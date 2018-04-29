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

extension MKMapView {
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        return MKMapRectContainsPoint(self.visibleMapRect, MKMapPointForCoordinate(coordinate))
    }
}
