import MapKit

public extension MKMapView {
    
    var minimumZoomLevel: CGFloat { 3 }
    var maximumZoomLevel: CGFloat { 21.6 }
    
    var zoomLevel: CGFloat? { self.value(forKey: "_zoomLevel") as? CGFloat }
    
    private var longitudeDeltaAtRightAngle: CLLocationDegrees{
        let mapView = MKMapView(frame: self.frame)
        mapView.camera = MKMapCamera(lookingAtCenter: self.camera.centerCoordinate, fromDistance: self.camera.altitude, pitch: 0, heading: 0)
        return mapView.region.span.longitudeDelta
    }
    
    private func zoomLevel(from longitudeDelta: CLLocationDegrees) -> CGFloat {
        return log2(360 * self.frame.size.width / (128 * CGFloat(longitudeDelta)))
    }
    private func longitudeDelta(from zoomLevel: CGFloat) -> CLLocationDegrees {
        return CLLocationDistance(360 * self.frame.size.width / (128 * exp2(zoomLevel)))
    }
    
    var computedZoomLevel: CGFloat {
        get {
            return zoomLevel(from: longitudeDeltaAtRightAngle)
        }
        set {
            let clampedNewValue = min(max(minimumZoomLevel, newValue), maximumZoomLevel)
            let longitudeDeltaAtRightAngle = longitudeDelta(from: clampedNewValue)
            let longitudeDistanceAtRightAngle = CLLocation(latitude: centerCoordinate.latitude, longitude: longitudeDeltaAtRightAngle).distance(from: CLLocation(latitude: centerCoordinate.latitude, longitude: 0))
            
            let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 0, longitudinalMeters: longitudeDistanceAtRightAngle)
            
            let mapView = MKMapView(frame: self.bounds)
            mapView.region = region
            
            self.camera.altitude = mapView.camera.altitude
        }
    }
}
