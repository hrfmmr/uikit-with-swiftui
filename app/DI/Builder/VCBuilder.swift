import Foundation

class VCBuilder<Dependency> {
    let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
}
