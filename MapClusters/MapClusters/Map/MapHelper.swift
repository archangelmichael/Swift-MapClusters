//
//  MapHelper.swift
//  MapClusters
//
//  Created by Radi Shikerov on 29.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import MapKit

class MapHelper: NSObject {

    static func getRandomDotAnnotationsForLocation(location : CLLocationCoordinate2D,
                                                   totalCount: Int = 100) -> [DotAnnotation] {
        var annotCount = 0
        var annotations : [DotAnnotation] = []
        //First we declare While to repeat adding Annotation
        while annotCount < totalCount {
            annotCount += 1
            let coordinate = self.generateRandomCoordinates(location: location)
            let annotation = DotAnnotation(coordinate: coordinate,
                                           title: "Dot \(annotCount)",
                subtitle: "\(coordinate.latitude.withPrecision()), \(coordinate.longitude.withPrecision())")
            annotations.append(annotation)
        }
        
        return annotations
    }
    
    static func generateRandomCoordinates(location: CLLocationCoordinate2D,
                                          min: UInt32 = 100,
                                          max: UInt32 = 1000000)-> CLLocationCoordinate2D {
        //Get the Current Location's longitude and latitude
        let currentLong = location.longitude
        let currentLat = location.latitude
        
        //1 KiloMeter = 0.00900900900901° So, 1 Meter = 0.00900900900901 / 1000
        let meterCord = 0.00900900900901 / 1000
        
        //Generate random Meters between the maximum and minimum Meters
        let randomMetersLatitude = UInt(arc4random_uniform(max) + min)
        let randomMetersLongitude = UInt(arc4random_uniform(max) + min)
        
        //then Generating Random numbers for different Methods
        let randomMultiplierLatitude = arc4random_uniform(2) == 1 ? 1.0 : -1.0
        let metersCordLatitude = randomMultiplierLatitude * meterCord * Double(randomMetersLatitude) / 1.5
        let randomMultiplierLongitude = arc4random_uniform(2) == 1 ? 1.0 : -1.0
        let metersCordLongitude = randomMultiplierLongitude * meterCord * Double(randomMetersLongitude)
        //Then we convert the distance in meters to coordinates by Multiplying number of meters with 1 Meter Coordinate
        return CLLocationCoordinate2D(latitude: currentLat + metersCordLatitude,
                                      longitude: currentLong + metersCordLongitude)
    }
    
    static func randomBetweenNumbers(firstNum: CGFloat,
                                     secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
        
    }
}
