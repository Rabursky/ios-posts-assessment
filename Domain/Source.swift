//
//  Source.swift
//  DeclarativeWeather
//
//  Created by Marcin Raburski on 16.05.2016.
//  Copyright © 2016 Marcin Rabursky. All rights reserved.
//

import Foundation

public enum SourceError: ErrorType {
    case Inconsistency
    case NoDataReturned
}

public enum State<T> {
    case loading
    case error(error: ErrorType)
    case ready(data: T)
}

public class Source<Output> {
    public var state: Output {
        return self.getState()
    }
    
    private var internalState: Output?
    public init(state: Output? = nil) {
        self.internalState = state
    }
    
    public func setState(state: Output?) {
        self.internalState = state
        self.notifyUpdate()
    }
    
    public func getState() -> Output {
        return self.internalState!
    }
    
    public func subscribeSelf(to: Subscribable) {
        to.subscribe(self, selector: #selector(notifyUpdate))
    }
    
    @objc func notifyUpdate() {
        NSNotificationCenter.subscribableCenter.postNotificationName(self.updateNotificationName(), object: nil)
    }
}

extension Source: Subscribable {
    public func updateNotificationName() -> String {
        return String(ObjectIdentifier(self).uintValue)
    }
}

public class StateSource<Output>: Source<State<Output>> {
    public init() {
        super.init(state: nil)
    }
    
    public override func getState() -> State<Output> {
        return .error(error: RuntimeError.MissingImplementation)
    }
}

public class QueryableSource<Query, Output>: Source<Output> {
    let inputSource: Source<Query>
    let outputSource: Source<Output>
    
    public var query: Query {
        get { return self.inputSource.state }
        set { self.inputSource.setState(newValue) }
    }
    
    public init(inputSource: Source<Query>, outputSource: Source<Output>) {
        self.inputSource = inputSource
        self.outputSource = outputSource
        super.init()
        self.subscribeSelf(self.outputSource)
    }
    
    override public func getState() -> Output {
        return self.outputSource.getState()
    }
}




