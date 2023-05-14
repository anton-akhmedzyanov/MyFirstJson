//
//  MainCollectionViewController.swift
//  Json
//
//  Created by Anton Akhmedzyanov on 14.05.2023.
//

import UIKit

enum UserAction: CaseIterable {
    case showImage
    case fetchCourse
    case fetchCourses
    case aboutSwiftBook
    case aboutSwiftBook2
    case showCourses
    case postRQSTDict
    case postRQSTModel
    
    var title: String {
        switch self {
            
        case .showImage:
            return "showImage"
        case .fetchCourse:
            return "fetchCourse"
        case .fetchCourses:
            return "fetchCourses"
        case .aboutSwiftBook:
            return "aboutSwiftBook"
        case .aboutSwiftBook2:
            return "aboutSwiftBook2"
        case .showCourses:
            return "showCourses"
        case .postRQSTDict:
            return "postRQSTDict"
        case .postRQSTModel:
            return "postRQSTModel"
        }
    }
}

final class MainCollectionViewController: UICollectionViewController {

    private let userActions = UserAction.allCases
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let userAC = cell as? UserActionCell else { return UICollectionViewCell()}
        userAC.userActionLabel.text = userActions[indexPath.item].title
        return cell
    }

    //MARK: -UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userActions = userActions[indexPath.item]
        switch userActions{
            
        case .showImage: performSegue(withIdentifier: "showView", sender: nil)
        case .fetchCourse: fetchCourse()
        case .fetchCourses: fetchCourses()
        case .aboutSwiftBook: fetchInfoAboutUs()
        case .aboutSwiftBook2: fetchInfoAboutUsWithEmptyFields()
        case .showCourses: performSegue(withIdentifier: "showTable", sender: nil)
        case .postRQSTDict: postRQSTDict()
        case .postRQSTModel: postRQSTModel()
        }
    }
    
    // MARK: - Private Funcs
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
    
    private func fetchCourse() {
        URLSession.shared.dataTask(with: Link.courseURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            do {
                let course = try decoder.decode(Course.self, from: data)
                print(course)
                self?.showAlert(with: "Success", and: "You can see the result in the console")
            } catch {
                print(error.localizedDescription)
                self?.showAlert(with: "Error", and: "You cannot see the result in the console")
            }
        }.resume()
    }
    private func fetchCourses() {
        URLSession.shared.dataTask(with: Link.coursesURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            do {
                let courses = try decoder.decode([Course].self, from: data)
                print(courses)
                self?.showAlert(with: "Success", and: "You can see the result in the console")
            } catch {
                print(error.localizedDescription)
                self?.showAlert(with: "Error", and: "You cannot see the result in the console")
            }
        }.resume()
    }
    private func fetchInfoAboutUs() {
        URLSession.shared.dataTask(with: Link.aboutUsURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let infoSW = try decoder.decode(Website.self, from: data)
                print(infoSW)
                self?.showAlert(with: "Success", and: "You can see the result in the console")
            } catch {
                print(error.localizedDescription)
                self?.showAlert(with: "Error", and: "You cannot see the result in the console")
            }
        }.resume()
        
    }
    private func fetchInfoAboutUsWithEmptyFields() {
        URLSession.shared.dataTask(with: Link.aboutUsURL2.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let infoSW2 = try decoder.decode(Website.self, from: data)
                print(infoSW2)
                self?.showAlert(with: "Success", and: "You can see the result in the console")
            } catch {
                print(error.localizedDescription)
                self?.showAlert(with: "Error", and: "You cannot see the result in the console")
            }
        }.resume()
        
    }
    private func postRQSTDict() {
        
    }
    private func postRQSTModel() {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

