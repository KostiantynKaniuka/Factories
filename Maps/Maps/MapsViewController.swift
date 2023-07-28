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
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.652832, longitude: 139.839478)
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

private func configureView(_ annotationView: MKAnnotationView?) {
    let snapShotSize = CGSize(width: 200, height: 200)
    let snapShotView = UIView(frame: CGRect.zero)
    snapShotView.translatesAutoresizingMaskIntoConstraints = false
    snapShotView.widthAnchor.constraint(equalToConstant: snapShotSize.width).isActive = true
    snapShotView.heightAnchor.constraint(equalToConstant: snapShotSize.height).isActive = true
    
    let options = MKMapSnapshotter.Options()
    options.size = snapShotSize
    options.mapType = .satelliteFlyover
    options.camera = MKMapCamera(lookingAtCenter: (annotationView?.annotation?.coordinate)!, fromDistance: 10, pitch: 65, heading: 0)
    let snapShotter = MKMapSnapshotter(options: options)
    snapShotter.start { (snapshot, error) in
        if let error = error {
            print(error.localizedDescription)
        }
        if let snapshot = snapshot {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: snapShotSize.width, height: snapShotSize.height))
            imageView.image = snapshot.image
            snapShotView.addSubview(imageView)
        }
    }
    annotationView?.detailCalloutAccessoryView = snapShotView
    
}

extension MapsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var bakayaroAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "BakayaroAnnotationView") as? MKMarkerAnnotationView
        if bakayaroAnnotationView == nil {
            bakayaroAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CoffeAnnotationView")
            bakayaroAnnotationView?.glyphText = "🤣"
            bakayaroAnnotationView?.markerTintColor = UIColor.cyan
            bakayaroAnnotationView?.glyphImage = UIImage(named: "guts")
            bakayaroAnnotationView?.canShowCallout = true
        } else {
            bakayaroAnnotationView?.annotation = annotation
        }
//        if let bakayaroAnnotation = annotation as? BakayaroAnnotation {
//            bakayaroAnnotationView?.image = UIImage(named: bakayaroAnnotation.imageUrl)
//        }
        configureView(bakayaroAnnotationView)
        return bakayaroAnnotationView
    }
}
