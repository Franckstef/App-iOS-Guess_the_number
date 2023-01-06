import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var jeu = jouer(borneMin: 0, borneMax: 0, nbCoupsMax: 0)
    
    var partieLibreChoisie = false
    var valuesPartieLibre: [Int] = [Int]()
    let msgPartieLibre = ["Entrer la valeur minimum", "Entrer la valeur maximum", "Entrer le nombre d'essais", "Super !\n Maintenant, appuie sur 'Go' pour demarrer la partie."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.enterNb.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)),
            name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil);
        
        cornerRadius()
        enterNb.isEnabled = false
        enterNb.text = ""
        titre.text = "Bienvenue!"
            + "\nTrouve un nombre entre 2 autres nombres avec un nombre de coups max !\n"
            + "\n1-Classique: entre 1 et 100 en 10 coups."
            + "\n2-Rapide: entre 21 et 42 en 3 coups."
            + "\n3-Libre: tu choisis les regles !"
    }
    
    @IBOutlet weak var classique: UIButton!
    
    @IBOutlet weak var rapide: UIButton!
    
    @IBOutlet weak var libre: UIButton!
    
    @IBOutlet weak var go: UIButton!
    
    @IBOutlet weak var rejouer: UIButton!
    
    @IBOutlet weak var quitter: UIButton!
    
    @IBOutlet weak var titre: UILabel!
    
    @IBOutlet weak var monTexte: UILabel!
    
    @IBOutlet var enterNb: UITextField!
    
    @IBAction func quitter(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func rejouer(_ sender: Any) {
        valuesPartieLibre = []
        partieLibreChoisie = false
        enterNb.isEnabled = false
        classique.isEnabled = true
        rapide.isEnabled = true
        libre.isEnabled = true
        monTexte.text = "Choisissez une des 3 options pour jouer !"
    }
    
    @IBAction func classique(_ sender: Any) {
        partieNormal()
    }
    
    @IBAction func rapide(_ sender: Any) {
        partieRapide()
    }
    
    @IBAction func libre(_ sender: Any) {
        partieLibre()
    }
    
    @IBAction func go(_ sender: Any) {
        if partieLibreChoisie == true {
            if valuesPartieLibre.count < 3 {
                guard let nb = Int(enterNb.text ?? "") else {
                    return
                }
                valuesPartieLibre.append(nb)
                preparationPartieLibre()
                enterNb.text = ""
            }
            else {
                jeu = jouer(borneMin: valuesPartieLibre[0], borneMax: valuesPartieLibre[1], nbCoupsMax: valuesPartieLibre[2])
                monTexte.text = "C'est parti ! Trouve un chiffre entre \(jeu.borneMin) et \(jeu.borneMax) \nEssai n \(jeu.essai)/\(jeu.nbCoupsMax)"
                partieLibreChoisie = false
            }
            
        }
        else {
            guard let nb = Int(enterNb.text ?? "") else {
                return
            }
            jeu.reponse(nb: nb)
            monTexte.text = jeu.message
            enterNb.text = ""
                if (monTexte.text == "\nBravo, tu as gagné la partie en \(jeu.essai) coups !\nPour rejouer, appuie sur 'Rejouer' !" || monTexte.text == "\nTu as perdu, le nombre à deviner était \(jeu.chiffreMystère) !\nPour rejouer, appuie sur 'Rejouer' !") {
                    enterNb.isEnabled = false
                }
        }
        
    }
    
    func partieNormal() {
        visible()
        enterNb.isEnabled = true
        jeu = jouer(borneMin: 1, borneMax: 100, nbCoupsMax: 10)
        monTexte.text = "C'est parti ! Trouve un chiffre entre \(jeu.borneMin) et \(jeu.borneMax) \nEssai n \(jeu.essai)/\(jeu.nbCoupsMax)"
    }
    
    func partieRapide() {
        visible()
        enterNb.isEnabled = true
        jeu = jouer(borneMin: 21, borneMax: 42, nbCoupsMax: 3)
        monTexte.text = "C'est parti ! Trouve un chiffre entre \(jeu.borneMin) et \(jeu.borneMax) \nEssai n \(jeu.essai)/\(jeu.nbCoupsMax)"
    }
    
    func partieLibre() {
        visible()
        enterNb.isEnabled = true
        partieLibreChoisie = true
        preparationPartieLibre()
    }
    
    func preparationPartieLibre() {
        let cnt = valuesPartieLibre.count
        monTexte.text = msgPartieLibre[cnt]
    }
    
    func visible(){
        classique.isEnabled = false
        rapide.isEnabled = false
        libre.isEnabled = false
    }
    
    func cornerRadius(){
        classique.layer.cornerRadius = 10;
        rapide.layer.cornerRadius = 10;
        libre.layer.cornerRadius = 10;
        go.layer.cornerRadius = 10;
        rejouer.layer.cornerRadius = 10;
        quitter.layer.cornerRadius = 10;
        enterNb.layer.cornerRadius = 10;
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
                return false
        }
    
    @objc func keyboardWillShow(sender: Notification) {
        if UIDevice.current.orientation.isLandscape {
            self.view.frame.origin.y = -135
        }
        else {
            self.view.frame.origin.y = -400
        }
    }

    @objc func keyboardWillHide(sender: Notification) {
         self.view.frame.origin.y = 0
    }
    
}
