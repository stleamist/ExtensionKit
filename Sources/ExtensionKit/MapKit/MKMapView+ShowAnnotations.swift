import MapKit

public extension MKMapView {
    func showAnnotations(_ annotations: [MKAnnotation], edgePadding insets: UIEdgeInsets, animated: Bool) {
        let coordinates = annotations.map({ $0.coordinate })
        let mapRect = MKMapRect(thatFits: coordinates)
        
        self.setVisibleMapRect(mapRect, edgePadding: insets, animated: animated)
    }
}

public extension MKMapRect {
    init(thatFits coordinates: [CLLocationCoordinate2D]) {
        let nwCoordinate = coordinates.reduce(CLLocationCoordinate2D(latitude: .leastNormalMagnitude, longitude: .greatestFiniteMagnitude)) { (result, coordinate) -> CLLocationCoordinate2D in
            let latitude = max(result.latitude, coordinate.latitude)
            let longitude = min(result.longitude, coordinate.longitude)
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        let seCoordinate = coordinates.reduce(CLLocationCoordinate2D(latitude: .greatestFiniteMagnitude, longitude: .leastNormalMagnitude)) { (result, coordinate) -> CLLocationCoordinate2D in
            let latitude = min(result.latitude, coordinate.latitude)
            let longitude = max(result.longitude, coordinate.longitude)
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        let minPoint = MKMapPoint(nwCoordinate)
        let maxPoint = MKMapPoint(seCoordinate)
        
        let mapRectSize = MKMapSize(width: maxPoint.x - minPoint.x, height: maxPoint.y - minPoint.y)
        
        self.init(origin: minPoint, size: mapRectSize)
    }
}
