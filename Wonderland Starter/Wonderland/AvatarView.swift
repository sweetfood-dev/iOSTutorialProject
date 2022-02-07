/**
 Copyright (c) 2016 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

class AvatarView: UIView {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            setNeedsUpdateConstraints()
//            updateConstraintsIfNeeded() // 제약사항의 변경사항이 있을 때만 적용되어서 제대로 적용이 안되는듯?
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    fileprivate var regularConstraints = [NSLayoutConstraint]()
    fileprivate var compactConstraints = [NSLayoutConstraint]()
    fileprivate var aspectRatioConstraint:NSLayoutConstraint?
    // Views
    fileprivate let titleLabel = UILabel()
    fileprivate let imageView = UIImageView()
    fileprivate lazy var socialMediaView: UIStackView = {
        return AvatarView.createSocialMediaView()
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setup()
        setupConstraints()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 100)
    }
    
     override func updateConstraints() {
        print("update")
        var aspectRatio: CGFloat = 1
        if let image = image {
            aspectRatio = image.size.width / image.size.height
        }

        aspectRatioConstraint?.isActive = false // 새로운 제약조건을 추가하지 않도록 이전항목 비활성화 / 무효화
        aspectRatioConstraint = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                                                 multiplier: aspectRatio)
        aspectRatioConstraint?.isActive = true

        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        socialMediaView.alpha = bounds.height < socialMediaView.bounds.height ? 0 : 1
        imageView.alpha = imageView.bounds.height < 30 ? 0 : 1
        
    }
    
    func setup() {
        imageView.backgroundColor = UIColor.magenta
        titleLabel.backgroundColor = UIColor.orange
        
        imageView.contentMode = .scaleAspectFit
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 28.0)
        titleLabel.textColor = UIColor.black
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(socialMediaView)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        socialMediaView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelBottom = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        let imageViewTop = imageView.topAnchor.constraint(equalTo: topAnchor)
        let imageViewBottom = imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
        
        let socialMediaTrailing =
              socialMediaView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        NSLayoutConstraint.activate([imageViewTop, imageViewBottom,
                                    labelBottom,
                                    socialMediaTrailing])
        
        imageView.setContentCompressionResistancePriority(.defaultLow,
                                                          for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow,
                                                          for: .horizontal)
        
        socialMediaView.axis = .vertical
        
        compactConstraints.append(
              imageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        compactConstraints.append(
              titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor))
        compactConstraints.append(
              socialMediaView.topAnchor.constraint(equalTo: topAnchor))
        
        regularConstraints.append(
              imageView.leadingAnchor.constraint(equalTo: leadingAnchor))
        regularConstraints.append(
              titleLabel.leadingAnchor.constraint(
                equalTo: imageView.leadingAnchor))
        regularConstraints.append(
              socialMediaView.bottomAnchor.constraint(equalTo: bottomAnchor))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass == .regular {
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            socialMediaView.axis = .horizontal
        } else {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            socialMediaView.axis = .vertical
        }
    }
}
