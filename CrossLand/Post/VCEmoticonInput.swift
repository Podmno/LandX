//
//  VCEmoticonInput.swift
//  LandX
//
//  Created by Ki MNO on 2023/12/20.
//
//

/*
 
    Version 1.0
    表情符号输入初始功能
 
 */

import UIKit

let emoticonSet1 = [

    "(・∀・)",
    "(ﾟ∀ﾟ)",
    "(*ﾟ∀ﾟ*)",
    "(´∀`)",
    "(*´∀`)",
    "(〃∀〃)",
    "(//∇//)",
    "(ゝ∀･)",
    "ﾟ ∀ﾟ)ノ",
    "(ノﾟ∀ﾟ)ノ",
    "( へ ﾟ∀ﾟ)べ",
    "(*ﾟ∇ﾟ)",
    "(＾o＾)ﾉ",
    "ᕕ( ᐛ )ᕗ",
    "ε=ε=(ノ≧∇≦)ノ",
    "(`ヮ´)",
    "(`ゥ´ )",
    "↙(`ヮ´ )↗",
    "･ﾟ( ﾉヮ´ )",
    "(;´ヮ`)7",
    "=͟͟͞͞( 'ヮ' 三 'ヮ' =͟͟͞͞)",



]

let emoticonSet2 = [

    "σ`∀´)",
    "ﾟ∀ﾟ)σ",
    "(σﾟ∀ﾟ)σ",
    "(ﾟ∀。)",
    "( ﾟ∀。)7\"",
    "ᕕ( ﾟ∀。)ᕗ",
    "(`ヮ´ )σ`´Д`)∀´) ﾟ∀ﾟ)σ",

]

let emoticonSet3 = [

    "(·ω·)",
    "(・ω・)",
    "(｀･ω･)",
    "(｀・ω)",
    "(´・ω)",
    "(`・ω・´)",
    "(´・ω・`)",
    "(=・ω・=)",
    "(/ω＼)",
    "(^・ω・^)",
    "(*´ω`*)",
    "(ﾟωﾟ)",
    "( ﾟωﾟ)",
    "(oﾟωﾟo)",
    "(=ﾟωﾟ)=",
    "⊂( ﾟωﾟ)つ",
    "ฅ(^ω^ฅ)",
    "(´；ω；`)",
    "ヾ(´ωﾟ｀)",
    "（<ゝω・）☆",
    "(　↺ω↺)",
    "(ﾉ)`ω´(ヾ)",
    "( ›´ω`‹ )",
    "乁( ˙ ω˙乁)",
    "( *・ω・)✄╰ひ╯"

]

let emoticonSet4 = [
    "(^ω^)",
    "( ^ω^)",
    "(　^ω^)",
    "(　ˇωˇ)",
    "(ベ ˇωˇ)べ",
    "⁽ ^ᐜ^⁾",
    "⁽ ˆ꒳ˆ⁾",
    "⁽ ˇᐜˇ⁾",
    "(｡◕∀◕｡)",
    "(　ˇωˇ )◕∀◕｡)^ω^)"
]

let emoticonSet5 = [
    "(ﾟдﾟ)",
    "(;ﾟдﾟ)",
    "Σ( ﾟдﾟ)",
    "Σ(ﾟдﾟ;)",
    "(´ﾟДﾟ`)",
    "(´ﾟДﾟ`)？？？",
    "(σﾟдﾟ)σ",
    "(つд⊂)",
    "ﾟÅﾟ )",
    "(|||ﾟдﾟ)",
    "(　д )",
    "(((ﾟдﾟ)))",
    "(((　ﾟдﾟ)))",
    "(ﾟДﾟ≡ﾟДﾟ)",
    "(ﾟДﾟ≡ﾟдﾟ)!?",
    "Σ(っ °Д °;)っ",
    "(☉д⊙)"

]

let emoticonSet6 = [
    "(`д´)",
    "ヽ(`Д´)ﾉ",
    "m9( `д´)",
    "( `д´)9",
    "( `д´)σ",
    "(σﾟдﾟ)σ",
    "(#ﾟдﾟ)",
    "(╬ﾟдﾟ)",
    "( ｣ﾟДﾟ)｣＜",
    "(`・´)",
    "( ` ・´)",
    "( ᑭ`д´)ᓀ))д`)",
    "( ᑭ`д´)ᓀ))д´)ᑫ",
    "ᑭ`д´)ᓀ ∑ᑭ(`ヮ´ )ᑫ",
    "`ー´) `д´) `д´)"
]


