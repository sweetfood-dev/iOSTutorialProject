//
//  ViewController.swift
//  TableViewManagedCustom
//
//  Created by todoc on 2021/10/25.
//

import UIKit

// Custom 헤더뷰를 만들기 위한 클래스
class LibraryHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(LibraryHeaderView.self)"
    @IBOutlet var titleLabel: UILabel!
}

enum SortStyle {
    case title
    case author
    case readme
}

enum Section: String, CaseIterable {
    case addNew
    case readMe = "Read Me!"
    case finished = "Finished!"
}

class LibraryViewController: UITableViewController {
    
    @IBOutlet var sortButtons: [UIBarButtonItem]!
    
    @IBAction func sortByTitle(_ sender: UIBarButtonItem) {
        dataSource.update(sourtStyle: .title)
        updateTintColors(tappedButton: sender)
    }
    
    @IBAction func sortByAuthor(_ sender: UIBarButtonItem) {
        dataSource.update(sourtStyle: .author)
        updateTintColors(tappedButton: sender)
    }
    
    @IBAction func sortByReadMe(_ sender: UIBarButtonItem) {
        dataSource.update(sourtStyle: .readme)
        updateTintColors(tappedButton: sender)
    }
    
    func updateTintColors(tappedButton: UIBarButtonItem) {
        sortButtons.forEach { button in
            button.tintColor = button == tappedButton
            ? button.customView?.tintColor
            : .secondaryLabel
        }
    }
    var dataSource: LibraryDataSource!
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        // tableView.indexPathForSelectedRow : 테이블뷰에서 선택한 행과 섹션을 식별하는 IndexPath
        guard let indexPath = tableView.indexPathForSelectedRow,
              let book = dataSource.itemIdentifier(for: indexPath)
        else { fatalError()}
        return DetailViewController(coder: coder, book: book)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        tableView.register(UINib(nibName: "\(LibraryHeaderView.self)", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: LibraryHeaderView.reuseIdentifier)
        
        configureDataSource()
        dataSource.update(sourtStyle: .readme)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.update(sourtStyle: dataSource.currentSortStyle)
    }
}


// MARK: - TableView Delegate
extension LibraryViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("1")
        if section == 0 { return nil }
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LibraryHeaderView.reuseIdentifier) as? LibraryHeaderView else {
            print("headerView is nil")
            return nil
        }
        headerView.titleLabel.text = Section.allCases[section].rawValue
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section != 0 ? 60 : 0
    }
    
}
// MARK: - TableView Data source
extension LibraryViewController {
    
    /// 테이블 뷰 섹션의 헤더 title에 대한 데이터 소스 요청
    /// - Parameters:
    ///   - tableView: title 을 묻는 테이블 뷰
    ///   - section: tableview의 섹션을 식별하는 인덱스 번호
    /// - Returns: 해당 섹션의 헤더 title로 사용할 문자열. nil일 경우 title은 없음
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Read Me!" : nil
    }
    
    func configureDataSource() {
        dataSource = LibraryDataSource(tableView: tableView) {
            tableView, indexPath, book -> UITableViewCell? in
            if indexPath == IndexPath(row: 0, section: 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
            else { fatalError("Could not creatre BookCell") }
            
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookThumbnail.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
            cell.bookThumbnail.layer.cornerRadius = 12
            if let review = book.review {
                cell.reviewLabel.text = review
                cell.reviewLabel.isHidden = false
            }
            cell.readMeBookMark.isHidden = !book.readMe
            return cell
        }
        
    }
}


class LibraryDataSource: UITableViewDiffableDataSource<Section, Book> {
    var currentSortStyle: SortStyle = .title
    
    func update(sourtStyle: SortStyle, animatingDifferences: Bool = true ) {
        currentSortStyle = sourtStyle
        
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Book>()
        newSnapshot.appendSections(Section.allCases)
        newSnapshot.appendItems(Library.books, toSection: .readMe)
        let booksByReadme: [Bool: [Book]] = Dictionary(grouping: Library.books, by: \.readMe)
        for (readMe, books) in booksByReadme {
            var sortedBooks: [Book]
            switch sourtStyle {
            case .title:
                sortedBooks = books.sorted{ $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
            case .author:
                sortedBooks = books.sorted{ $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedAscending }
            case .readme:
                sortedBooks = books
            }
            newSnapshot.appendItems(sortedBooks, toSection: readMe ? .readMe : .finished)
        }
        
        newSnapshot.appendItems([Book.mockBook], toSection: .addNew)
        apply(newSnapshot, animatingDifferences: animatingDifferences)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == . delete {
            guard let book = self.itemIdentifier(for: indexPath) else { return }
            Library.delete(book: book)
            update(sourtStyle: currentSortStyle)
        }
    }
    
    /// 지정된 행(row)이 테이블 뷰의 다른 위치로 이동할 수 있는지 여부를 결정
    /// - Parameters:
    ///   - tableView: 이 메소드를 호출한 테이블 뷰
    ///   - indexPath: 움직일 수 있는 여부를 알고 싶은 행의 indexPath
    /// - Returns: 이동할 수 있으면 true, 그렇지 않으면 false
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section != snapshot().indexOfSection(.readMe)
            && currentSortStyle == .readme { return false }
        else {
            return true
        }
    }
    
    /// 테이블 뷰의 특정 위치에 있는 행(row)를 다른 위치로 이동하도록 데이터 소스에 전달
    /// - Parameters:
    ///   - tableView: 이 메소드를 호출한 테이블 뷰
    ///   - sourceIndexPath: 이동할 행의 IndexPath
    ///   - destinationIndexPath: 이동 도착지의 IndexPath
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath,
              sourceIndexPath.section == destinationIndexPath.section,
              let bookToMove = itemIdentifier(for: sourceIndexPath),
              let bookAtDestination = itemIdentifier(for: destinationIndexPath)
        else {
            apply(snapshot(), animatingDifferences: false)
            return
        }
        Library.reorderBooks(bookToMove: bookToMove, bookAtDestination: bookAtDestination)
        update(sourtStyle: currentSortStyle, animatingDifferences: false)
    }
}
