
import Foundation
import Realm
import RealmSwift

class WeatherModel: Object, Codable {
    dynamic var consolidatedWeather = List<ConsolidatedWeatherModel>()
    dynamic var sources = List<SourceModel>()
    @objc dynamic var parent: ParentModel?

    @objc dynamic var time: Date? = nil
    @objc dynamic var sunRise: Date? = nil
    @objc dynamic var sunSet: Date? = nil
    @objc dynamic var timezoneName: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var locationType: String = ""
    @objc dynamic var woeid = 0
    @objc dynamic var lattLong: String = ""
    @objc dynamic var timezone: String = ""

    override class func primaryKey() -> String? {
        return "woeid"
    }
}
