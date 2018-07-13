//
//  Tour.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class Tour: JsonObject {
    
    var catId: String?
    var catSlug: AnyObject?
    var code: String?
    var diadanhId: String?
    var ghichugia: String?
    var giamgia: String?
    var hinhthuc: String?
    var hitBuy: String?
    var hits: String?
    var id: String?
    var idChude: String?
    var images: String?
    var ketthuc: String?
    var khoihanh: String?
    var khuyenmai: String?
    var lichkhoihanh: String?
    var lichtrinh: String?
    var mainId: AnyObject?
    var mainSlug: AnyObject?
    var ngaytao: String?
    var noibat: String?
    var price: String?
    var price2: String?
    var published: String?
    var rate: String?
    var slug: String?
    var songayId: String?
    var title: String?
    var titleSeo: String?
    var totalRate: String?
    var vanchuyen: String?
    
    enum CodingKeys: String, CodingKey {
        case catId = "cat_id"
        case catSlug = "cat_slug"
        case code = "code"
        case diadanhId = "diadanh_id"
        case ghichugia = "ghichugia"
        case giamgia = "giamgia"
        case hinhthuc = "hinhthuc"
        case hitBuy = "hit_buy"
        case hits = "hits"
        case id = "id"
        case idChude = "id_chude"
        case images = "images"
        case ketthuc = "ketthuc"
        case khoihanh = "khoihanh"
        case khuyenmai = "khuyenmai"
        case lichkhoihanh = "lichkhoihanh"
        case lichtrinh = "lichtrinh"
        case mainId = "main_id"
        case mainSlug = "main_slug"
        case ngaytao = "ngaytao"
        case noibat = "noibat"
        case price = "price"
        case price2 = "price2"
        case published = "published"
        case rate = "rate"
        case slug = "slug"
        case songayId = "songay_id"
        case title = "title"
        case titleSeo = "title_seo"
        case totalRate = "total_rate"
        case vanchuyen = "vanchuyen"
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        catId = try values.decodeIfPresent(String.self, forKey: .catId)
        //catSlug = try values.decodeIfPresent(AnyObject.self, forKey: .catSlug)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        diadanhId = try values.decodeIfPresent(String.self, forKey: .diadanhId)
        ghichugia = try values.decodeIfPresent(String.self, forKey: .ghichugia)
        giamgia = try values.decodeIfPresent(String.self, forKey: .giamgia)
        hinhthuc = try values.decodeIfPresent(String.self, forKey: .hinhthuc)
        hitBuy = try values.decodeIfPresent(String.self, forKey: .hitBuy)
        hits = try values.decodeIfPresent(String.self, forKey: .hits)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        idChude = try values.decodeIfPresent(String.self, forKey: .idChude)
        images = try values.decodeIfPresent(String.self, forKey: .images)
        ketthuc = try values.decodeIfPresent(String.self, forKey: .ketthuc)
        khoihanh = try values.decodeIfPresent(String.self, forKey: .khoihanh)
        khuyenmai = try values.decodeIfPresent(String.self, forKey: .khuyenmai)
        lichkhoihanh = try values.decodeIfPresent(String.self, forKey: .lichkhoihanh)
        lichtrinh = try values.decodeIfPresent(String.self, forKey: .lichtrinh)
        //mainId = try values.decodeIfPresent(AnyObject.self, forKey: .mainId)
        //mainSlug = try values.decodeIfPresent(AnyObject.self, forKey: .mainSlug)
        ngaytao = try values.decodeIfPresent(String.self, forKey: .ngaytao)
        noibat = try values.decodeIfPresent(String.self, forKey: .noibat)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        price2 = try values.decodeIfPresent(String.self, forKey: .price2)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        songayId = try values.decodeIfPresent(String.self, forKey: .songayId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        titleSeo = try values.decodeIfPresent(String.self, forKey: .titleSeo)
        totalRate = try values.decodeIfPresent(String.self, forKey: .totalRate)
        vanchuyen = try values.decodeIfPresent(String.self, forKey: .vanchuyen)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(catId, forKey: .catId)
        //try container.encodeIfPresent(catSlug, forKey: .catSlug)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(diadanhId, forKey: .diadanhId)
        try container.encodeIfPresent(ghichugia, forKey: .ghichugia)
        try container.encodeIfPresent(giamgia, forKey: .giamgia)
        try container.encodeIfPresent(hinhthuc, forKey: .hinhthuc)
        try container.encodeIfPresent(hitBuy, forKey: .hitBuy)
        try container.encodeIfPresent(hits, forKey: .hits)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(idChude, forKey: .idChude)
        try container.encodeIfPresent(images, forKey: .images)
        try container.encodeIfPresent(ketthuc, forKey: .ketthuc)
        try container.encodeIfPresent(khoihanh, forKey: .khoihanh)
        try container.encodeIfPresent(khuyenmai, forKey: .khuyenmai)
        try container.encodeIfPresent(lichkhoihanh, forKey: .lichkhoihanh)
        try container.encodeIfPresent(lichtrinh, forKey: .lichtrinh)
        //try container.encodeIfPresent(mainId, forKey: .mainId)
        //try container.encodeIfPresent(mainSlug, forKey: .mainSlug)
        try container.encodeIfPresent(ngaytao, forKey: .ngaytao)
        try container.encodeIfPresent(noibat, forKey: .noibat)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(price2, forKey: .price2)
        try container.encodeIfPresent(published, forKey: .published)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(songayId, forKey: .songayId)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(titleSeo, forKey: .titleSeo)
        try container.encodeIfPresent(totalRate, forKey: .totalRate)
        try container.encodeIfPresent(vanchuyen, forKey: .vanchuyen)
    }
    
}
