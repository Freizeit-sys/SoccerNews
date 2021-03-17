//
//  ErrorCodes.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/17.
//

import Foundation

public enum ErrorCodes {
    case ApiKeyExhausted
    case ApiKeyMissing
    case ApiKeyInvalid
    case ApiKeyDisabled
    case ParametersMissing
    case ParametersIncompatible
    case ParameterInvalid
    case RateLimited
    case RequestTimeout
    case SourcesTooMany
    case SourceDoesNotExist
    case SourceUnavailableSortedBy
    case SourceTemporarilyUnavailable
    case UnexpectedError
    case UnknownError
}
