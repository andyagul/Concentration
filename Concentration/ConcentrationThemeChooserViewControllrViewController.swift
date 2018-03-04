//
//  ConcentrationThemeChooserViewControllrViewController.swift
//  Concentration
//
//  Created by Chen Weiru on 04/03/2018.
//  Copyright © 2018 Steve Harski. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewControllrViewController: UIViewController, UISplitViewControllerDelegate {
    
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConentrationViewController{
            if  cvc.theme == nil{
                return true
            }
            }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme.joined()
            }
        }else if let cvc = lastSeguedToConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme.joined()
            }
            navigationController?.pushViewController(cvc, animated: true)
        }else{
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController:ConentrationViewController?{
        return splitViewController?.viewControllers.last as? ConentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConentrationViewController?
    
    
    let themes = [
        "Faces" :["🐶","🐱","🐼","🐰","🐻","🐯","🐵","🦆","🦋","🐿"],
        "Sports" : ["⚽️","🏀","🏈","⚾️","🎾","🏸","🥊","🏄🏼‍♂️","🚴‍♀️","🏊🏽‍♂️"],
        "Animals": ["🍇","🍓","🍌","🌽","🍔","🍟","🍝","🍩","🍫","🍿"]
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Choose Themes" else{
            return
        }
        
        guard let button = sender as? UIButton else{
            return
        }
        
        guard let themeName = button.currentTitle else{
            return
        }
        
        guard let theme = themes[themeName] else {
            return
        }
        
        guard let cvc = segue.destination as? ConentrationViewController else{
            return
        }
        
        cvc.theme = theme.joined()
        
    }
    
}
