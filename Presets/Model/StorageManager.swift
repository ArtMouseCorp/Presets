import Foundation
import FirebaseStorage

struct StorageManager {
    
    public static let sharedInstance: StorageManager = StorageManager()
    
    let storage = Storage.storage()
    
    public func getData(path: String, completion: @escaping (Result<Data, Error>) -> ()) {
        
        let dataRef = storage.reference(withPath: path)
        
        // Download in memory with a maximum allowed size of 7MB (7 * 1024 * 1024 bytes)
        dataRef.getData(maxSize: 7 * 1024 * 1024) { data, error in
            
            guard let data = data, error == nil else {
                // Uh-oh, an error occurred!
                completion(.failure(error!))
                return
            }
            
            // Data for path is returned
            completion(.success(data))
            
        }
        
    }
    
    public func getDataURL(path: String, completion: @escaping (Result<URL, Error>) -> ()) {
        
        let storageRef = storage.reference()
        let dataRef = storageRef.child(path)
        
        // Fetch the download URL
        dataRef.downloadURL { url, error in
            
            guard let url = url, error == nil else {
                // Handle any errors
                completion(.failure(error!))
                return
            }
            
            completion(.success(url))
        }
        
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
