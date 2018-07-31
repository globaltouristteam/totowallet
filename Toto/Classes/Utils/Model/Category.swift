//
//  Category.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation

class Category: JsonObject {
    
    var catId: String?
    var des: String?
    var hits: String?
    var images: String?
    var isHomepage: String?
    var isMenu: String?
    var keyword: String?
    var name: String?
    var nameSmall: String?
    var ordering: String?
    var parentId: String?
    var published: String?
    var slug: String?
    var tags: String?
    
    var tours: [Tour] = []
    var isPopular: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case catId = "cat_id"
        case des = "des"
        case hits = "hits"
        case images = "images"
        case isHomepage = "is_homepage"
        case isMenu = "is_menu"
        case keyword = "keyword"
        case name = "name"
        case nameSmall = "name_small"
        case ordering = "ordering"
        case parentId = "parent_id"
        case published = "published"
        case slug = "slug"
        case tags = "tags"
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        catId = try values.decodeIfPresent(String.self, forKey: .catId)
        des = try values.decodeIfPresent(String.self, forKey: .des)
        hits = try values.decodeIfPresent(String.self, forKey: .hits)
        images = try values.decodeIfPresent(String.self, forKey: .images)
        isHomepage = try values.decodeIfPresent(String.self, forKey: .isHomepage)
        isMenu = try values.decodeIfPresent(String.self, forKey: .isMenu)
        keyword = try values.decodeIfPresent(String.self, forKey: .keyword)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        nameSmall = try values.decodeIfPresent(String.self, forKey: .nameSmall)
        ordering = try values.decodeIfPresent(String.self, forKey: .ordering)
        parentId = try values.decodeIfPresent(String.self, forKey: .parentId)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(catId, forKey: .catId)
        try container.encodeIfPresent(des, forKey: .des)
        try container.encodeIfPresent(hits, forKey: .hits)
        try container.encodeIfPresent(images, forKey: .images)
        try container.encodeIfPresent(isHomepage, forKey: .isHomepage)
        try container.encodeIfPresent(isMenu, forKey: .isMenu)
        try container.encodeIfPresent(keyword, forKey: .keyword)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(nameSmall, forKey: .nameSmall)
        try container.encodeIfPresent(ordering, forKey: .ordering)
        try container.encodeIfPresent(parentId, forKey: .parentId)
        try container.encodeIfPresent(published, forKey: .published)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(tags, forKey: .tags)
    }
    
}
