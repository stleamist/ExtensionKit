import MapKit

public extension MKMapView {
    // mapViewDidFinishLoadingMap() 대신 사용 가능한 알림
    static let didFinishInitialRenderNotification = Notification.Name("MKMapViewDidFinishInitialRenderNotification")
    
    func setUserTrackingModeWhenRendered(_ mode: MKUserTrackingMode, animated: Bool) {
        self.setUserTrackingMode(mode, animated: animated)
        // TODO: 렌더링이 실행되지 않은 경우에만 옵저버를 추가하도록 분기하기
        NotificationCenter.default.addObserver(forName: MKMapView.didFinishInitialRenderNotification, object: self, queue: nil) { _ in
            self.setUserTrackingMode(mode, animated: animated)
        }
    }
}
