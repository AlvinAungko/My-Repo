//
//  ShowCaseViewController.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 09/07/2021.
//

import UIKit

class ShowCaseViewController: UIViewController {

    @IBOutlet weak var showCaseCollectionView: UICollectionView!
    private var seriesModel = SeriesModelImplementation.shared
    private var dataBindForShowCase:PopularSeries?{
        didSet{
            if let _ = dataBindForShowCase{
              
                self.currentPage = dataBindForShowCase?.page ?? 0
                self.totalPage = dataBindForShowCase?.totalPages ?? 0
            }
        }
    }
    private var arrayListForSeries:[Series] = []
    
    private var currentPage:Int?
    private var totalPage:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDataSourceAndDelegate()
        registerCells()
       getSeries(page: 1)
      
    }
    
    private func getSeries(page:Int){
        seriesModel.getMoreSeries(page: page) {
            switch $0{
            case.success(let popularSeries):
                self.dataBindForShowCase = popularSeries
                self.arrayListForSeries.append(contentsOf: popularSeries.results ?? [])
                self.showCaseCollectionView.reloadData()
            case .failure(let errorMessage):
                debugPrint(errorMessage)
            }
            
        }

    }
    
    private func setDataSourceAndDelegate(){
        showCaseCollectionView.delegate = self
        showCaseCollectionView.dataSource = self
    }
    
    private func registerCells(){
        showCaseCollectionView.registerCollectionViewCells(identifier: ShowCaseCollectionViewCell.identifier)
    }
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShowCaseViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayListForSeries.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = showCaseCollectionView.dequeReusableCells(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath) as? ShowCaseCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.data = arrayListForSeries[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == (arrayListForSeries.count - 1)
        let hasMorePages = self.currentPage ?? 0 < self.totalPage ?? 0
        if isLastRow && hasMorePages {
            currentPage = (currentPage ?? 0) + 1
            getSeries(page: currentPage ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: showCaseCollectionView.bounds.width/2.2, height: 260)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        forSeriesNavigateToDetailViewController(idToBind: arrayListForSeries[indexPath.row].id ?? 0, from: self)
    }
}
