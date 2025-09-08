import { useState } from "react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Eye, EyeOff, ArrowLeft, Check } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import gasIcon from "@/assets/gas-icon.png";

const AdminRegister = () => {
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
    confirmPassword: "",
    organizationCode: ""
  });
  const [isLoading, setIsLoading] = useState(false);
  const { toast } = useToast();

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (formData.password !== formData.confirmPassword) {
      toast({
        title: "Error",
        description: "Passwords do not match.",
        variant: "destructive"
      });
      return;
    }

    setIsLoading(true);

    // Simulate registration process
    setTimeout(() => {
      setIsLoading(false);
      toast({
        title: "Account created successfully",
        description: "Your administrator account has been created. You can now sign in.",
      });
      // In a real app, you would redirect to login or dashboard
    }, 2000);
  };

  return (
    <div className="min-h-screen bg-gradient-hero flex items-center justify-center p-4 relative overflow-hidden">
      {/* Background decoration */}
      <div className="absolute inset-0 bg-gradient-subtle opacity-30" />
      <div className="absolute top-20 left-10 w-72 h-72 bg-primary/10 rounded-full blur-3xl" />
      <div className="absolute bottom-10 right-10 w-96 h-96 bg-primary-light/10 rounded-full blur-3xl" />
      
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
          <h1 className="text-2xl font-bold text-primary-foreground">Create Admin Account</h1>
          <p className="text-primary-foreground/90">Register to manage the GazFlow platform</p>
        </div>

        {/* Registration Form */}
        <Card className="glass-card border-glass-border backdrop-blur-lg animate-slide-up">
          <CardHeader>
            <CardTitle className="text-primary-foreground">Registration</CardTitle>
            <CardDescription className="text-primary-foreground/80">
              Create your administrator account to access management tools.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="name" className="text-primary-foreground/90">Full Name</Label>
                <Input
                  id="name"
                  name="name"
                  type="text"
                  placeholder="John Doe"
                  value={formData.name}
                  onChange={handleInputChange}
                  className="glass-card border-glass-border text-primary-foreground placeholder:text-primary-foreground/60"
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="email" className="text-primary-foreground/90">Email</Label>
                <Input
                  id="email"
                  name="email"
                  type="email"
                  placeholder="admin@gazflow.cm"
                  value={formData.email}
                  onChange={handleInputChange}
                  className="glass-card border-glass-border text-primary-foreground placeholder:text-primary-foreground/60"
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="organizationCode" className="text-primary-foreground/90">Organization Code</Label>
                <Input
                  id="organizationCode"
                  name="organizationCode"
                  type="text"
                  placeholder="GAZFLOW-ORG-2024"
                  value={formData.organizationCode}
                  onChange={handleInputChange}
                  className="glass-card border-glass-border text-primary-foreground placeholder:text-primary-foreground/60"
                  required
                />
                <p className="text-xs text-primary-foreground/60">
                  Contact the GazFlow team to get your organization code.
                </p>
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="password" className="text-primary-foreground/90">Password</Label>
                <div className="relative">
                  <Input
                    id="password"
                    name="password"
                    type={showPassword ? "text" : "password"}
                    placeholder="••••••••"
                    value={formData.password}
                    onChange={handleInputChange}
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

              <div className="space-y-2">
                <Label htmlFor="confirmPassword" className="text-primary-foreground/90">Confirm Password</Label>
                <div className="relative">
                  <Input
                    id="confirmPassword"
                    name="confirmPassword"
                    type={showConfirmPassword ? "text" : "password"}
                    placeholder="••••••••"
                    value={formData.confirmPassword}
                    onChange={handleInputChange}
                    className="glass-card border-glass-border text-primary-foreground placeholder:text-primary-foreground/60"
                    required
                  />
                  <button
                    type="button"
                    onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-primary-foreground/60 hover:text-primary-foreground hover-scale"
                  >
                    {showConfirmPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                  </button>
                </div>
              </div>

              <Button type="submit" variant="hero" className="w-full hover-lift" disabled={isLoading}>
                {isLoading ? "Creating account..." : "Create Account"}
              </Button>
            </form>

            <div className="mt-6 text-center">
              <Link 
                to="/admin/login" 
                className="text-sm text-primary-light hover:text-primary-foreground hover:underline transition-all duration-300"
              >
                Already have an account? Sign in
              </Link>
            </div>
          </CardContent>
        </Card>

        {/* Security Notice */}
        <Card className="mt-4 glass-card border-success/20 animate-bounce-in">
          <CardContent className="p-4">
            <div className="flex items-start space-x-3">
              <Check className="h-5 w-5 text-success mt-0.5 flex-shrink-0" />
              <div>
                <p className="text-sm font-medium text-primary-foreground">
                  Secure Account
                </p>
                <p className="text-xs text-primary-foreground/80 mt-1">
                  All data is encrypted and your account requires validation by the GazFlow team.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default AdminRegister;