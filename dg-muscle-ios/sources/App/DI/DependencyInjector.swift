//
//  DependencyInjector.swift
//  App
//
//  Created by 신동규 on 7/6/24.
//

import Swinject

/// DI 대상 등록
public protocol DependencyAssemblable {
    func assemble(_ assemblyList: [Assembly])
    func register<T>(_ serviceType: T.Type, _ object: T)
}

/// DI 등록한 서비스 사용
public protocol DependencyResolvable {
    func resolve<T>(_ serviceType: T.Type) -> T
}

public typealias Injector = DependencyAssemblable & DependencyResolvable

public final class DependencyInjector: Injector {
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    public func assemble(_ assemblyList: [any Swinject.Assembly]) {
        assemblyList.forEach({
            $0.assemble(container: container)
        })
    }
    
    public func register<T>(_ serviceType: T.Type, _ object: T) {
        container.register(serviceType) { _ in object }
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        container.resolve(serviceType)!
    }
    
    // 한 개의 인수를 처리하는 resolve 함수
    public func resolve<T, Arg1>(_ serviceType: T.Type, argument: Arg1) -> T {
        container.resolve(serviceType, argument: argument)!
    }

    // 두 개의 인수를 처리하는 resolve 함수
    public func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T {
        container.resolve(serviceType, arguments: arg1, arg2)!
    }

    // 세 개의 인수를 처리하는 resolve 함수
    public func resolve<T, Arg1, Arg2, Arg3>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T {
        container.resolve(serviceType, arguments: arg1, arg2, arg3)!
    }
}
