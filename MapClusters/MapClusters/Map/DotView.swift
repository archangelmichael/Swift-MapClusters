//
//  DotView.swift
//  MapClusters
//
//  Created by Radi Shikerov on 29.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import MapKit

class DotView: MKAnnotationView {

    public static let ID: String = "DotAnnotationID"
    public static let ClusterID: String = "DotAnnotationClusterID"
    
    public var defaultimage: UIImage? {
        get {
            return UIImage(named: "dot")
        }
    }
}
