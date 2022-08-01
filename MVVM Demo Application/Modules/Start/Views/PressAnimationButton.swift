//
//  PressAnimationButton.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 01/08/2022.
//

import UIKit

fileprivate enum Touches {
	case began
	case ended
}

@IBDesignable
class PressAnimationButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = min(bounds.width, bounds.height) / 2
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		animateShadow(touches: .began)
		super.touchesBegan(touches, with: event)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		animateShadow(touches: .ended)
		super.touchesEnded(touches, with: event)
	}
}

private extension PressAnimationButton {
	func setupView() {
		layer.shadowOffset = CGSize(width: 13, height: 10)
		layer.shadowColor = UIColor.darkGray.cgColor
		layer.shadowOpacity = 0.5
		layer.shadowRadius = 1
	}

	func animateShadow(touches: Touches) {
		let animation = CABasicAnimation(keyPath: "shadowOpacity")
		animation.fromValue = {
			switch touches {
			case .began: return 0.5
			case .ended: return 0
			}
		}()
		animation.toValue = {
			switch touches {
			case .began: return 0
			case .ended: return 0.5
			}
		}()
		animation.duration = 0.1
		layer.add(animation, forKey: animation.keyPath)
		layer.shadowOpacity = {
			switch touches {
			case .began: return 0
			case .ended: return 0.5
			}
		}()
	}
}
