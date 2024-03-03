import Foundation
import Photos
import UIKit

protocol ImageSaverDelegate: AnyObject {
    func success()
    func fail()
}

class ImageSaver: NSObject {
    weak var delegate: ImageSaverDelegate?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            delegate?.success()
        } else {
            delegate?.fail()
        }
    }
}
