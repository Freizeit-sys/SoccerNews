//
//  FeedsController.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/16.
//

import UIKit
import AMScrollingNavbar

class FeedsController: UIViewController {
    
    // dummyData
//    var articles: [Article] = [
//        Article(source: Optional(Source(id: nil, name: Optional("Livedoor.com"), url: nil)), author: nil, content: Optional("17DF20221231\r\n3620062011260\r\n20111782011122012132015121\r\n201920202\r\nhttps://twitter.com/saopaulofc/status/1372176490230657028"), description: Optional("サンパウロは17日、ブラジル代表DFミランダと2022年12月31日までの契約を結んだことを発表した。現在36歳のミランダは、コリチーバの下部組織出身。2006年夏から2011年夏にかけてもサンパウロでプレーしており、サンパウロでは公式戦通算260試合に出場している。ミランダは2011年夏にアトレティコ・マドリードへと完全移籍。同クラブで公式戦通算178試合に出場し、2011－12シーズンのヨーロッパリーグ優勝や2012－13シーズンのリーガ・エスパニョーラ優勝などに大きく貢献した。 全文SOCCER KING …"), publishedAt: Optional("2021-03-17T14:22:21Z"), title: Optional("江蘇足球退団のDFミランダ、サンパウロ復帰が決定！　アトレティコやインテルでもプレー"), url: Optional("https://news.livedoor.com/article/detail/19866823/"), urlToImage: Optional("https://image.news.livedoor.com/newsimage/stf/b/c/bc93a_854_33cbacf9_6e5030ac.jpg")),
//
//        Article(source: Optional(Source(id: nil, name: Optional("Livedoor.com"), url: nil)), author: nil, content: nil, description: Optional("ヨーロッパリーグ決勝トーナメント2回戦マンチェスター・U戦を控えるミランは343、4選手が欠場となるようだ。イタリアメディア『フットボールイタリア』が伝えている。ミランは18日にヨーロッパリーグ（EL）セカンドレグ、マンチェスター・U戦を控えている。ファーストレグは敵地で1－1に終わり、アウェイゴールを持ち帰りセカンドレグに有利なポジションで臨む。同クラブは、ELに向けて行ったトレーニングの様子を掲載。先日負傷していたアルジェリア代表MFイスマエル・ベナセルが 全文SOCCER KING 03月18日00時11分"), publishedAt: Optional("2021-03-17T15:11:21Z"), title: Optional("ELマンU戦に臨むミラン、4選手がトレーニング不参加で欠場濃厚か"), url: Optional("https://news.livedoor.com/article/detail/19866901/"), urlToImage: Optional("https://image.news.livedoor.com/newsimage/stf/2/4/24503_854_2fae5d14_42fa9db6.jpg")),
//
//        Article(source: Optional(Source(id: nil, name: Optional("Livedoor.com"), url: nil)), author: nil, content: Optional("18MF\r\n20236301\r\n91512302\r\n311998320112015154\r\nGEschmiedet zum Profi - und ab Sommer wieder zu Hause 🔵⚒️⚪️\r\nDanny #Latza kehrt zur kommenden Spielzeit zu seinem Heimatverein zurück. Alle Infos zum Tr… [+126 chars]"), description: Optional("シャルケは18日、マインツに所属するドイツ人MFダニー・ラッツァが来シーズンから加入することを発表した。ラッツァは今季限りでマインツとの契約が満了を迎えるため、シャルケにはフリートランスファーで加入することになる。ラッツァとシャルケは、2023年6月30日までの契約を結ぶことになり、「ディビジョンに関係なくシャルケが昇格満了を迎えるため、シャルケにはフリートランスファーで加入することになる。ラッツァとシャルケは、2023年6月30日までの契約を結ぶことになり、「ディビジョンに関係なくシャルケが昇格343した場合」に発動する1年の延長オプションも付帯している。シャルケは今季のブンデスリーガで苦戦。残り9試合で残留圏の15位ビーレフェルトと 全文SOCCER KING 03月17日23時54分"), publishedAt: Optional("2021-03-17T14:54:03Z"), title: Optional("シャルケ、マインツMFラッツァの来季加入を発表…“昇格時”の契約延長OPも付帯"), url: Optional("https://news.livedoor.com/article/detail/19866846/"), urlToImage: Optional("https://image.news.livedoor.com/newsimage/stf/5/1/51dd5_854_7123c592_c97aeb7b.jpg")),
//
//        Article(source: Optional(Source(id: nil, name: Optional("Goo.ne.jp"), url: nil)), author: nil, content: Optional("(SOCCER DIGEST Web) 0317 21:30"), description: Optional("東京五輪・パラリンピックの開閉会式の企画、演出で全体の統括役を務めるクリエーティブディレクターの佐々木宏氏（６６）が、式典に出演予定だったタレントの渡辺直美さん..."), publishedAt: Optional("2021-03-17T15:49:07Z"), title: Optional("五輪演出の佐々木宏氏　辞意表明"), url: Optional("https://news.goo.ne.jp/topstories/sports/1000/4f723b42c6f4cbf6c529786cfb2f3b09.html?fr=RSS"), urlToImage: Optional("https://img.news.goo.ne.jp/image_proxy/compress/q_80/img/sns/news.png")),
//
//        Article(source: Optional(Source(id: nil, name: Optional("Livedoor.com"), url: nil)), author: nil, content: nil, description: Optional("横浜F・マリノスが3連勝で3月のリーグ戦を締めくくった。明治安田生命J1リーグ第5節、前田大然の虎の子の1点を守り抜き、徳島ヴォルティスに完封勝利。アンジェ ポステコグルー監督は「選手たちが約束事を守り、ハードワークして掴んだ結果だ」とチームを称賛した。前田はこれで4試合連続ゴール。得点ランキング単独トップとなる6得点を記録しており、早くも昨季超えを果たした。今週は日本代表、U-24日本代表のメンバー発表が予定されており、絶好調の前田がどちらに名を連ねるか 全文SOCCER KING 03月17日22時55分"), publishedAt: Optional("2021-03-17T13:55:49Z"), title: Optional("A代表か、五輪代表か…4戦連発の前田大然「入ることができたらそこで頑張ります！」"), url: Optional("https://news.livedoor.com/article/detail/19866798/"), urlToImage: Optional("https://image.news.livedoor.com/newsimage/stf/7/c/7c914_854_4e63a510_58fd1a48.jpg"))
//    ]
    
