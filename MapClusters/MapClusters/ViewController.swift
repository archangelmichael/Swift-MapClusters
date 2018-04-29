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
    var annotations: [MKAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.annotations = MapHelper.getRandomDotAnnotationsForLocation(location: self.vMap.region.center)
        self.vMap.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadAnnotations()
    }

    func mapView(_ mapView: MKMapView,
                 regionDidChangeAnimated animated: Bool) {
        self.reloadAnnotations()
    }
    
    func reloadAnnotations() {
        self.view.isUserInteractionEnabled = false
        let oldAnnotations = self.vMap.annotations
        var annotationsToRemove : [MKAnnotation] = []
        for annotation in oldAnnotations {
            if !self.vMap.contains(coordinate: annotation.coordinate) {
                annotationsToRemove.append(annotation)
            }
        }
        
        self.vMap.removeAnnotations(annotationsToRemove)
        
        let newAnnotations = self.annotations.filter { (annotation) -> Bool in
            !oldAnnotations.contains(where: { (oldAnnotation) -> Bool in
                return oldAnnotation.coordinate.latitude == annotation.coordinate.latitude &&
                    oldAnnotation.coordinate.longitude == annotation.coordinate.longitude
            })
        }
        
        var annotationsToAdd : [MKAnnotation] = []
        for annotation in newAnnotations {
            if self.vMap.contains(coordinate: annotation.coordinate) {
                annotationsToAdd.append(annotation)
            }
        }
        
        self.vMap.addAnnotations(annotationsToAdd)
        self.view.isUserInteractionEnabled = true
    }
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let dot = annotation as? DotAnnotation {
            if let dotView = mapView.dequeueReusableAnnotationView(withIdentifier: DotView.ID) as? DotView {
                dotView.annotation = dot
                return dotView
            }
            else {
                let dotView = DotView(annotation: dot,
                                      reuseIdentifier: DotView.ID)
                dotView.image = DotView.DotImage
                dotView.clusteringIdentifier = DotView.ClusterID
                dotView.canShowCallout = true
                return dotView
            }
        }
        else if let cluster = annotation as? MKClusterAnnotation {
            let clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: DotView.ClusterID)
                ?? MKAnnotationView(annotation: annotation,
                                    reuseIdentifier: DotView.ClusterID)
            
            clusterView.annotation = cluster
            clusterView.image = DotView.ClusterImage
            
            return clusterView
        }
        else {
            return nil
        }
    }
}

