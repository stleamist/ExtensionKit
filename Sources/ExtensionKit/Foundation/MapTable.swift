import Foundation

open class MapTable<KeyType: AnyObject, ObjectType: AnyObject> {
    let mapTable: NSMapTable<KeyType, ObjectType>
    
    required public init(keyOptions: NSPointerFunctions.Options, valueOptions: NSPointerFunctions.Options) {
        self.mapTable = NSMapTable(keyOptions: keyOptions, valueOptions: valueOptions)
    }
    
    open subscript(key: KeyType) -> ObjectType? {
        get {
            return mapTable.object(forKey: key)
        }
        
        set {
            if let newValue = newValue {
                mapTable.setObject(newValue, forKey: key)
            } else {
                mapTable.removeObject(forKey: key)
            }
        }
    }
    
    open var keys: [KeyType] {
        return self.mapTable.keyEnumerator().allObjects as! [KeyType] // swiftlint:disable:this force_cast
    }
    
    open var values: [ObjectType] {
        return self.mapTable.objectEnumerator()?.allObjects as! [ObjectType]  // swiftlint:disable:this force_cast
    }
    
    open class func strongToStrongObjects() -> MapTable<KeyType, ObjectType> {
        return self.init(keyOptions: .strongMemory, valueOptions: .strongMemory)
    }
    
    open class func weakToStrongObjects() -> MapTable<KeyType, ObjectType> {
        return self.init(keyOptions: .weakMemory, valueOptions: .strongMemory)
    }
    
    open class func strongToWeakObjects() -> MapTable<KeyType, ObjectType> {
        return self.init(keyOptions: .strongMemory, valueOptions: .weakMemory)
    }
    
    open class func weakToWeakObjects() -> MapTable<KeyType, ObjectType> {
        return self.init(keyOptions: .weakMemory, valueOptions: .weakMemory)
    }
}
