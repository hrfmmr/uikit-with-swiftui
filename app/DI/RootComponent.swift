import Foundation
import NeedleFoundation

class RootComponent: BootstrapComponent {
    var dicontainer: DIContainer {
        DIContainer(
            viewBuilderContainer: viewBuilderContainerComponent
        )
    }

    var viewBuilderContainerComponent: ViewBuilderContainerComponent {
        ViewBuilderContainerComponent(parent: self)
    }
}
