import Foundation
import WidgetKit

@objcMembers
@objc(NSCUtilsHelper)
public class NSCUtilsHelper: NSObject {
    
    public static func updateWidget(){
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }         
    }

}
