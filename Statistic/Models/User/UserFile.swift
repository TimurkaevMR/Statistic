//
//  UserFile.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import Foundation
import RealmSwift

final class UserFile: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var url: String
    @Persisted var type: String
    
    enum CodingKeys: String, CodingKey {
        case id, url, type
    }
    
    convenience init(id: Int,
                     url: String,
                     type: String) {
        self.init()
        self.id = id
        self.url = url
        self.type = type
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let url = try container.decode(String.self, forKey: .url)
        let type = try container.decode(String.self, forKey: .type)
        self.init(id: id, url: url, type: type)
    }
}
