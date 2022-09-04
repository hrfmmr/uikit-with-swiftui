import Combine
import UIKit

class PokemonDetailsVC: UIViewController, HasCoordinator {
    // DI
    weak var coordinator: BaseCoordinator?
    private let viewModel: PokemonDetailsViewModel

    // UI
    private lazy var pokemonNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    // Events
    private var cancellables = Set<AnyCancellable>()

    // Initialize
    init(
        coordinator: BaseCoordinator,
        viewModel: PokemonDetailsViewModel
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        binding()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit - \(String(describing: type(of: self)))"
        view.backgroundColor = .white
        setupViews()
    }

    // Set up
    private func binding() {
        let output = viewModel.transform(
            input: .init()
        )
        output.pokemon
            .sink { [weak self] in
                self?.pokemonNameLabel.text = "Details of: \($0.name)"
            }
            .store(in: &cancellables)
    }

    private func setupViews() {
        _ = {
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }(pokemonNameLabel)
    }
}