let emoticonSet7 = [
    "(>д<)",
    "(´д`)",
    "( ´д`)",
    "(*´д`)",
    "(;´Д`)",
    "(/TДT)/",
    "(TдT)",
    "( TдT)",
    "(-д-)",
    "ﾟ(つд`ﾟ)",
    "･ﾟ( ﾉд`ﾟ)",
    "( ;`д´; )"
    
    
]

let emoticonSet8 = [
    "( ·_ゝ·)",
    "(・_ゝ・)",
    "(´_ゝ`)",
    "( ´_ゝ`)旦",
    "(´_っ`)",
    "( `_っ´)",
    "((;¬_¬)",
    "(´･_･`)",
    "(´ー`)",
    "(`ー´)",
    "(*ﾟーﾟ)",
    "(・ー・)",
    "←_←",
    "→_→",
    "(<_<)",
    "(>_>)",
    "( ・_ゝ・) ﾉд`ﾟ)´д`)´ﾟДﾟ`)",
    "摸摸( ´･･)ﾉ(._.`)"

]


let emoticonSet9 = [
    "|∀ﾟ)",
    "|∀`)",
    "|д`)",
    "|дﾟ)",
    "| ω・´)",
    "|ー`)",
    "|-`)"

]

let emoticonSet10 = [
    "(|||^ヮ^)",
    "(|||ˇヮˇ)"

]

let emoticonSet11 = [
    "⊂彡☆))д´)",
    "⊂彡☆))д`)",
    "⊂彡☆))∀`)",
    "(´∀((☆ミつ"
]

let emoticonSet12 = [
    "(ﾟ3ﾟ)",
    "(`ε´)",
    "(`ε´ )",
    "ヾ(´ε`ヾ)",
    "(`ε´ (つ*⊂)"
]


let emoticonSet13 = [
    "(￣∇￣)",
    "╮(￣▽￣)╭",
    "(￣3￣)",
    "(￣ε(#￣)",
    "(￣ｰ￣)",
    "(￣ . ￣)",
    "(￣皿￣)",
    "(￣艸￣)",
    "(￣︿￣)",
    "（￣へ￣）",
    "(￣︶￣)",
    "(〜￣△￣)〜",
    "Σ( ￣□￣||)",
    "(\"▔□▔)/",
    "(●￣(ｴ)￣●)"

]

let emoticonSet14 = [
    "( ´ρ`)",
    "σ( ᑒ )",
    "( ﾟπ。)",
    "ᐕ)⁾⁾",
    "(っ˘Д˘)ノ♪",
    "U•ェ•*U",
    "/( ◕‿‿◕ )\\",
    "¯\\_(ツ)_/¯",
    "┃電柱┃",
    "接☆龙☆大☆成☆功",
    "(笑)",
    "(汗)",
    "(泣)",
    "(苦笑)",
    "☎110"

]

let emoticonSet15 = [
"""
吁~~~~　　rnm，退钱！
　　　/　　　/
(　ﾟ 3ﾟ) `ー´) `д´) `д´)
""",
"""
　σ　σ
σ(　´ρ`)σ[F5]
　σ　σ
""",
"""
╭◜◝ ͡ ◜◝ JJ
(　　　　 `д´) 　“咩！”
╰◟д◞ ͜ ◟д◞
""",
"""
( `д´) 预备备！笑！
哈！哈！哈！哈！哈！哈！哈！哈！哈！
( `д´) `д´) `д´) `д´) `д´) `д´) `д´) `д´) `д´)好~~~~　　　再来一个！
""",
"""
　/)　/)
c(　╹^╹)
""",
"""
（\\_/）
(・_・)
/ 　>
""",
"""
　／l、
（°､ 。 ７
　l、 ~ヽ
　じしf_, )ノ
""",
"""
　／l、
（ﾟ∀ 。 ７
　l、 ~ヽ
　じしf_, )ノ
""",
"""
　　　　　／＞　　フ
　　　　　| 　_　 _ l
　 　　　／` ミ＿xノ
　　 　 /　　　 　 |
　　　 /　 ヽ　　 ﾉ
　 　 │　　|　|　|
　／￣|　　 |　|　|
　| (￣ヽ＿_ヽ_)__)
　＼二つ
""",
"""
　　　　　／＞　　フ
　　　　　| 　_　 _ l
　 　　　／` ミ＿xノ
　　 　 /　　　 　 |
　　　 /　 ヽ　　 ﾉ　　　　　╱|、
　 　 │　　|　|　|　　　　　(˚ˎ 。7
　／￣|　　 |　|　|　　　　　|、˜〵
　| (￣ヽ＿_ヽ_)__) 　　　　 じしˍ,)ノ
　＼二つ
"""

]

