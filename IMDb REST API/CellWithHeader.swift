//
//  CellWithHeader.swift
//  IMDb REST API
//
//  Created by Антон Пеньков on 13.03.2023.
//

import UIKit

class CellWithHeader: UITableViewCell {
    let networkData = NetworkDataFetcher()
    let imageURLOptional = "https://m.media-amazon.com/images/M/MV5BOWY2OGY3MjktMDA1Ny00NDJkLTllMTEtMWVhNjg1MWQ2YmQ3XkEyXkFqcGdeQXVyNDYzNjU3ODM@._V1_QL75_UX280_CR0,0,280,414_.jpg"
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.ui16semi
        label.textColor = Constants.Colors.black
        return label
    }()
        
    private lazy var text: UITextView = {
        let textView = UITextView()
        textView.font = Constants.Fonts.ui14regular
        textView.textColor = Constants.Colors.black
        return textView
    }()
        
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    private lazy var dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.gray03
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: Movie) {
        image.loadFrom(urlAdress: viewModel.image)
        header.text = viewModel.title
        text.text? = viewModel.description
    }
    
    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(header)
        contentView.addSubview(text)
    }
    
    private func setupConstraints() {
        
        image.snp.makeConstraints { (maker) in
            maker.height.width.equalTo(50)
            maker.top.equalTo(contentView).offset(16)
            maker.left.equalTo(contentView).offset(16)
        }

        header.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(16)
            maker.left.equalTo(image.snp.right).offset(16)
            maker.height.equalTo(19)
            maker.width.equalTo(200)
        }

        text.snp.makeConstraints { (maker) in
            maker.top.equalTo(header.snp.bottom).offset(2)
            maker.bottom.equalTo(contentView).offset(-16)
            maker.left.equalTo(image.snp.right).offset(12)
            maker.width.equalTo(269)
        }
        
    }
    
}

extension UIImageView {
    
    func loadFrom(urlAdress: String) {
        guard let url = URL(string: urlAdress) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = loadedImage
                    }
                }
            }
        }
    }
}

