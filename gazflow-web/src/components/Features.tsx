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
    title: "Precise Geolocation",
    description: "Find the nearest gas stations and track your delivery in real-time.",
    color: "text-primary"
  },
  {
    icon: Truck,
    title: "Fast Delivery",
    description: "30-minute delivery in urban areas of Douala and Yaoundé.",
    color: "text-success"
  },
  {
    icon: Clock,
    title: "24/7 Service",
    description: "Order anytime, our team is available day and night.",
    color: "text-warning"
  },
  {
    icon: Shield,
    title: "Guaranteed Safety",
    description: "Built-in safety tips and certified delivery personnel for your peace of mind.",
    color: "text-destructive"
  },
  {
    icon: Package,
    title: "Different Gas Types",
    description: "Domestic, industrial gas, and cylinders of various sizes available.",
    color: "text-primary"
  },
  {
    icon: BarChart3,
    title: "Consumption Tracking",
    description: "Analyze your usage and receive personalized recommendations.",
    color: "text-success"
  },
  {
    icon: Users,
    title: "Delivery Interface",
    description: "Complete system for delivery personnel with route optimization.",
    color: "text-warning"
  },
  {
    icon: Phone,
    title: "Multilingual Support",
    description: "Support in French, English, and coming soon in Pidgin English.",
    color: "text-destructive"
  }
];

const Features = () => {
  return (
    <section id="features" className="py-20 bg-gradient-subtle">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16 animate-fadeInScale">
          <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-4">
            Advanced Features
          </h2>
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
            GazFlow offers a complete experience for gas delivery, 
            tailored to the specific needs of the Cameroonian market.
          </p>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          {features.map((feature, index) => (
            <Card 
              key={index} 
              className="group glass-card hover:shadow-glow transition-all duration-500 hover-lift border-glass-border hover:border-primary/20 animate-slide-up"
              style={{ animationDelay: `${index * 100}ms` }}
            >
              <CardContent className="p-6 text-center">
                <div className="mb-4 inline-flex items-center justify-center w-12 h-12 rounded-lg bg-primary/10 group-hover:bg-primary/20 transition-all duration-300 group-hover:scale-110 group-hover:rotate-6">
                  <feature.icon className={`h-6 w-6 ${feature.color} group-hover:scale-110 transition-transform duration-300`} />
                </div>
                <h3 className="text-lg font-semibold text-foreground mb-2 group-hover:text-primary transition-colors">
                  {feature.title}
                </h3>
                <p className="text-muted-foreground text-sm leading-relaxed group-hover:text-foreground/80 transition-colors">
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