import UIKit

final class ProductViewController: UIViewController {
    
    private var productViewModel: IProductViewModel
    private var curentViewController: UIViewController?

    init (productViewModel: IProductViewModel) {
        self.productViewModel = productViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productViewModel.getData()
        setupFromViewModel()
        setupBinding()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout

extension ProductViewController {
    
    private func setupFromViewModel() {
        let state = productViewModel.state
        switch state {
        case .loading:
            showLoading()
        case .loaded:
            showProduct()
        case .error:
            showError()
        }
    }
}

//MARK: - Binding

extension ProductViewController {
    
    private func setupBinding() {
        productViewModel.onUpdateState = { [weak self] in
            guard let self = self else { return }
            Task {
                await MainActor.run {
                    self.setupFromViewModel()
                }
            }
        }
    }
}

//MARK: - Show loading controller

extension ProductViewController {
    
    private func showLoading() {
        let loadingController = LoadingViewController()
        addChild(loadingController)
        loadingController.view.frame = view.bounds
        loadingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(loadingController.view)
        loadingController.didMove(toParent: self)
        curentViewController = loadingController
    }
    
    private func showProduct() {
        let displayController = productViewModel.di.screenFactory.createProductDisplayScreen(productViewModel: productViewModel)
        addChild(displayController)
        displayController.view.frame = view.bounds
        displayController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        curentViewController?.willMove(toParent: nil)
        if let curentVC = curentViewController {
            transition(
                from: curentVC,
                to: displayController,
                duration: 0.25,
                animations: nil)
            { (_) in
                self.curentViewController?.removeFromParent()
                self.curentViewController = displayController
                self.curentViewController?.didMove(toParent: self)
            }
        }
    }
    
    private func showError() {
        let alertController = UIAlertController(title: "", message: "Something went wrong", preferredStyle: .alert)
        let alertActrion = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(alertActrion)
        present(alertController, animated: true, completion: nil)
    }
}
