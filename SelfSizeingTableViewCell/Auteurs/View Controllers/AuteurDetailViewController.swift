/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class AuteurDetailViewController: UIViewController {
  var selectedAuteur: Auteur?
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 300
    title = selectedAuteur?.name
    self.tableView.contentInsetAdjustmentBehavior = .never
  }
}

extension AuteurDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    selectedAuteur?.films.count ?? 0
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "FilmCell", for: indexPath)

    if
      let cell = cell as? FilmTableViewCell,
      let film = selectedAuteur?.films[indexPath.row] {
      cell.configure(
        title: film.title,
        plot: film.plot,
        isExpanded: film.isExpanded,
        poster: film.poster)
    }

    return cell
  }
}

extension AuteurDetailViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    // 1 : 선택한 indexPath에 있는 셀에 대한 참조를 tableView에 요청하고 해당하는 film을 가져옴
    guard let cell = tableView.cellForRow(at: indexPath) as? FilmTableViewCell,
          var film = selectedAuteur?.films[indexPath.row]
    else {
      return
    }
    
    // 2 : Film 객체의 isExpanded를 토글하고 배열에 업데이트. Film은 값 타입의 구조체이기 때문에.
    film.isExpanded.toggle()
    selectedAuteur?.films[indexPath.row] = film
    // 3 : 테이블 뷰에 업데이트 시작을 알림
    // film.isExpanded의 새 값으로 셀을 재구성하고 테이블 뷰에 업데이트가 완료 되었음을 알림. 셀의 변경사항이 적용됨
    tableView.beginUpdates()
    cell.configure(
      title: film.title,
      plot: film.plot,
      isExpanded: film.isExpanded,
      poster: film.poster)
    tableView.endUpdates()
    
    // 4 : 선택한 행으로 스크롤 되도록 테이블 뷰에 요청
    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    
    
  }
}
