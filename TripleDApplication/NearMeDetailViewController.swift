//
//  NearMeDetailViewController.swift
//  TripleDApplication
//
//  Created by Daniela Alvarez  on 4/27/18.
//  Copyright © 2018 Daniela Alvarez Ulloa. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NearMeDetailViewController: UIViewController, MKMapViewDelegate {

    //MARK: - variables
    var rowNum: Int?
    var myRestaurantModel = [RestaurantModel]()
    var saveLoc: String?
    
    //MARK: - outlets
    @IBOutlet weak var nearNameLabel: UILabel!
    @IBOutlet weak var nearDescripLabel: UILabel!
    @IBOutlet weak var nearLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let actualRow = rowNum, let actualModel: [RestaurantModel] = myRestaurantModel {
            nearNameLabel.text = actualModel[actualRow].name
            nearDescripLabel.text = actualModel[actualRow].descrip
            nearLocationLabel.text = actualModel[actualRow].coordinates
            
            let addressSTring = getAddressFromLatLon(lat: actualModel[actualRow].longitude, long: actualModel[actualRow].latitude) {
                (addressString) in
                self.nearLocationLabel.text = addressString
                self.saveLoc = addressString
            }
            
            //adding pin to map
            //Link to source: https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.009, 0.009)
            let restLocation = CLLocationCoordinate2D(latitude: actualModel[actualRow].longitude, longitude: actualModel[actualRow].latitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(restLocation, span)
            mapView.setRegion(region, animated: true)
            
            //adding annotation
            //Link to source: https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
            let pin = PinAnnotation(title: actualModel[actualRow].name, coordinate: restLocation)
            mapView.addAnnotation(pin)
            mapView.delegate = self
            
        }
        
        
    }//end of view did load

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: getAddress function
    func getAddressFromLatLon(lat: Double, long: Double, completionHandler: ((String?)->())? = nil) {
        var location = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        var addressString = ""
        
        geocoder.reverseGeocodeLocation(location) {
            (placemarks, error) in
            if let error = error {
                print(error)
                
            } else if let placemark = placemarks?[0] {
                addressString = addressString + ((placemark.subThoroughfare == nil) ? "(MISSING)" : (placemark.subThoroughfare! + " "))
                addressString = addressString + ((placemark.thoroughfare == nil) ? "(MISSING)" : (placemark.thoroughfare! + ", "))
                addressString = addressString + ((placemark.locality == nil) ? "(MISSING)" : placemark.locality! + ", ")
                addressString = addressString + ((placemark.thoroughfare == nil) ? "(MISSING)" : (placemark.subAdministrativeArea! + ", "))
                addressString = addressString + ((placemark.thoroughfare == nil) ? "(MISSING)" : (placemark.postalCode! + ", "))
                addressString = addressString + ((placemark.thoroughfare == nil) ? "(MISSING)" : (placemark.country! + " "))
                print(addressString)
                
            }
            else{
                print("No Data")
            }
            if completionHandler != nil {
                completionHandler?(addressString)
            }
        }
    }

    //MARK: Adds call out bubble to pin
    //Link to source: https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PinAnnotation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    //MARK: redirects to Map application
    //Link to source: https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! PinAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
