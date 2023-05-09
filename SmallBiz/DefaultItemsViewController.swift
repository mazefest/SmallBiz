//
//  DefaultItemsViewController.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/8/23.
//

import UIKit

class DefaultItemsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newDefaultTaskTextField: UITextField!
    @IBOutlet weak var addNewDefaultTaskButton: UIButton!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
            top: 30.0,
            left: 20.0,
            bottom: 30.0,
            right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Default Items"
        collectionView.dataSource = self
        collectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAddNewTaskButtonTapped(_ sender: Any) {
        guard let title = newDefaultTaskTextField.text,
              !title.isEmpty else {
            return
        }
        
        let newDefaultTask = Task(title: title)
        DefaultTaskController.shared.addDefaultTask(task: newDefaultTask)
        newDefaultTaskTextField.text = nil
        collectionView.reloadData()
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

extension DefaultItemsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DefaultTaskController.shared.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = DefaultTaskController.shared.tasks[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallBizUitl.defaultItemCellIdentifier, for: indexPath) as? DefaultItemsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.defaultLabel.text = item.title
        return cell
    }
}

extension DefaultItemsViewController: UICollectionViewDelegate {
    
}

extension DefaultItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width - (sectionInsets.left * (itemsPerRow + 1))
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
