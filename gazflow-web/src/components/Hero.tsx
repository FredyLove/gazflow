import { Button } from "@/components/ui/button";
import { Smartphone, Download, Play } from "lucide-react";
import appMockup from "@/assets/app-mockup.jpg";

const Hero = () => {
  return (
    <section className="relative min-h-screen flex items-center justify-center bg-gradient-hero overflow-hidden">
      {/* Background decoration */}
      <div className="absolute inset-0 bg-gradient-subtle opacity-50" />
      <div className="absolute top-20 right-10 w-72 h-72 bg-primary/10 rounded-full blur-3xl" />
      <div className="absolute bottom-10 left-10 w-96 h-96 bg-primary-light/10 rounded-full blur-3xl" />
      
      <div className="container mx-auto px-4 relative z-10">
        <div className="grid lg:grid-cols-2 gap-12 items-center">
          {/* Content */}
          <div className="text-center lg:text-left">
            <div className="animate-fade-in-up">
              <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold text-primary-foreground mb-6 leading-tight">
                Livraison de Gaz 
                <span className="text-primary-light block">
                  Rapide & Fiable
                </span>
              </h1>
              
              <p className="text-lg md:text-xl text-primary-foreground/90 mb-8 max-w-2xl mx-auto lg:mx-0">
                GazFlow révolutionne la livraison de gaz au Cameroun. 
                Commandez votre bouteille de gaz en quelques clics et recevez-la directement chez vous.
              </p>

              <div className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
                <Button variant="hero" size="lg" className="bg-primary-foreground text-primary hover:bg-primary-foreground/90">
                  <Download className="mr-2 h-5 w-5" />
                  Télécharger sur Android
                </Button>
                <Button variant="outline" size="lg" className="border-primary-foreground text-primary-foreground hover:bg-primary-foreground hover:text-primary">
                  <Play className="mr-2 h-5 w-5" />
                  Voir la Démo
                </Button>
              </div>

              <div className="mt-8 flex items-center justify-center lg:justify-start space-x-6 text-primary-foreground/80">
                <div className="text-center">
                  <div className="text-2xl font-bold">1000+</div>
                  <div className="text-sm">Utilisateurs</div>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold">50+</div>
                  <div className="text-sm">Points de Vente</div>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold">24/7</div>
                  <div className="text-sm">Service</div>
                </div>
              </div>
            </div>
          </div>

          {/* App Mockup */}
          <div className="flex justify-center lg:justify-end">
            <div className="relative">
              <div className="animate-float">
                <img 
                  src={appMockup} 
                  alt="GazFlow Mobile App" 
                  className="max-w-sm w-full h-auto rounded-3xl shadow-primary"
                />
              </div>
              {/* Floating elements */}
              <div className="absolute -top-4 -right-4 bg-primary-foreground/20 backdrop-blur-sm rounded-full p-3">
                <Smartphone className="h-6 w-6 text-primary-foreground" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Hero;