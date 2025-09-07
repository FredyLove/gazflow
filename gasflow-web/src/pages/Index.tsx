import Header from "@/components/Header";
import Hero from "@/components/Hero";
import Features from "@/components/Features";
import Footer from "@/components/Footer";
import { AnimatedCounter } from "@/components/AnimatedCounter";

const Index = () => {
  return (
    <div className="min-h-screen">
      <Header />
      <Hero />
      <Features />
      
      {/* About Section */}
      <section id="about" className="py-20 bg-gradient-subtle">
        <div className="container mx-auto px-4">
          <div className="max-w-4xl mx-auto text-center">
            <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-6 animate-fade-in-up">
              About GazFlow
            </h2>
            <p className="text-lg text-muted-foreground mb-8 leading-relaxed animate-fade-in-up stagger-delay-1">
              GazFlow revolutionizes gas delivery services across Cameroon. 
              Our mobile platform connects consumers with gas suppliers, 
              ensuring fast, secure, and affordable delivery nationwide.
            </p>
            <div className="grid md:grid-cols-3 gap-8 mt-12">
              <div className="text-center glass-card p-6 hover-lift animate-bounce-in stagger-delay-1">
                <div className="text-4xl font-bold text-primary mb-2">
                  <AnimatedCounter end={2024} />
                </div>
                <div className="text-muted-foreground">Year Founded</div>
              </div>
              <div className="text-center glass-card p-6 hover-lift animate-bounce-in stagger-delay-2">
                <div className="text-4xl font-bold text-primary mb-2">
                  <AnimatedCounter end={10} suffix="+" />
                </div>
                <div className="text-muted-foreground">Cities Covered</div>
              </div>
              <div className="text-center glass-card p-6 hover-lift animate-bounce-in stagger-delay-3">
                <div className="text-4xl font-bold text-primary mb-2">
                  <AnimatedCounter end={99} suffix="%" />
                </div>
                <div className="text-muted-foreground">Customer Satisfaction</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Contact Section */}
      <section id="contact" className="py-20 bg-background">
        <div className="container mx-auto px-4">
          <div className="max-w-2xl mx-auto text-center">
            <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-6 animate-fade-in-up">
              Contact Us
            </h2>
            <p className="text-lg text-muted-foreground mb-8 animate-fade-in-up stagger-delay-1">
              Have a question? Want to partner with us? Don't hesitate to reach out.
            </p>
            <div className="glass-card p-8 hover-lift animate-fade-in-up stagger-delay-2">
              <div className="grid md:grid-cols-2 gap-6 text-left">
                <div className="hover-scale">
                  <h3 className="font-semibold text-foreground mb-2">Technical Support</h3>
                  <p className="text-muted-foreground text-sm mb-4">
                    For technical questions and user support
                  </p>
                  <p className="text-primary font-medium">support@gazflow.cm</p>
                </div>
                <div className="hover-scale">
                  <h3 className="font-semibold text-foreground mb-2">Partnerships</h3>
                  <p className="text-muted-foreground text-sm mb-4">
                    To become a partner or distributor
                  </p>
                  <p className="text-primary font-medium">business@gazflow.cm</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
};

export default Index;
