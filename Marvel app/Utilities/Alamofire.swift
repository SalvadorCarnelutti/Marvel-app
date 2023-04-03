//
//  Alamofire.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//

import Alamofire

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
