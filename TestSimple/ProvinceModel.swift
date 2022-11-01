//
//  ProvinceModel.swift
//  TestSimple
//
//  Created by lidongyang on 2022/6/12.
//

import Foundation

struct City: Codable {
    let id: String
    let name: String
}

struct Province: Codable {
    let id: String
    let name: String
//    let city: String
    var city: [City]
}

class ProvinceModel: Codable {

    var provinces: [Province]

    init() {
        let path = Bundle.main.path(forResource: "cities", ofType: "json")!
        let data = try! Data(contentsOf: URL.init(fileURLWithPath: path))
        let decoder = JSONDecoder()
        provinces = try! decoder.decode([Province].self, from: data)
    }

    func indexPath(provinceId: String, cityId: String) -> IndexPath? {
        guard let provinceIndex = provinces.firstIndex(where: { $0.id == provinceId }) else { return nil }
        return IndexPath(row: provinceIndex, section: 0)
    }

    func addASameCity(index: IndexPath) {
        let id_c = provinces[index.section].city[index.row].id
        let city = City(id: id_c, name: provinces[index.section].city[index.row].name)
        provinces[index.section].city.append(city)
    }

    func deleteTheCity(index: IndexPath) {
        provinces[index.section].city.remove(at: index.row)
    }
}
