//
//  APIService.swift

import Foundation

class APIService :  NSObject {

    //Call API For Devies
    func callApiToGetDevicesData(completion : @escaping (DevicesModel) -> ()){
        
        var request = URLRequest(url: URL(string:WebURL.getDevies)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in

            print("WebService failed error \(String(describing: error?.localizedDescription)) ")
            if error == nil {
                
                let jsonDecoder = JSONDecoder()
                let deviceData = try! jsonDecoder.decode(DevicesModel.self, from: data!)
                completion(deviceData)
            }
        })
        task.resume()
    }
}



