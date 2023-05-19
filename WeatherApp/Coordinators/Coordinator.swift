//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    func didFinish(coordinator: Coordinator)
    func didCancel(coordinator: Coordinator)
}

extension CoordinatorDelegate {
    func didFinish(coordinator: Coordinator) {
        coordinator.parent?.pop(child: coordinator)
    }

    func didCancel(coordinator: Coordinator) {
        coordinator.parent?.pop(child: coordinator)
    }
}

class Coordinator: NSObject {
    weak var delegate: CoordinatorDelegate?
    
    var viewController: UIViewController! {
        didSet {
            guard let viewController = viewController else { return }
            // if our nav stack is just an empty view controller, replace it
            if let first = navigationController.viewControllers.first,
               navigationController.viewControllers.count == 1,
               first.isMember(of: UIViewController.self)
            {
                navigationController.viewControllers = [viewController]
            } else {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }

    weak var parent: Coordinator?
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    required init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        super.init()
        parent?.push(child: self)
        if navigationController.viewControllers.isEmpty {
            navigationController.viewControllers = [UIViewController()]
        }
        navigationController.delegate = self
    }

    func start() {
        fatalError("\(type(of: self)) should implement start()!")
    }

    func push(child: Coordinator) {
        if childCoordinators.last != child {
            childCoordinators.append(child)
        }
        child.parent = self
    }

    func pop(child: Coordinator, animated: Bool = true) {
        guard let index = childCoordinators.firstIndex(of: child) else {
            assertionFailure("Cannot pop child coordinator \(child) from non-parent \(self)")
            return
        }
        childCoordinators.remove(at: index)
        child.parent = nil
        child.navigationController.popViewController(animated: animated)
    }
}

extension Coordinator: UINavigationControllerDelegate {
    func childCoordinatorForViewController(_ viewController: UIViewController) -> Coordinator? {
        if viewController === self.viewController { return self }
        return childCoordinators
            .compactMap({ $0.childCoordinatorForViewController(viewController) })
            .first
    }

    func navigationController(_ navigationController: UINavigationController, didShow _: UIViewController, animated _: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(fromVC) else { return }
        if let fromCoordinator = childCoordinatorForViewController(fromVC) {
            fromCoordinator.parent?.pop(child: fromCoordinator)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(fromVC) else { return }
        if let fromCoordinator = childCoordinatorForViewController(fromVC) {
            delegate?.didFinish(coordinator: self)
            fromCoordinator.parent?.pop(child: fromCoordinator)
        }
    }
}


