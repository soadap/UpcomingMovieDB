//
//  DetailVC.swift
//  UpcomingMovieDB
//
//  Created by soadap on 4/14/19.
//  Copyright © 2019 soadap. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var movie : Movie = Movie(title: "", poster_path: "", vote_average: 0, original_language: "", overview: "", release_date: "")
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterBackgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding swype down gesture to dismiss view
        let swype = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        swype.direction = .down
        view.addGestureRecognizer(swype)
    }
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //updating view with movie info
        api.fetchImage(url: URL(string: "\(BASE_IMAGE_URL)\(movie.poster_path)")!) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.posterBackgroundImage.image = image
            }
        }
        titleLabel.text = movie.title.uppercased()
        langLabel.text = movie.original_language
        releaseDateLabel.text = movie.release_date
        ratingLabel.text = (movie.vote_average == 0) ? "No rating" : "\(movie.vote_average)"
        descriptionLabel.text = movie.overview
    }

}
