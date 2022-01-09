//
//  SearchViewController.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 08/07/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchMovieCollectionView: UICollectionView!
   
    private var searchModel:SearchModel = SearchModelImplementation.shared
    private let searchBar = UISearchBar()
    
    var pageCurrent:Int?
      
    var totalPage:Int?
    
    private var returnFromServer:PopularSeries?
    
    private var dataToAppend:[Series] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createSearchBar()
        setDataSourceAndDelegate()
        registerCells()
        searchBar.delegate = self
        
        getMovieList(page: 1, query: "Batman")
    }
    
    private func createSearchBar(){
       
        searchBar.placeholder = "Search Series Name Here"
        searchBar.tintColor = .black
        searchBar.searchTextField.textColor = .white
    
        navigationItem.titleView = searchBar
     
    }
    
    private func setDataSourceAndDelegate(){
        searchMovieCollectionView.delegate = self
        searchMovieCollectionView.dataSource = self
    }
    
    private func registerCells() {
        searchMovieCollectionView.registerCollectionViewCells(identifier: FeatureAnime_CollectionViewCell.identifier)
    }
    
    private func getMovieList(page:Int,query:String){
        searchModel.fetchMovieListForUserSearch(page: page, query: query) { data in
            switch data
            {
            case.success(let data):
                self.returnFromServer = data
                self.pageCurrent = data.page ?? 1
                self.totalPage = data.totalPages ?? 1
                
                self.dataToAppend.append(contentsOf: data.results ?? [])
                self.searchMovieCollectionView.reloadData()
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
           
        }

    }
    
    private func detectSpace(data:String?)->String{
        var variabeB = ""
        if let data = data{
            
            let variableA =  data.map { char -> String in
                var returnChar:String = ""
                if char.isWhitespace{
                    let value = "+"
                    returnChar = value
                } else if char.isPunctuation{
                    let value = "'"
                    returnChar = value
                }
                else{
                    returnChar.append(char)
                }
                return returnChar
            }
            debugPrint(variableA)
            
            for items in variableA{
                variabeB.append(items)
            }
    }
        debugPrint(variabeB)
        return variabeB
    
 }
}

extension SearchViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        if let data = searchBar.text{
            self.dataToAppend.removeAll()
            let valueReceive  = detectSpace(data: data)
            getMovieList(page: pageCurrent ?? 1, query: valueReceive)
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
}

extension SearchViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRow = indexPath.row == (dataToAppend.count-1)
        let hasMorePages = pageCurrent ?? 0 < totalPage ?? 0
        if lastRow && hasMorePages{
            pageCurrent = (pageCurrent ?? 0) + 1
            if let data = searchBar.text
            {
                let dataGet = detectSpace(data: data)
                getMovieList(page: pageCurrent ?? 1, query: dataGet)
                
            }
            
          
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataToAppend.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchMovieCollectionView.dequeReusableCells(identifier: FeatureAnime_CollectionViewCell.identifier, indexPath: indexPath) as? FeatureAnime_CollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.data = dataToAppend[indexPath.row].convertToResultObject()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 340)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        forSeriesNavigateToDetailViewController(idToBind: dataToAppend[indexPath.row].id ?? 0, from: self)
    }
}
