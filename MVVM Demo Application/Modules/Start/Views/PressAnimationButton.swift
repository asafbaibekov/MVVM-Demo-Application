//
//  PressAnimationButton.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 01/08/2022.
//

import UIKit

struct PressAnimationButtonModel {

	let normalShadowOpacity: Float
	let highlightShadowOpacity: Float
	let normalShadowOffset: CGSize
	let highlightShadowOffset: CGSize
	let normalTransform: CATransform3D
	let highlightTransform: CATransform3D
	let shadowRadius: CGFloat
	let shadowColor: CGColor
	let duration: CFTimeInterval

	static var example: PressAnimationButtonModel {
		PressAnimationButtonModel(
			normalShadowOpacity: 0.5,
			highlightShadowOpacity: 0,
			normalShadowOffset: CGSize(width: 20, height: 20),
			highlightShadowOffset: .zero,
			normalTransform: CATransform3DIdentity,
			highlightTransform: CATransform3DMakeTranslation(10, 10, 0),
			shadowRadius: 1,
			shadowColor: UIColor.darkGray.cgColor,
			duration: 0.25
		)
	}
}

fileprivate enum Touches {
	case began
	case ended
}

@IBDesignable
class PressAnimationButton: UIButton {

	private lazy var shadowOpacityAnimation	= CABasicAnimation(keyPath: #keyPath(CALayer.shadowOpacity))
	private lazy var shadowOffsetAnimation	= CABasicAnimation(keyPath: #keyPath(CALayer.shadowOffset))
	private lazy var transformAnimation		= CABasicAnimation(keyPath: #keyPath(CALayer.transform))

	private var TOUCHES_KEY: String { "touches" }

	var model: PressAnimationButtonModel = .example

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
		animateTransform(touches: .began)
		animateShadowOffset(touches: .began)
		animateShadowOpacity(touches: .began)
		super.touchesBegan(touches, with: event)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		animateTransform(touches: .ended)
		animateShadowOffset(touches: .ended)
		animateShadowOpacity(touches: .ended)
		super.touchesEnded(touches, with: event)
	}

	func setupView(model: PressAnimationButtonModel = .example) {
		self.model = model
		[shadowOpacityAnimation, shadowOffsetAnimation, transformAnimation].forEach {
			$0.delegate = self
			$0.fillMode = .both
			$0.isRemovedOnCompletion = false
		}
		layer.shadowColor	= model.shadowColor
		layer.shadowOffset	= model.normalShadowOffset
		layer.shadowRadius	= model.shadowRadius
		layer.shadowOpacity = model.normalShadowOpacity
	}
}

private extension PressAnimationButton {
	func animateTransform(touches: Touches) {
		transformAnimation.setValue(touches, forKey: TOUCHES_KEY)
		transformAnimation.duration = model.duration
		transformAnimation.fromValue = layer.presentation()?.value(forKeyPath: #keyPath(CALayer.transform)) as? CATransform3D
		transformAnimation.toValue = {
			switch touches {
			case .began: return self.model.highlightTransform
			case .ended: return self.model.normalTransform
			}
		}()
		layer.add(transformAnimation, forKey: transformAnimation.keyPath)
	}
	func animateShadowOffset(touches: Touches) {
		shadowOffsetAnimation.setValue(touches, forKey: TOUCHES_KEY)
		shadowOffsetAnimation.duration = model.duration
		shadowOffsetAnimation.fromValue = layer.presentation()?.value(forKeyPath: #keyPath(CALayer.shadowOffset)) as? CGSize
		shadowOffsetAnimation.toValue = {
			switch touches {
			case .began: return model.highlightShadowOffset
			case .ended: return model.normalShadowOffset
			}
		}()
		layer.add(shadowOffsetAnimation, forKey: shadowOffsetAnimation.keyPath)
	}
	func animateShadowOpacity(touches: Touches) {
		shadowOpacityAnimation.setValue(touches, forKey: TOUCHES_KEY)
		shadowOpacityAnimation.duration = model.duration
		shadowOpacityAnimation.fromValue = layer.presentation()?.value(forKeyPath: #keyPath(CALayer.shadowOpacity)) as? Float
		shadowOpacityAnimation.toValue = {
			switch touches {
			case .began: return model.highlightShadowOpacity
			case .ended: return model.normalShadowOpacity
			}
		}()
		layer.add(shadowOpacityAnimation, forKey: shadowOpacityAnimation.keyPath)
	}
}

extension PressAnimationButton: CAAnimationDelegate {
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		if let value = shadowOpacityAnimation.value(forKey: TOUCHES_KEY) as? Touches {
			layer.shadowOpacity = {
				switch value {
				case .began: return model.highlightShadowOpacity
				case .ended: return model.normalShadowOpacity
				}
			}()
		}
		else if let value = shadowOffsetAnimation.value(forKey: TOUCHES_KEY) as? Touches {
			layer.shadowOffset = {
				switch value {
				case .began: return self.model.highlightShadowOffset
				case .ended: return self.model.normalShadowOffset
				}
			}()
		}
		else if let value = transformAnimation.value(forKey: TOUCHES_KEY) as? Touches {
			layer.transform = {
				switch value {
				case .began: return self.model.highlightTransform
				case .ended: return self.model.normalTransform
				}
			}()
		}
	}
}
