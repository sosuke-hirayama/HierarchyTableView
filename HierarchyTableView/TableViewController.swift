//
//  TableViewController.swift
//  HierarchyTableView
//
//  Created by Sosuke Hirayama on 2017/08/23.
//  Copyright © 2017年 Sosuke Hirayama. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {

    let list = JSON(parseJSON: "{\"ドウブツ\":{\"ライオン\":[\"インドライオン\",\"バーバリーライオン\",\"ゼネガルライオン\"],\"ブタ\":[\"ランドレース\",\"ヨークシャー\"],\"ゾウ\":[]},\"ショクブツ\":{\"アオイ\":[\"オクラ\",\"イチビ\"],\"カエデ\":[],\"タコノキ\":[],\"ナス\":[\"センリョウナス\",\"バッテンナス\",\"オオナガナス\"]},\"サカナ\":{\"マグロ\":[\"インドマグロ\",\"カジキマグロ\"],\"カツオ\":[\"ホシガツオ\",\"ソウダガツオ\",\"ハツガツオ\"],\"ブリ\":[],\"カレイ\":[\"アサバガレイ\"]}}")
    
    var path : [JSONSubscriptType] = []
    var target: JSON = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()

        target = self.list[path]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return target.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if target.dictionaryValue.count != 0 {
            cell.textLabel?.text = Array(target.dictionaryValue.keys)[indexPath.row]
        } else {
            cell.textLabel?.text = target.arrayValue[indexPath.row].stringValue
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if target.dictionaryValue.count == 0 {
            return
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        var newPath: [JSONSubscriptType] = []
        newPath += self.path
        newPath += [Array(target.dictionaryValue.keys)[indexPath.row]]
        vc.path = newPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
