//
//  MenuTransitionManager.swift
//  CustomMenu
//
//  Created by Alexander Blokhin on 30.12.15.
//  Copyright © 2015 Alexander Blokhin. All rights reserved.
//

import UIKit

class MenuAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    private var presenting = false
    
    // MARK: - UIViewControllerAnimatedTransitioning 
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        
        // create a tuple of our screens
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        // assign references to our menu view controller and the 'bottom' view controller from the tuple
        // remember that our menuViewController will alternate between the from and to view controller depending if we're presenting or dismissing
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        // setup 2D transitions for animations
        let offstageLeft = CGAffineTransformMakeTranslation(-150, 0)
        let offstageRight = CGAffineTransformMakeTranslation(150, 0)
        
        // prepare the menu
        if (self.presenting){
            
            // prepare menu to fade in
            menuView.alpha = 0
            
            // prepare menu items to slide in
            menuViewController.cameraImageView.transform = offstageLeft
            menuViewController.cameraLabel.transform = offstageLeft
            
            menuViewController.compassImageView.transform = offstageRight
            menuViewController.compassLabel.transform = offstageRight
            
        }
        
        // add the both views to our view controller
        container?.addSubview(bottomView)
        container?.addSubview(menuView)
        
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
                if (self.presenting){
                    // fade in
                    menuView.alpha = 1
                
                    // onstage items: slide in
                    menuViewController.cameraImageView.transform = CGAffineTransformIdentity
                    menuViewController.cameraLabel.transform = CGAffineTransformIdentity
                
                    menuViewController.compassImageView.transform = CGAffineTransformIdentity
                    menuViewController.compassLabel.transform = CGAffineTransformIdentity
                
                }
                else {
                    // fade out
                    menuView.alpha = 0
                
                    // offstage items: slide out
                    menuViewController.cameraImageView.transform = offstageLeft
                    menuViewController.cameraLabel.transform = offstageLeft
                
                    menuViewController.compassImageView.transform = offstageRight
                    menuViewController.compassLabel.transform = offstageRight
                
                }
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
                // bug: we have to manually add our 'to view' back 
                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
                
        })
        
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    // return the animataor when presenting a viewcontroller
    // rememeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}





