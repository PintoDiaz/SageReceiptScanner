//
//  ViewController.swift
//  ReceiptScanner
//
//  Created by Pinto Diaz, Roger on 10/1/20.
//

import UIKit
import WeScan

final class ViewController: UIViewController, ImageScannerControllerDelegate {

    // MARK: - IBOutlets

    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var ivSelectedImage: UIImageView!

    // MARK: - Properties

    let scannerViewController = ImageScannerController()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        scannerViewController.imageScannerDelegate = self
    }

    // MARK: - Support methods
    private func setupButton() {
        btnScan.layer.cornerRadius = 7
    }

    // MARK: - onButton actions

    @IBAction func onScan(_ sender: UIButton) {
        present(scannerViewController, animated: true)
    }

    // MARK: - ImageScannerControllerDelegate

    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        scanner.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.ivSelectedImage.image = results.croppedScan.image
            }
        }
    }

    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        print("ImageScanner: cancelled")
    }

    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print("ImageScanner: Error: \(error)")
    }
}
