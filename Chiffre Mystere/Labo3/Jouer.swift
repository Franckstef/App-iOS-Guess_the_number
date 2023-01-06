import Foundation

class jouer {
    
    var borneMin: Int
    var borneMax: Int
    var nbCoupsMax: Int
    var chiffreMystère: Int
    var message: String = ""
    var essai: Int = 1
    
    init(borneMin: Int, borneMax: Int, nbCoupsMax: Int) {
        self.borneMin = borneMin
        self.borneMax = borneMax
        self.nbCoupsMax = nbCoupsMax
        chiffreMystère =  Int.random(in: borneMin...borneMax)
    }
 
    func reponse(nb: Int) {
        if(nb < borneMin || nb > borneMax) {
            message = "Hey ! Ca se joue entre \(borneMin) et \(borneMax) !\n\nEssai n \(essai)/\(nbCoupsMax)"
            return
        }
        else {
            if nb == chiffreMystère {
                message = "\nBravo, tu as gagné la partie en \(essai) coups !\nPour rejouer, appuie sur 'Rejouer' !"
                return
            }
            else if essai == nbCoupsMax {
                message = "\nTu as perdu, le nombre à deviner était \(chiffreMystère) !\nPour rejouer, appuie sur 'Rejouer' !"
                return
                    
            }
            else {
                if nb < chiffreMystère {
                    borneMin = nb
                        message = "Plus grand que \(nb) et plus petit que \(borneMax) !\n\nEssai n \(essai+1)/\(nbCoupsMax)"
                }
                else {
                    borneMax = nb
                    message = "Plus grand que \(borneMin) et plus petit que \(nb) !\n\nEssai n \(essai+1)/\(nbCoupsMax)"
                }
            }
            essai += 1
        }
    }
}
