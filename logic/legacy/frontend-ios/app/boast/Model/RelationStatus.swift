
import Foundation

enum RelationStatus: String, Codable, CaseIterable {
    case REQUEST
    case FRIEND
    case BLOCK
    case NO_RELATION
}
