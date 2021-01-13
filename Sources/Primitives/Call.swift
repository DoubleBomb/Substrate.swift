//
//  Call.swift
//  
//
//  Created by Yehor Popovych on 10/9/20.
//

import Foundation
import ScaleCodec

public protocol AnyCall {
    var module: String { get }
    var function: String { get }
    var params: [ScaleDynamicCodable] { get }
}

public protocol Call: AnyCall {
    associatedtype Module: ModuleProtocol
    
    static var MODULE: String { get }
    static var FUNCTION: String { get }
    
    init(decodingParamsFrom decoder: ScaleDecoder, registry: TypeRegistryProtocol) throws
}

extension Call {
    public static var MODULE: String { return Module.NAME }
    public var module: String { return Self.MODULE }
    public var function: String { return Self.FUNCTION }
}

// Generic call
public struct DCall: AnyCall {
    public let module: String
    public let function: String
    public let params: [ScaleDynamicCodable]
    
    public init(module: String, function: String, params: [ScaleDynamicCodable]) {
        self.module = module
        self.function = function
        self.params = params
    }
}
