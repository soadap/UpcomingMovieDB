//
//  MainVC.swift
//  UpcomingMovieDB
//
//  Created by soadap on 4/14/19.
//  Copyright © 2019 soadap. All rights reserved.
//

import UIKit

let api = API(baseURL: BASE_API_URL, parameters: API_KEY)

class MainVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var movies: [Movie] = []
    let queue = DispatchQueue(label: "Main Queue")

    override func viewDidLoad() {
            super.viewDidLoad()
            api.get { (movies) in
                self.movies = movies
                self.queue.async {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //passing movie data to detailVC
        if segue.identifier == DETAILED_SEGUE {
            let detailVC = segue.destination as? DetailVC
            let indexPath = self.collectionView.indexPathsForSelectedItems!.first
            let selectedMovie = movies[indexPath!.row]
            detailVC?.movie = selectedMovie
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //segue to detailvc
        performSegue(withIdentifier: DETAILED_SEGUE, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //updating cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title.uppercased()
        
        api.fetchImage(url: URL(string: "\(BASE_IMAGE_URL)\(movie.poster_path)")!) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.posterImage.image = image
            }
        }
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //collectionview cosmetics
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
