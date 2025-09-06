import { Link } from "react-router-dom";
import { Facebook, Twitter, Instagram, Mail, Phone, MapPin } from "lucide-react";
import gasIcon from "@/assets/gas-icon.png";

const Footer = () => {
  return (
    <footer className="bg-foreground text-background">
      <div className="container mx-auto px-4 py-12">
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          {/* Company Info */}
          <div>
            <div className="flex items-center space-x-2 mb-4">
              <img src={gasIcon} alt="GazFlow" className="h-8 w-8 filter invert" />
              <span className="text-xl font-bold">GazFlow</span>
            </div>
            <p className="text-background/80 mb-4">
              La plateforme leader de livraison de gaz au Cameroun. 
              Rapide, fiable et sécurisé.
            </p>
            <div className="flex space-x-3">
              <a href="#" className="text-background/60 hover:text-background transition-colors">
                <Facebook className="h-5 w-5" />
              </a>
              <a href="#" className="text-background/60 hover:text-background transition-colors">
                <Twitter className="h-5 w-5" />
              </a>
              <a href="#" className="text-background/60 hover:text-background transition-colors">
                <Instagram className="h-5 w-5" />
              </a>
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="font-semibold mb-4">Liens Rapides</h3>
            <ul className="space-y-2">
              <li>
                <Link to="/" className="text-background/80 hover:text-background transition-colors">
                  Accueil
                </Link>
              </li>
              <li>
                <a href="#features" className="text-background/80 hover:text-background transition-colors">
                  Fonctionnalités
                </a>
              </li>
              <li>
                <a href="#about" className="text-background/80 hover:text-background transition-colors">
                  À propos
                </a>
              </li>
              <li>
                <Link to="/admin/login" className="text-background/80 hover:text-background transition-colors">
                  Administration
                </Link>
              </li>
            </ul>
          </div>

          {/* Services */}
          <div>
            <h3 className="font-semibold mb-4">Services</h3>
            <ul className="space-y-2">
              <li className="text-background/80">Livraison Express</li>
              <li className="text-background/80">Gaz Domestique</li>
              <li className="text-background/80">Gaz Industriel</li>
              <li className="text-background/80">Support 24/7</li>
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h3 className="font-semibold mb-4">Contact</h3>
            <div className="space-y-3">
              <div className="flex items-center space-x-3">
                <MapPin className="h-4 w-4 text-background/60" />
                <span className="text-background/80 text-sm">
                  Douala, Cameroun
                </span>
              </div>
              <div className="flex items-center space-x-3">
                <Phone className="h-4 w-4 text-background/60" />
                <span className="text-background/80 text-sm">
                  +237 6XX XXX XXX
                </span>
              </div>
              <div className="flex items-center space-x-3">
                <Mail className="h-4 w-4 text-background/60" />
                <span className="text-background/80 text-sm">
                  contact@gazflow.cm
                </span>
              </div>
            </div>
          </div>
        </div>

        <div className="border-t border-background/20 mt-8 pt-8 text-center">
          <p className="text-background/60 text-sm">
            © {new Date().getFullYear()} GazFlow. Tous droits réservés.
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;