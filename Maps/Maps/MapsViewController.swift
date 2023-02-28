//
//  ViewController.swift
//  Maps
//
//  Created by Kostiantyn Kaniuka on 25.02.2023.
//

import UIKit
import MapKit
import CoreLocation


class MapsViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setUpUserLocation()
        self.segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
    }

    @IBAction func addAnnotationButtonPressed() {
    let annotation = BakayaroAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.011635, longitude: 135.768036)
        annotation.title = "BAKAYARO"
        annotation.subtitle = "berserk"
        annotation.imageUrl = "guts"
        self.mapView.addAnnotation(annotation)
    }
    
    private func setUpUserLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    @objc func mapTypeChanged(segmentedControl: UISegmentedControl) {
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = .standard
        case 1:
            self.mapView.mapType = .satellite
        case 2:
            self.mapView.mapType = .hybrid
        default :
            self.mapView.mapType = .standard
        }
    }
}

extension MapsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var bakayaroAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "BakayaroAnnotationView")
        if bakayaroAnnotationView == nil {
            bakayaroAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CoffeAnnotationView")
            bakayaroAnnotationView?.canShowCallout = true
        } else {
            bakayaroAnnotationView?.annotation = annotation
        }
        if let bakayaroAnnotation = annotation as? BakayaroAnnotation {
            bakayaroAnnotationView?.image = UIImage(named: bakayaroAnnotation.imageUrl)
        }
        return bakayaroAnnotationView
    }
}
