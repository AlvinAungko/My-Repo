//
//  BestActorTableViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 03/02/2021.
//

import UIKit

class BestActorTableViewCell: UITableViewCell,ActorActionDelegate {
    
    var sendThisObjectTonewVC:PopularPeople!
    
    var objectToPassTonewVC:PopularPeople?{
        didSet{
            if let data = objectToPassTonewVC{
                self.sendThisObjectTonewVC = data
            }
        }
    }
    private var network = MovieNetworkAgent.shared
    
     var delegate:MovieItemDelegate?=nil
    
    func onTap(isHidden: Bool) {
        debugPrint("Favorite is \(isHidden)")
    }
    
    var dataReceivedFromVC:PopularPeople?{
        didSet{
            if let _ = dataReceivedFromVC{
                self.BestActorsCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var BestActorsCollectionView: UICollectionView!
    @IBOutlet weak var lbl_MoreActors: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_MoreActors.addUnderline(text: "More Actors")
        BestActorsCollectionView.registerCollectionViewCells(identifier: bestPlayersAnimeCollectionViewCell.identifier)
        BestActorsCollectionView.dataSource = self
        BestActorsCollectionView.delegate = self
        
        getPopularpeopleList()
        onTapLabel()
        
      
    }
    
    private func onTapLabel(){
        let tapgestureRecog = UITapGestureRecognizer(target: self, action: #selector(itemIsTabbed))
       
        lbl_MoreActors.addGestureRecognizer(tapgestureRecog)
        lbl_MoreActors.isUserInteractionEnabled = true
    }
    
     
     @objc func itemIsTabbed(){
        delegate?.onTapMoreActors(object: sendThisObjectTonewVC)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func getPopularpeopleList(){
        network.getPopularPeople { data in
            switch data
            {
            case.success(let data): self.objectToPassTonewVC = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
        }

    }
    
}
extension BestActorTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idKey = dataReceivedFromVC?.results?[indexPath.row].id ?? 0
        
        
        delegate?.onTapPopularPeople(idToBind: idKey)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataReceivedFromVC?.results?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = BestActorsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: bestPlayersAnimeCollectionViewCell.self), for: indexPath) as? bestPlayersAnimeCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.data = dataReceivedFromVC?.results?[indexPath.row]
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: BestActorsCollectionView.frame.width/2.2, height: CGFloat(240))
    }
}
