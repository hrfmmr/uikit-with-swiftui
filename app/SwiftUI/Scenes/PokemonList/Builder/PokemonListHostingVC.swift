import SwiftUI
import UIKit

class PokemonListHostingVC: UIViewController {
    // DI
    weak var coordinator: BaseCoordinator?
    private let contentDIContainer: PokemonListSceneDIContainer

    // SwiftUI View
    private var contentView: some View {
        PokemonListContentView()
            .environment(\.pokemonListSceneDIContainer, contentDIContainer)
            .environmentObject(contentDIContainer.sceneState.listState)
    }

    // Initialize
    init(
        coordinator: BaseCoordinator,
        contentDIContainer: PokemonListSceneDIContainer
    ) {
        self.coordinator = coordinator
        self.contentDIContainer = contentDIContainer
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SwiftUI - \(String(describing: type(of: self)))"
        setContentViewController(UIHostingController(rootView: contentView))
    }
}
