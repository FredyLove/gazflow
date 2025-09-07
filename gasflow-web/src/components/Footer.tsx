import { Link } from "react-router-dom";
import { Facebook, Twitter, Instagram, Mail, Phone, MapPin } from "lucide-react";
import gasIcon from "@/assets/gas-icon.png";

const Footer = () => {
  return (
    <footer className="bg-gradient-to-br from-foreground to-foreground/90 text-background relative overflow-hidden">
      {/* Background decoration */}
      <div className="absolute inset-0 bg-gradient-subtle opacity-10" />
      <div className="absolute top-0 right-0 w-64 h-64 bg-primary/5 rounded-full blur-3xl" />
      
      <div className="container mx-auto px-4 py-12 relative z-10">
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          {/* Company Info */}
          <div className="animate-fadeInScale">
            <div className="flex items-center space-x-2 mb-4">
              <img src={gasIcon} alt="GazFlow" className="h-8 w-8 filter invert hover-scale" />
              <span className="text-xl font-bold">GazFlow</span>
            </div>
            <p className="text-background/80 mb-4 leading-relaxed">
              The leading gas delivery platform in Cameroon. 
              Fast, reliable and secure.
            </p>
            <div className="flex space-x-3">
              <a href="#" className="text-background/60 hover:text-primary-light transition-all duration-300 hover-scale">
                <Facebook className="h-5 w-5" />
              </a>
              <a href="#" className="text-background/60 hover:text-primary-light transition-all duration-300 hover-scale">
                <Twitter className="h-5 w-5" />
              </a>
              <a href="#" className="text-background/60 hover:text-primary-light transition-all duration-300 hover-scale">
                <Instagram className="h-5 w-5" />
              </a>
            </div>
          </div>

          {/* Quick Links */}
          <div className="animate-slide-up" style={{ animationDelay: '100ms' }}>
            <h3 className="font-semibold mb-4 text-primary-light">Quick Links</h3>
            <ul className="space-y-2">
              <li>
                <Link to="/" className="text-background/80 hover:text-primary-light transition-all duration-300 hover:translate-x-1 inline-block">
                  Home
                </Link>
              </li>
              <li>
                <a href="#features" className="text-background/80 hover:text-primary-light transition-all duration-300 hover:translate-x-1 inline-block">
                  Features
                </a>
              </li>
              <li>
                <a href="#about" className="text-background/80 hover:text-primary-light transition-all duration-300 hover:translate-x-1 inline-block">
                  About
                </a>
              </li>
              <li>
                <Link to="/admin/login" className="text-background/80 hover:text-primary-light transition-all duration-300 hover:translate-x-1 inline-block">
                  Admin
                </Link>
              </li>
            </ul>
          </div>

          {/* Services */}
          <div className="animate-slide-up" style={{ animationDelay: '200ms' }}>
            <h3 className="font-semibold mb-4 text-primary-light">Services</h3>
            <ul className="space-y-2">
              <li className="text-background/80 hover:text-background transition-colors cursor-pointer">Express Delivery</li>
              <li className="text-background/80 hover:text-background transition-colors cursor-pointer">Domestic Gas</li>
              <li className="text-background/80 hover:text-background transition-colors cursor-pointer">Industrial Gas</li>
              <li className="text-background/80 hover:text-background transition-colors cursor-pointer">24/7 Support</li>
            </ul>
          </div>

          {/* Contact */}
          <div className="animate-slide-up" style={{ animationDelay: '300ms' }}>
            <h3 className="font-semibold mb-4 text-primary-light">Contact</h3>
            <div className="space-y-3">
              <div className="flex items-center space-x-3 group">
                <MapPin className="h-4 w-4 text-background/60 group-hover:text-primary-light transition-colors" />
                <span className="text-background/80 text-sm group-hover:text-background transition-colors">
                  Douala, Cameroon
                </span>
              </div>
              <div className="flex items-center space-x-3 group">
                <Phone className="h-4 w-4 text-background/60 group-hover:text-primary-light transition-colors" />
                <span className="text-background/80 text-sm group-hover:text-background transition-colors">
                  +237 6XX XXX XXX
                </span>
              </div>
              <div className="flex items-center space-x-3 group">
                <Mail className="h-4 w-4 text-background/60 group-hover:text-primary-light transition-colors" />
                <span className="text-background/80 text-sm group-hover:text-background transition-colors">
                  contact@gazflow.cm
                </span>
              </div>
            </div>
          </div>
        </div>

        <div className="border-t border-background/20 mt-8 pt-8 text-center">
          <p className="text-background/60 text-sm">
            © {new Date().getFullYear()} GazFlow. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;