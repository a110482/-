//
//  TableTags.swift
//  荷包君
//
//  Created by elijah tam on 2019/2/12.
//  Copyright © 2019 elijah tam. All rights reserved.
//

import Foundation
import SQLite

// tag
class Tags: Tables{
    private let tags = Table("tags")
    private let id = Expression<Int64>("id")
    private let title = Expression<String>("title")
    private let color_data = Expression<String>("color_data")
    private let db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    // protocol
    func build() {
        do{
            let _ = try db.scalar(tags.exists)
        }
        catch{
            try! db.run(tags.create{ t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(color_data)
            })
        }
    }
}

// MARK: - 資料格式擴充
extension Tags{
    /// 儲存色彩格式
    private struct ColorData:Codable {
        private var r: CGFloat
        private var g: CGFloat
        private var b: CGFloat
        private var aph: CGFloat
        var json_string:String?{return self.get_json_string()}
        
        init(r: CGFloat = 0, g: CGFloat = 0, b:CGFloat = 0, aph:CGFloat = 0) {
            self.r = r
            self.g = g
            self.b = b
            self.aph = aph
        }
        init(color: UIColor){
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var aph:CGFloat = 0
            color.getRed(&r, green: &g, blue: &b, alpha: &aph)
            self.init(r: r, g: g, b: b, aph: aph)
        }
        /// 用json資料產生物件
        init? (json_string: String){
            let data = json_string.data(using: String.Encoding.utf8)
            let decoder = JSONDecoder()
            if let obj = try? decoder.decode(ColorData.self, from: data!){
                self.init(r: obj.r, g: obj.g, b: obj.b, aph: obj.aph)
            }
            return nil
        }
        /// 自身數值轉換回色彩
        func get_color()->UIColor{
            return UIColor(displayP3Red: self.r, green: self.g, blue: self.b, alpha: self.aph)
        }
        
        /// 取得json字串
        private func get_json_string()->String?{
            let encoder = JSONEncoder()
            let data = try! encoder.encode(self)
            return String(data: data, encoding: String.Encoding.utf8)
        }
    }
}


// MARK: - API
extension Tags{
    /// 建立新的TAG
    func create_new_tag(title:String, color:UIColor){
        let json_string = ColorData(color: color).json_string!
        let insert = tags.insert(
            self.title <- title,
            color_data <- json_string
            )
        do{
            try self.db.run(insert)
        }
        catch{
            AlterCenter.singleton.push_alert(
                message: NSLocalizedString("database create error", comment: ""))
        }
    }
    /// 取得所有TAG
    func tag_list()->Array<(title:String, color:UIColor)>{
        var res:Array<(title:String, color:UIColor)> = []
        do{
            for tag in try db.prepare(tags){
                let color_data:ColorData = ColorData(json_string:tag[self.color_data])!
                res.append((title: tag[self.title], color: color_data.get_color()))
            }
        }catch{
            
        }
        return res
    }
}


