//
//  StartViewController.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit
import Combine

class StartViewController: UIViewController, Nibable, ViewModelable {

	var viewModel: StartViewModel!

	private var subscribers = Set<AnyCancellable>()

	@IBOutlet private var btnStart: UIButton!

	@IBOutlet private var btnDataPassed: PressAnimationButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupViews()
		setupCombine()
	}

}

private extension StartViewController {
	func setupViews() {
		self.view.addGestureRecognizer({
			let tapGestureRecognizer = UITapGestureRecognizer()
			tapGestureRecognizer.delegate = self
			tapGestureRecognizer.numberOfTapsRequired = 6
			tapGestureRecognizer.addTarget(self.viewModel!, action: #selector(StartViewModel.sixTapsPressed))
			return tapGestureRecognizer
		}())
		self.btnStart.addTarget(self.viewModel, action: #selector(StartViewModel.startPressed), for: .touchUpInside)
		self.btnDataPassed.addTarget(self.viewModel, action: #selector(StartViewModel.dataPassedPressed), for: .touchUpInside)
	}

	func setupCombine() {
		self.viewModel
			.$model
			.compactMap { $0 as? NumberModel }
			.sink { [weak self] numberModel in self?.onReceivedNumber(with: numberModel) }
			.store(in: &self.subscribers)
		
		self.viewModel
			.$model
			.compactMap { $0 as? CityModel }
			.sink { [weak self] cityModel in self?.onReceivedCity(with: cityModel) }
			.store(in: &self.subscribers)
		
		self.viewModel
			.colorUpdate
			.assign(to: \.backgroundColor!, on: self.view)
			.store(in: &self.subscribers)
	}

	func onReceivedNumber(with numberModel: NumberModel) {
		self.btnStart.setTitle("\(numberModel.number)", for: .normal)
		self.btnDataPassed.isHidden = false
	}

	func onReceivedCity(with cityModel: CityModel) {
		self.btnDataPassed.setTitle(cityModel.settlementName, for: .normal)
		self.btnDataPassed.isHidden = false
	}
}

extension StartViewController: UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		return touch.view == gestureRecognizer.view
	}
}
