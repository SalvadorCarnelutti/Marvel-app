//
//  
//  EventsView.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import UIKit
import Alamofire

protocol EventsPresenterToViewProtocol: UIView {
    var presenter: EventsViewToPresenterProtocol? { get set }
    func loadView()
}

final class EventsView: UIView {
    // MARK: - Properties
    weak var presenter: EventsViewToPresenterProtocol?
    let session = Session(eventMonitors: [AlamofireLogger()])
    var items = [EventCellItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(EventTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            tableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - PresenterToViewProtocol
extension EventsView: EventsPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .white
        loadEvents()
        setupConstraints()
    }
    
    func loadEvents() {
        session.request("https://gateway.marvel.com/v1/public/events",
                        parameters: [
                            "apikey":"5b23e88d26cf56958f076f88be9fed9d",
                            "hash" : MD5(string: "1" + "b220d549848ca21eacd776e73db60e6deccfd95f" + "5b23e88d26cf56958f076f88be9fed9d"),
                            "ts" : "1",
                            "limit" : "25",
                            "orderBy" : "-startDate"
                        ]).validate(statusCode: 200...299)
            .responseDecodable(of: EventResponse.self) { [weak self] (response) in
                switch response.result {
                case .success(let events):
                    let eventsArray = events.data.results
                    let sortedByDate = eventsArray.filter { $0.start != nil }.map { $0.getItem }.sorted { $0.startDate! > $1.startDate! }
                    let withoutDate = eventsArray.filter { $0.start == nil }.map { $0.getItem }
                    self?.items = sortedByDate + withoutDate
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func loadComics(id: Int) {
        session.request("https://gateway.marvel.com/v1/public/events/\(id)/comics",
                        parameters: [
                            "apikey":"5b23e88d26cf56958f076f88be9fed9d",
                            "hash" : MD5(string: "1" + "b220d549848ca21eacd776e73db60e6deccfd95f" + "5b23e88d26cf56958f076f88be9fed9d"),
                            "ts" : "1"
                        ]).validate(statusCode: 200...299)
            .responseDecodable(of: ComicsResponse.self) { [weak self] (response) in
                switch response.result {
                case .success(let events):
                    print("Smth")
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension EventsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else {
            EventTableViewCell.assertCellFailure()
            return UITableViewCell()
        }
        
        cell.configure(with: items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadComics(id: items[indexPath.row].id)
    }
}

// MARK: - Logger
final class AlamofireLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        \n⚡️ Request Started: \(request)
        ⚡️ Body Data: \(body)
        """
        NSLog(message)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        NSLog("\n⚡️ Response Received: \(response.debugDescription)")
    }
}

struct EventResponse: Codable {
    let data: Events
}

struct Events: Codable {
    let results: [Event]
}

struct Event: Codable {
    let id: Int
    let title: String
    let start: String?
    
    var getItem: EventCellItem {
        guard let start = start else {
            return EventCellItem(id: id, heading: title, startDate: nil)
        }
        
        return EventCellItem(id: id, heading: title, startDate: Date.formatAsDate(start, dateFormat: "yyyy-MM-dd hh:mm:ss"))
    }
}

struct EventCellItem: Item {
    let id: Int
    let heading: String
    let startDate: Date?
    
    var description: String {
        startDate?.formatAsString(dateFormat: "MMM d, yyyy") ?? "Unknown date"
    }
}

struct ComicsResponse: Codable {
    let data: Comics
}

struct Comics: Codable {
    let results: [Comic]
}

struct Comic: Codable {
    let title: String
}

import Foundation
import CryptoKit

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(string.utf8))

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
