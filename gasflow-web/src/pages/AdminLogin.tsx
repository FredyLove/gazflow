import { useState } from "react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Eye, EyeOff, ArrowLeft } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import gasIcon from "@/assets/gas-icon.png";

const AdminLogin = () => {
  const [showPassword, setShowPassword] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const { toast } = useToast();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    // Simulate login process
    setTimeout(() => {
      setIsLoading(false);
      toast({
        title: "Login Successful",
        description: "Welcome to GazFlow administration panel.",
      });
      // In a real app, you would redirect to the admin dashboard
    }, 2000);
  };

  return (
    <div className="min-h-screen bg-gradient-hero flex items-center justify-center p-4 relative overflow-hidden">
      {/* Background decoration */}
      <div className="absolute inset-0 bg-gradient-subtle opacity-30" />
      <div className="absolute top-20 right-10 w-72 h-72 bg-primary/10 rounded-full blur-3xl" />
      <div className="absolute bottom-10 left-10 w-96 h-96 bg-primary-light/10 rounded-full blur-3xl" />
      
      <div className="w-full max-w-md relative z-10">
        {/* Header */}
        <div className="text-center mb-8 animate-fadeInScale">
          <Link to="/" className="inline-flex items-center text-primary-foreground/80 hover:text-primary-foreground mb-4 hover-scale transition-all duration-300">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Home
          </Link>
          <div className="flex items-center justify-center mb-4">
            <img src={gasIcon} alt="GazFlow" className="h-12 w-12 hover-scale animate-pulse-glow" />
          </div>
          <h1 className="text-2xl font-bold text-primary-foreground">GazFlow Administration</h1>
          <p className="text-primary-foreground/90">Sign in to your administrator account</p>
        </div>

        {/* Login Form */}
        <Card className="glass-card border-glass-border backdrop-blur-lg animate-slide-up">
          <CardHeader>
            <CardTitle className="text-primary-foreground">Login</CardTitle>
            <CardDescription className="text-primary-foreground/80">
              Enter your administrator credentials to access the dashboard.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="email" className="text-primary-foreground/90">Email</Label>
                <Input
                  id="email"
                  type="email"
                  placeholder="admin@gazflow.cm"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="glass-card border-glass-border text-primary-foreground placeholder:text-primary-foreground/60"
                  required
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="password" className="text-primary-foreground/90">Password</Label>
                <div className="relative">
                  <Input
                    id="password"
                    type={showPassword ? "text" : "password"}
                    placeholder="••••••••"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    className="glass-card border-glass-border text-primary-foreground placeholder:text-primary-foreground/60"
                    required
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-primary-foreground/60 hover:text-primary-foreground hover-scale"
                  >
                    {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                  </button>
                </div>
              </div>

              <Button type="submit" variant="hero" className="w-full hover-lift" disabled={isLoading}>
                {isLoading ? "Signing in..." : "Sign In"}
              </Button>
            </form>

            <div className="mt-6 text-center">
              <Link 
                to="/admin/register" 
                className="text-sm text-primary-light hover:text-primary-foreground hover:underline transition-all duration-300"
              >
                Create administrator account
              </Link>
            </div>
          </CardContent>
        </Card>

        {/* Demo Credentials */}
        <Card className="mt-4 glass-card border-glass-border/50 animate-bounce-in">
          <CardContent className="p-4">
            <p className="text-sm text-primary-foreground/80 text-center">
              <strong>Demo:</strong> admin@gazflow.cm / admin123
            </p>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default AdminLogin;