//
//  ViewController.swift
//  diff
//
//  Created by MyachinGarpix on 10.03.2023.
//

import UIKit

struct CellModel: Hashable{
    var id: Int
    var isChecked: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    static func == (lhs: CellModel, rhs: CellModel) -> Bool {
        return lhs.id == rhs.id
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    lazy var dataSource = {
        return UITableViewDiffableDataSource<Int, CellModel>(tableView: table) { [ unowned self]
            (tableView: UITableView, indexPath: IndexPath, itemIdentifier: CellModel) -> UITableViewCell? in
            let cell = self.table.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

            cell.textLabel?.text = "\(itemIdentifier.id)"
            if !cell.isSelected{
                cell.accessoryType = itemIdentifier.isChecked ? .checkmark : .none
            }
            return cell
        }
    }()
    
    lazy var cellModel = [
        CellModel(id: 1),
        CellModel(id: 2),
        CellModel(id: 3),
        CellModel(id: 4),
        CellModel(id: 5),
        CellModel(id: 6),
        CellModel(id: 7),
        CellModel(id: 8),
        CellModel(id: 9),
        CellModel(id: 10),
        CellModel(id: 11),
        CellModel(id: 12),
        CellModel(id: 13),
        CellModel(id: 14),
        CellModel(id: 15),
        CellModel(id: 16),
        CellModel(id: 17),
        CellModel(id: 18),
        CellModel(id: 19),
        CellModel(id: 20),
        CellModel(id: 21),
        CellModel(id: 22),
        CellModel(id: 23),
        CellModel(id: 24),
        CellModel(id: 25),
        CellModel(id: 26),
        CellModel(id: 27),
        CellModel(id: 28),
        CellModel(id: 29),
        CellModel(id: 30),
    ]
    
    lazy var table: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(shuffleTapped))
        navigationItem.title = "Task 4"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        table.delegate = self
        table.dataSource = dataSource
        table.frame = view.bounds
    
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(cellModel, toSection: 0)
        dataSource.apply(snapshot)
        
        view.addSubview(table)
    }

    @objc func shuffleTapped(){
        cellModel.shuffle()
        
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(cellModel)
        snapshot.reconfigureItems(cellModel)
        dataSource.apply(snapshot)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        cellModel[indexPath.item].isChecked.toggle()
        

        if cellModel[indexPath.item].isChecked {
            let element = cellModel.remove(at: indexPath.item)
            cellModel.insert(element, at: 0)
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        var snapshot = dataSource.snapshot()
        snapshot.appendItems(cellModel)
        snapshot.reconfigureItems(cellModel)
        dataSource.apply(snapshot)
    }
}