    private var isFinishedPaging = false
    private var page = 0
    
    private var articles: [Article] = [];
    private let headerId = "headerId"
    private let topFeedCellId = "topFeedCellId"
    private let cellId = "cellId"
    private let v = FeedsView()
    
    override func loadView() {
        self.view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Soccer News"
        
        self.setupTableView()
        
        // Fetch news data
        self.paginateFeeds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(v.tableView, delay: 0.0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    
    private func paginateFeeds() {
        if page < 1 {
            v.showSpinner()
        }
        
        page += 1
        
        let request = EverythingRequest(q: "", sources: [], domains: ["soccer-king.jp"], from: nil, to: nil, language: .JP, sortBy: .PublishedAt, page: page, pageSize: 4)
        NewsRepository.shared.fetchEverything(request) { (articles) in
            self.articles += articles
            
            // 10
            if self.page >= 1 {
                self.isFinishedPaging = true
            }
            
            DispatchQueue.main.async {
                self.v.hideSpinner()
                self.v.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        v.tableView.register(TopFeedHeaderView.self, forHeaderFooterViewReuseIdentifier: headerId)
        v.tableView.register(TopFeedCell.self, forCellReuseIdentifier: topFeedCellId)
        v.tableView.register(FeedCell.self, forCellReuseIdentifier: cellId)
        v.tableView.delegate = self
        v.tableView.dataSource = self
    }
    
    private func showFeedDetailViewController(_ feed: Article) {
        let feedDetailVC = FeedDetailController()
        feedDetailVC.feed = feed
        navigationController?.pushViewController(feedDetailVC, animated: true)
    }
}

extension FeedsController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFeed = articles[indexPath.row]
        self.showFeedDetailViewController(selectedFeed)
        
        print(selectedFeed)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! TopFeedHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // show you how to fire off the paginate cell
        if indexPath.row == articles.count - 1 && !isFinishedPaging {
            self.paginateFeeds()
        }
        
        if indexPath.row == 0 {
            // top feed cell
            let cell = tableView.dequeueReusableCell(withIdentifier: topFeedCellId, for: indexPath) as! TopFeedCell
            cell.article = articles[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            // feed cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FeedCell
            cell.article = articles[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // top feed cell height
            let dummyCell = TopFeedCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.article = articles[indexPath.row]
            dummyCell.layoutIfNeeded()
            let targetSize = CGSize(width: view.frame.width, height: 1000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            return estimatedSize.height//400
        } else {
            // feed cell height
            return 134
        }
    }
}
