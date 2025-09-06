import { 
  MapPin, 
  Truck, 
  Clock, 
  Shield, 
  Phone, 
  BarChart3,
  Package,
  Users
} from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";

const features = [
  {
    icon: MapPin,
    title: "Géolocalisation Précise",
    description: "Trouvez les dépôts de gaz les plus proches et suivez la livraison en temps réel.",
    color: "text-primary"
  },
  {
    icon: Truck,
    title: "Livraison Rapide",
    description: "Livraison dans les 30 minutes dans les zones urbaines de Douala et Yaoundé.",
    color: "text-success"
  },
  {
    icon: Clock,
    title: "Service 24/7",
    description: "Commandez à tout moment, notre équipe est disponible jour et nuit.",
    color: "text-warning"
  },
  {
    icon: Shield,
    title: "Sécurité Garantie",
    description: "Conseils de sécurité intégrés et livreurs certifiés pour votre tranquillité.",
    color: "text-destructive"
  },
  {
    icon: Package,
    title: "Différents Types de Gaz",
    description: "Gaz domestique, industriel, et bouteilles de différentes tailles disponibles.",
    color: "text-primary"
  },
  {
    icon: BarChart3,
    title: "Suivi de Consommation",
    description: "Analysez votre consommation et recevez des recommandations personnalisées.",
    color: "text-success"
  },
  {
    icon: Users,
    title: "Interface Livreur",
    description: "Système complet pour les livreurs avec optimisation des trajets.",
    color: "text-warning"
  },
  {
    icon: Phone,
    title: "Support Multilingue",
    description: "Support en Français, Anglais et bientôt en Pidgin English.",
    color: "text-destructive"
  }
];

const Features = () => {
  return (
    <section id="features" className="py-20 bg-gradient-subtle">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-4">
            Fonctionnalités Avancées
          </h2>
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
            GazFlow offre une expérience complète pour la livraison de gaz, 
            adaptée aux besoins spécifiques du marché camerounais.
          </p>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          {features.map((feature, index) => (
            <Card 
              key={index} 
              className="group hover:shadow-custom-lg transition-all duration-300 hover:-translate-y-1 border-border/50"
            >
              <CardContent className="p-6 text-center">
                <div className="mb-4 inline-flex items-center justify-center w-12 h-12 rounded-lg bg-primary/10 group-hover:bg-primary/20 transition-colors">
                  <feature.icon className={`h-6 w-6 ${feature.color}`} />
                </div>
                <h3 className="text-lg font-semibold text-foreground mb-2">
                  {feature.title}
                </h3>
                <p className="text-muted-foreground text-sm leading-relaxed">
                  {feature.description}
                </p>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Features;