//
//  IconSelectInputView.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/24.
//

import UIKit
import SnapKit

class IconSelectInputViewCollectionViewCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            titleLabel.text = title ?? ""
        }
    }
    
    private lazy var titleLabel: UILabel = lazyTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func lazyTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .f_b_(26)
        return label
    }
}

class IconSelectInputView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    open var didSelectEmojiWithComplete:((_ emoji: String) -> Void)?
    
    private lazy var segmentControl: UISegmentedControl = lazySegmentControl()
    private lazy var collectionView: UICollectionView = lazyCollectionView()
    
    private var dataList: [String]!
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        backgroundColor = .white
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.6
        
        processingData()
        placeSubViews()
    }
    
    
    
    private func processingData() {
        dataList = []
        let emoji = "😀😁🤣😂😄😅😆😇😉😊🙂🙃☺️😋😌😍😘😙😜😝🤓😎🤗🤡🤠😏😶😑😒🙄🤔😳😞😟😠😡😔😕☹️😣😖😫😤😮😱😨😰😯😦😢😥😪😓🤤😭😲🤥🤢🤧🤐😷🤒🤕😴💤💩😈👹👺💀👻👽🤖👏👋👍👎👊🤞🤝✌️👌✋💪🙏☝️👆👇👈👉🖐🤘✍️💅👄👅👂👃👁👀🗣👶👦👧👩👱👴👵👲👳👮👷💂👨‍⚕️‍👨‍🌾‍👨‍🍳‍👩‍🎓‍👩‍🎤👩‍🏫‍👨‍💻‍👨‍💼👨‍🔧‍👨‍🔬‍‍👩‍🎨‍👨‍🚒‍👨‍✈️‍👨‍🚀‍👩‍⚖️‍🕵🎅👼👸🤴👰🤵🚶🏃💃👯👫👬👭🤰🤷‍♀️🤦‍♀️🙇💁🙅🙋💇💆💑💏👪👨‍👩‍👧‍👦👕👖👔👗👙👘💄💋👣👠👡👢👞👟👒🎩⛑🎓👑🎒👝👛👜💼👓🕶💍🌂😃😗😚😛🙁😩😐😧😵😬👿😺😸😹😻😼😽🙀😿😾👐🙌✊🤛🤜🤚🖖🤙🖕🤳👤👥👨👱‍♀️👳‍♀️👮‍♀️👷‍♀️💂‍♀️🕵️‍♀️🕵️👩‍⚕️👨‍⚕️👩‍🌾👨‍🌾👩‍🍳👨‍🍳👩‍🎓👨‍🎓👨‍🎤👩‍🏫👨‍🏫👩‍🏭👨‍🏭👩‍💻👨‍💻👩‍💼👩‍🔧👨‍🔧👩‍🔬👨‍🔬👩‍🎨👨‍🎨👩‍🚒👨‍🚒👩‍✈️👨‍✈️👩‍🚀👨‍🚀👩‍⚖️👨‍⚖️🤶🙇‍♀️💁‍♂️🙅‍♂️🙆🙆‍♂️🙋‍♂️🤦‍♂️🤷‍♂️🙎🙎‍♂️🙍🙍‍♂️💇‍♂️💆‍♂️🕺👯‍♂️🚶‍♀️🏃‍♀️👩‍❤️‍👩👨‍❤️‍👨👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👨‍👩‍👧👨‍👩‍👦‍👦👨‍👩‍👧‍👧👩‍👩‍👦👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👩‍👦👩‍👧👩‍👧‍👦👩‍👦‍👦👩‍👧‍👧👨‍👦👨‍👧👨‍👧‍👦👨‍👦‍👦👨‍👧‍👧👚🤪🤨🧐🤩🤬🤯🤭🤫🤮🤲🤟🧠🧒🧑👱‍♂️🧔🧓👳‍♂️🧕👮‍♂️👷‍♂️💂‍♂️🕵️‍♂️🧙‍♀️🧙‍♂️🧝‍♀️🧝‍♂️🧛‍♀️🧛‍♂️🧟‍♀️🧟‍♂️🧞‍♀️🧞‍♂️🧜‍♀️🧜‍♂️🧚‍♀️🧚‍♂️🤱🙇‍♂️💁‍♀️🙅‍♀️🙆‍♀️🙋‍♀️🙎‍♀️🙍‍♀️💇‍♀️💆‍♀️🧖‍♀️🧖‍♂️👯‍♀️🚶‍♂️🏃‍♂️🧥🧦🧤🧣🧢🥰🥳🥺🥵🥶🥴🦶🦵🦷👩‍🦱👨‍🦱👩‍🦰👨‍🦰👩‍🦳👨‍🦳👩‍🦲👨‍🦲🦸‍♀️🦸‍♂️🦹‍♀️🦹‍♂️🧶🧵🥼🥿🥾🧳🥽🥱🤏🦾🦿🦻🧑‍🦱🧑‍🦰👱🧑‍🦳🧑‍🦲👳👮👷💂🕵️🧑‍⚕️🧑‍🌾🧑‍🍳🧑‍🎓🧑‍🎤🧑‍🏫🧑‍🏭🧑‍💻🧑‍💼🧑‍🔧🧑‍🔬🧑‍🎨🧑‍🚒🧑‍✈️🧑‍🚀🧑‍⚖️🦸🦹🧙🧝🧛🧟🧞🧜🧚🙇💁🙅🙆🙋🧏‍♀️🧏🧏‍♂️🤦🤷🙎🙍💇💆🧖👯👩‍🦽🧑‍🦽👨‍🦽👩‍🦼🧑‍🦼👨‍🦼🚶👩‍🦯🧑‍🦯👨‍🦯🧎‍♀️🧎🧎‍♂️🏃🧍‍♀️🧍🧍‍♂️👩‍❤️‍👨👩‍❤️‍💋‍👨👨‍👩‍👦🦺🩲🩳🥻🩱🥲🥸🤌🫀🫁🫂👰‍♀️👰‍♂️🤵‍♀️🤵‍♂️🥷🧑‍🎄👩‍🍼🧑‍🍼👨‍🍼🪢🪡🩴🪖🐶🐱🐭🐹🐰🐻🐼🐨🐯🦁🐮🐷🐽🐸🐙🐵🙈🙉🙊🐒🐔🐧🐦🐤🐣🐥🦆🦅🦉🦇🐺🐗🐴🦄🐝🐛🦋🐌🐞🐜"
        for item in emoji {
            dataList.append(String(item))
        }
    }
    
    private func placeSubViews() {
        addSubview(segmentControl)
        addSubview(collectionView)
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: IconSelectInputViewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IconSelectInputViewCollectionViewCell
        cell.title = dataList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectEmojiWithComplete?(dataList[indexPath.item])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy
    private func lazySegmentControl() -> UISegmentedControl {
        let control = UISegmentedControl(items: ["emoji", "图标"])
        control.selectedSegmentIndex = 0
        return control
    }
    
    private func lazyCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (kScreenWidth-30)/8, height: (kScreenWidth-30)/8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(IconSelectInputViewCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }
}
