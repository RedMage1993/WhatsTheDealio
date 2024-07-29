//
//  DisabledRedirectURLSession.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation

class DisabledRedirectURLSession: NSObject, URLSessionTaskDelegate {
    private let hostName: String

    init(hostName: String) {
        self.hostName = hostName
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(nil)
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        var serverTrust = challenge.protectionSpace.serverTrust

        guard let currentTrustState = serverTrust
        else { return completionHandler(.performDefaultHandling, nil) }

        let sslPolicies = [SecPolicyCreateSSL(true, hostName as CFString)]
        let certificates = SecTrustCopyCertificateChain(currentTrustState)

        guard SecTrustCreateWithCertificates(certificates as CFTypeRef, sslPolicies as CFTypeRef, &serverTrust) == errSecSuccess,
              SecTrustEvaluateWithError(serverTrust!, nil),
              challenge.protectionSpace.host.contains(hostName),
              let serverTrust
        else {
            return completionHandler(.performDefaultHandling, URLCredential(trust: currentTrustState))
        }

        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
}
