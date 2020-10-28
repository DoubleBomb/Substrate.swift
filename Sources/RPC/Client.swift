//
//  RpcClient.swift
//  
//
//  Created by Yehor Popovych on 10/28/20.
//

import Foundation
import Dispatch

public protocol Method: Codable {
    var substrateMethod: String { get }
}

extension String: Method {
    public var substrateMethod: String { self }
}

public enum RpcClientError: Error {
    case http(code: Int, body: Data)
    case transport(error: Error)
    case encoding(error: EncodingError)
    case decoding(error: DecodingError)
    case rpc(error: JsonRpcError)
    case unknown(error: Error?)
}

public typealias RpcClientCallback<R> = (Result<R, RpcClientError>) -> Void

public protocol RpcClient {
    var responseQueue: DispatchQueue { get set }
    
    func call<P: Encodable & Sequence, R: Decodable>(
        method: Method, params: P, response: @escaping RpcClientCallback<R>
    )
}
