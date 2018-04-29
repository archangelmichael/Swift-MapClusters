//
//  ViewController.swift
//  MapClusters
//
//  Created by Radi Shikerov on 29.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var vMap: MKMapView!
    var annotations: [DotAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.annotations = MapHelper.getRandomDotAnnotationsForLocation(location: self.vMap.region.center)
        self.vMap.delegate = self
    }

    func mapView(_ mapView: MKMapView,
                 regionDidChangeAnimated animated: Bool) {
        self.reloadAnnotations()
    }
    
    func reloadAnnotations() {
//        self.vMap.removeAnnotations(self.vMap.annotations)
        let newAnnotations = MapHelper.getRandomDotAnnotationsForLocation(location: self.vMap.region.center)
        self.annotations.append(contentsOf: newAnnotations)
        self.vMap.addAnnotations(newAnnotations)
    }
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let dotView = mapView.dequeueReusableAnnotationView(withIdentifier: DotView.ID) as? DotView {
            dotView.annotation = annotation
            return dotView
        }
        else {
            let dotView = DotView(annotation: annotation,
                                  reuseIdentifier: DotView.ID)
            dotView.image = dotView.defaultimage
            return dotView
        }
    }
}

