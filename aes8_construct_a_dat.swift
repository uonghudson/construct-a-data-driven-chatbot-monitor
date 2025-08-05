import Foundation

// Data Model for Chatbot Messages
struct ChatbotMessage {
    let id: Int
    let message: String
    let intent: String
    let entities: [String: String]
}

// Data Model for Chatbot Monitor
struct ChatbotMonitor {
    let messages: [ChatbotMessage]
    let averageResponseTime: Double
    let errors: [String]
}

// Chatbot Monitor Class
class ChatbotMonitorClass {
    private var messages: [ChatbotMessage] = []
    private var responseTimes: [Double] = []
    private var errors: [String] = []
    
    func trackMessage(id: Int, message: String, intent: String, entities: [String: String], responseTime: Double) {
        let chatbotMessage = ChatbotMessage(id: id, message: message, intent: intent, entities: entities)
        messages.append(chatbotMessage)
        responseTimes.append(responseTime)
        
        if responseTime > 5.0 {
            errors.append("Slow response time: \(responseTime)")
        }
    }
    
    func getMonitorData() -> ChatbotMonitor {
        let averageResponseTime = responseTimes.reduce(0, +) / Double(responseTimes.count)
        return ChatbotMonitor(messages: messages, averageResponseTime: averageResponseTime, errors: errors)
    }
}

// Example Usage
let monitor = ChatbotMonitorClass()

monitor.trackMessage(id: 1, message: "Hello, how are you?", intent: "greeting", entities: ["user": "John"], responseTime: 2.5)
monitor.trackMessage(id: 2, message: "I'm doing well, thanks.", intent: "response", entities: ["user": "John"], responseTime: 3.2)
monitor.trackMessage(id: 3, message: "Error: Unable to process request.", intent: "error", entities: [:], responseTime: 10.0)

let monitorData = monitor.getMonitorData()

print("Chatbot Monitor Data:")
print("Average Response Time: \(monitorData.averageResponseTime)")
print("Errors: \(monitorData.errors)")
print("Messages:")
for message in monitorData.messages {
    print("ID: \(message.id), Message: \(message.message), Intent: \(message.intent)")
}