import React, { useState, useEffect } from 'react';
import { Download, ArrowUp } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';

export const FloatingActionButton: React.FC = () => {
  const [isVisible, setIsVisible] = useState(false);
  const [showScrollTop, setShowScrollTop] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      const scrollY = window.scrollY;
      const windowHeight = window.innerHeight;
      
      // Show FAB after scrolling past hero section
      setIsVisible(scrollY > windowHeight * 0.5);
      
      // Show scroll to top after scrolling significantly
      setShowScrollTop(scrollY > windowHeight);
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const scrollToTop = () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  };

  const handleDownload = () => {
    // Simulate app download - in real app, this would redirect to app stores
    console.log('Redirecting to app download...');
  };

  return (
    <>
      {/* Download App FAB */}
      <div
        className={cn(
          "fixed bottom-6 right-6 z-50 transition-all duration-500 transform",
          isVisible 
            ? "translate-y-0 opacity-100 scale-100" 
            : "translate-y-16 opacity-0 scale-0"
        )}
      >
        <Button
          onClick={handleDownload}
          className={cn(
            "h-14 w-14 rounded-full shadow-xl hover:shadow-2xl",
            "bg-gradient-primary hover:bg-primary-dark",
            "animate-pulse-glow hover-lift",
            "group transition-all duration-300"
          )}
          size="icon"
        >
          <Download className="h-6 w-6 group-hover:scale-110 transition-transform" />
          <span className="sr-only">Download GazFlow App</span>
        </Button>
      </div>

      {/* Scroll to Top FAB */}
      <div
        className={cn(
          "fixed bottom-24 right-6 z-40 transition-all duration-500 transform",
          showScrollTop 
            ? "translate-y-0 opacity-100 scale-100" 
            : "translate-y-16 opacity-0 scale-0"
        )}
      >
        <Button
          onClick={scrollToTop}
          variant="outline"
          className={cn(
            "h-12 w-12 rounded-full glass-card hover-lift",
            "border-glass-border hover:border-primary/20"
          )}
          size="icon"
        >
          <ArrowUp className="h-5 w-5" />
          <span className="sr-only">Scroll to top</span>
        </Button>
      </div>
    </>
  );
};