class VCEmoticonInput: UIViewController {
    
    @IBOutlet weak var coreCV: UICollectionView!
    let collectionView = VCEmoticonInputCollectionView()

    
    var actionUserInputEmoticon : (String) -> Void = { str in
        print("VCEmoticonInput >> \(str), No action provided.")
        
    }
    
    var actionUserCloseEmoticon: () -> Void = {
        print("VCEmoticonInput >> Close!")
    }
    
    var emoticonContentArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadEmoticonData()
        
        collectionView.actionOnSelectedEmoticon = { str in
            
            self.actionUserInputEmoticon(str)
            
            // 再次传递到顶层
            
            self.dismiss(animated: true)
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //self.yourtableview.register(UINib(nibName: "yourCellXIBname", bundle: Bundle.main), forCellReuseIdentifier: "YourCellReUseIdentifier")
        //coreCV.register(s, forCellWithReuseIdentifier: s)
        coreCV.dataSource = collectionView
        coreCV.delegate = collectionView
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5;
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
    
        
        coreCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "celldata")
        coreCV.collectionViewLayout = layout

    }

    /// 载入颜文字数据
    func loadEmoticonData() {
        
        emoticonContentArray.append(contentsOf: emoticonSet1)
        emoticonContentArray.append(contentsOf: emoticonSet2)
        emoticonContentArray.append(contentsOf: emoticonSet3)
        emoticonContentArray.append(contentsOf: emoticonSet4)
        emoticonContentArray.append(contentsOf: emoticonSet5)
        emoticonContentArray.append(contentsOf: emoticonSet6)
        emoticonContentArray.append(contentsOf: emoticonSet7)
        emoticonContentArray.append(contentsOf: emoticonSet8)
        emoticonContentArray.append(contentsOf: emoticonSet9)
        emoticonContentArray.append(contentsOf: emoticonSet10)
        emoticonContentArray.append(contentsOf: emoticonSet11)
        emoticonContentArray.append(contentsOf: emoticonSet12)
        emoticonContentArray.append(contentsOf: emoticonSet13)
        emoticonContentArray.append(contentsOf: emoticonSet14)
        emoticonContentArray.append(contentsOf: emoticonSet15)

        collectionView.emoticonsDisplayArray.append(contentsOf: emoticonContentArray)
        print("Total Emoticons Count : \(emoticonContentArray.count)")
    }
    

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        actionUserCloseEmoticon()
    }
    
    @IBAction func btnClickedClose(_ sender: Any) {
        self.dismiss(animated: true)
    }



}

class VCEmoticonInputCollectionView : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var emoticonsDisplayArray : [String] = []
    var emoticonsDisplayCellView: [UICollectionViewCell] = []
    
    /// Block: 用户选择了表情符号
    var actionOnSelectedEmoticon : (String) -> Void = {str in
        print("did selected : \(str)")
    }
    
    func loadAndSetEmoticons(array: [String]) {
        
        emoticonsDisplayArray.append(contentsOf: array)
        
            
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (emoticonsDisplayArray.count / 6 + 1 )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "celldata\(indexPath.row)#\(indexPath.section)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celldata\(indexPath.row)#\(indexPath.section)", for: indexPath)

        
        if (cell.contentView.subviews.count < 1 ) {
            let lb_id = indexPath.row + indexPath.section * 6
            
            // 防止溢出
            if (lb_id < emoticonsDisplayArray.count) {
                let lb = UILabel()
                lb.text = emoticonsDisplayArray[lb_id]
                lb.textAlignment = .center
                lb.frame = cell.contentView.frame
                cell.contentView.addSubview(lb)
            }
            
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 选择项目的事件
        
        let lb_id = indexPath.row + indexPath.section * 6
        if (lb_id >= emoticonsDisplayArray.count) {
            return
        }
        actionOnSelectedEmoticon(emoticonsDisplayArray[lb_id])
        
    }
    
    
    
}
