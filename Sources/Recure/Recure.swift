import Foundation
import UIKit

public class Recure {
    private let projectApiKey: String
    private let eventHandlerUrl = "https://25vf084zxh.execute-api.eu-central-1.amazonaws.com/event_handler"

    public init(projectApiKey: String) {
        self.projectApiKey = projectApiKey
    }

    private func getRawDeviceDetails() -> [String: Any] {
        return [
            "os": ["name": UIDevice.current.systemName, "version": UIDevice.current.systemVersion],
            "device": [
                "vendor": "Apple",
                "model": UIDevice.current.model,
                "modelName": UIDevice.current.name,
                "type": deviceType().rawValue
            ]
        ]
    }


    private func deviceType() -> DeviceType {
        return UIDevice.current.model.contains("iPad") ? .tablet : .mobile
    }


    private func getDeviceIDForVendor() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }

    private func sendTrackPayload(payload: [String: Any]) async throws {
        var finalPayload = payload
        finalPayload["rawDeviceDetails"] = getRawDeviceDetails()
        finalPayload["visitorId"] = getDeviceIDForVendor()
        finalPayload["timestamp"] = ISO8601DateFormatter().string(from: Date())
        finalPayload["provider"] = "recure-ios"

        let jsonData = try JSONSerialization.data(withJSONObject: finalPayload, options: [])

        var request = URLRequest(url: URL(string: eventHandlerUrl)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(projectApiKey, forHTTPHeaderField: "x-api-key")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
           if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("[Recure]: Response status code: \(statusCode)")
            }

            if let responseBody = String(data: data, encoding: .utf8) {
                print("[Recure]: Response body: \(responseBody)")
            }
        } catch {
            print("[Recure] Error has occurred: \(error)")
        }


    }
    
    public func track(userOptions: UserOptions, eventType: EventType) async throws {
        let payload = [
            "userId": userOptions.userId,
            "userEmail": userOptions.userEmail,
            "userPhone": userOptions.userPhone ?? "",
            "userName": userOptions.userName ?? "",
            "type": eventType.rawValue,
        ]
        
        try await sendTrackPayload(payload: payload)
    }
}
