//
//  ViewController.swift
//  kamoku
//
//  Created by MakotoKurauchi on 2016/09/07.
//  Copyright © 2016年 MakotoKurauchi All rights reserved.
//

import UIKit

let question = ["当座預金","受取手形","売掛金","前払金","立替金","他店商品券","未収金","仮払金","未収手数料","未収利息","未収家賃","未収地代","前払家賃","前払利息","前払保険料","前払地代","貸付金","現金","小口現金","売買目的有価証券","繰越商品","消耗品","備品","車両運搬具","建物","土地","当座借越","支払手形","買掛金","前受金","預り金","商品券","未払金","仮受金","未払家賃","未払利息","未払給料","未払地代","前受利息","前受手数料","前受家賃","前受地代","借入金","資本金","仕入","貸倒引当金繰入","支払家賃","支払利息","支払保険料","支払地代","雑損","有価証券評価損","有価証券売却損","固定資産売却損","手形売却損","給料","租税公課","貸倒損失","発送費","旅費交通費","消耗品費","水道光熱費","通信費","雑費","減価償却費","広告宣伝費","販売費","売上","貸倒引当金戻入","受取利息","受取手数料","受取家賃","受取地代","雑益","有価証券評価益","有価証券売却益","固定資産売却益","手形売却益","償却債権取立益","受取配当金","有価証券利息"]

let ansor = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5]

let kamoku = [ "","資産","負債","純資産","費用","収益"]

class ViewController: UIViewController {

    // クラスの初期化
    var qC = qCounter(num: question.count)
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelSuccessCounter: UILabel!
    @IBOutlet weak var labelCompleteCounter: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 問題の表示
        labelQuestion.text = question[qC.get()]
        // カウンターの表示
        labelSuccessCounter.text = qC.nowCownt()
        labelCompleteCounter.text = ""
        labelStatus.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnShisan(_ sender: AnyObject) {
        judgement(1)
    }

    @IBAction func btnFusai(_ sender: AnyObject) {
        judgement(2)
    }
    
    @IBAction func btnJyunshisan(_ sender: AnyObject) {
        judgement(3)
    }
    
    @IBAction func btnHiyou(_ sender: AnyObject) {
        judgement(4)
    }
    
    @IBAction func btnSyueki(_ sender: AnyObject) {
        judgement(5)
    }
    
    func judgement(_ answer:Int){
        if ansor[qC.get()] == answer { // 正解したかどうか
            if qC.next() == false { // 最後の問題だったら
                // 全問正解なので⭐️をつける
                labelCompleteCounter.text = labelCompleteCounter.text! + "⭐️"
                qC.reset() // リセットして最初から
                labelStatus.text = "全問正解！！"
            } else {
                labelStatus.text = "正解！"
            }
        }else{ // 不正解だったら
            labelStatus.text = question[qC.get()] + " は " + kamoku[ansor[qC.get()]] // 正解を表示
            qC.reset() //リセットして最初から
        }
        labelSuccessCounter.text = qC.nowCownt() // カウンターの表示
        labelQuestion.text = question[qC.get()] // 問題の表示
    }
}

// 問題の順番を管理するクラス
// 問題配列の添字に使用する
class qCounter {
    var counter = 0
    var qNum : [Int] = []
    
    // 初期化　シャッフルした配列を保存
    init( num : Int ){
        self.qNum = shuffle(0..<num)
    }
    
    // 現在の番号を返す
    func get() -> Int {
        return self.qNum[self.counter]
    }
    
    // 次の問題へ移る。最後だったらfalseを返す
    func next() -> Bool {
        self.counter += 1
        if self.counter < self.qNum.count  {
            return true
        } else {
            return false
        }
    }
    
    // カウンターをリセットして問題をシャッフルし直す
    func reset(){
        self.counter = 0
        self.qNum = shuffle(0..<self.qNum.count)
    }
    
    // 現在のカウント数と問題数の文字列を返す
    func nowCownt() -> String {
        return String(self.counter) + "/" + String(self.qNum.count)
    }
    
    // 配列をシャッフルする関数
    func shuffle<S: Sequence>(_ source: S) -> [S.Iterator.Element] {
        var copy = Array<S.Iterator.Element>(source)
        shuffleBang(&copy)
        return copy
    }
    func shuffleBang<T>(_ array: inout [T]) {
        var index = array.count
        while index > 1 {
            let newIndex = Int(arc4random_uniform(UInt32(index)))
            index -= 1
            if index != newIndex {
                swap(&array[index], &array[newIndex])
            }
        }
    }
}

