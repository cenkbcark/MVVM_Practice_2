//
//  RequestModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 6.10.2022.
//

import Foundation


class RequestModel {
    
    var path : String{
        ""
    }
    
    var parameters: [String: Any?] {
        [:]
    }
    
    var headers : [String: String] {
        [:]
    }
    
    var method: RequestMethod{
        .get
    }
    
    var body: [String: Any?] {
        [
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "*/*"
        ]
    }
}

extension RequestModel{
    
    func generateRequest() -> URLRequest? {
        guard let url = generateUrl(with: generateQueryItems()) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return appendBodyIfNeeded(to: request)
        
    }
    
    private func generateUrl(with queryItems: [URLQueryItem]) -> URL?{
        let endPoint = Constant.API.baseURL.appending(path)
        var urlComponents = URLComponents(string: endPoint)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return nil }
        return url
        
    }
    
    private func generateQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        parameters.forEach { parameter in
            let value = parameter.value as! String
            queryItems.append(.init(name: parameter.key, value: value))
        }
        return queryItems
    }
    
    private func appendBodyIfNeeded(to request: URLRequest) -> URLRequest{
        var mutableRequesst = request
        var jsonText : String = .empty
        
        guard method == RequestMethod.post else { return request}
        
        if let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted), let encodeJson = String(data: data, encoding: .utf8){
            jsonText = encodeJson
        }
        
        let postData = jsonText.data(using: .utf8)
        mutableRequesst.httpBody = postData
        
        return mutableRequesst
    }
}
