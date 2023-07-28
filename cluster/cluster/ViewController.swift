//
//  ViewController.swift
//  cluster
//
//  Created by Kostiantyn Kaniuka on 01.03.2023.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var annotations: [MKAnnotation] = []

       override func viewDidLoad() {
           super.viewDidLoad()

           // Set up the map view
           let initialLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
           let regionRadius: CLLocationDistance = 1000
           mapView = MKMapView(frame: view.bounds)
           mapView.delegate = self
           mapView.showsUserLocation = true
           mapView.userTrackingMode = .follow
           mapView.region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
           view.addSubview(mapView)

           // Add multiple annotations to the map view
           let coordinate1 = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
           let coordinate2 = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4198)
           let coordinate3 = CLLocationCoordinate2D(latitude: 37.7751, longitude: -122.4196)
           let annotation1 = MKPointAnnotation()
           annotation1.coordinate = coordinate1
           let annotation2 = MKPointAnnotation()
           annotation2.coordinate = coordinate2
           let annotation3 = MKPointAnnotation()
           annotation3.coordinate = coordinate3
           annotations = [annotation1, annotation2, annotation3]
           mapView.addAnnotations(annotations)
       }

       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           if let cluster = annotation as? MKClusterAnnotation {
               let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "ClusterView") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: cluster, reuseIdentifier: "ClusterView")
               annotationView.glyphImage = UIImage(named: "cluster")
               annotationView.markerTintColor = UIColor.blue
               annotationView.canShowCallout = true
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapClusterView))
               annotationView.addGestureRecognizer(tapGesture)
               return annotationView
           } else {
               let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
               annotationView.canShowCallout = true
               return annotationView
           }
       }

 
    @objc func didTapClusterView(sender: UITapGestureRecognizer) {
        if let clusterView = sender.view as? MKMarkerAnnotationView, let cluster = clusterView.annotation as? MKClusterAnnotation {
            let annotationsInsideCluster = cluster.memberAnnotations
            let randomAnnotation = annotationsInsideCluster.randomElement() as? MKPointAnnotation
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "example_image")
            let annotationView = MKAnnotationView(annotation: randomAnnotation, reuseIdentifier: nil)
            annotationView.frame = imageView.frame
            annotationView.addSubview(imageView)
            mapView.selectAnnotation(randomAnnotation!, animated: true)
        }
    }

}
