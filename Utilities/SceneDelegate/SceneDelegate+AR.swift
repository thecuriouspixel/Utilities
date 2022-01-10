import UIKit

extension SceneDelegate {
    
    /*
      Remove default storyboard + mention of it on pList
     */
    func programaticLaunch(forScene scene: UIScene, with vc: UIViewController) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = vc
        // could make this a boolean if I don't want a nav bar
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigation
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
