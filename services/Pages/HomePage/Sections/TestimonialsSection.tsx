"use client";

import { useState } from "react";
import { FaStar } from "react-icons/fa";
import { IoIosArrowBack, IoIosArrowForward } from "react-icons/io";
import { Button } from "@/components/ui/Button/Button";
import { CustomImage } from "@/components/ui/Images/Image";

const testimonials = [
  {
    id: 1,
    name: "Sarah Thompson",
    role: "CEO, Innovate Tech",
    image: "/images/1.jpg",
    content: "Working with this team was a game-changer for our business. Their professional services exceeded our expectations and helped us scale faster than we imagined.",
    rating: 5
  },
  {
    id: 2,
    name: "Michael Chen",
    role: "Marketing Director",
    image: "/images/2.jpg",
    content: "I've worked with many service providers, but this company stands out for their attention to detail and commitment to excellence.",
    rating: 5
  },
  {
    id: 3,
    name: "Emma Davis",
    role: "Product Manager",
    image: "/images/3.jpg",
    content: "Outstanding service and attention to detail. The team&apos;s expertise helped us achieve our goals efficiently.",
    rating: 5
  }
];

export default function TestimonialsSection() {
  const [currentIndex, setCurrentIndex] = useState(0);

  const nextTestimonial = () => {
    setCurrentIndex((prev) => (prev + 1) % testimonials.length);
  };

  const prevTestimonial = () => {
    setCurrentIndex((prev) => (prev - 1 + testimonials.length) % testimonials.length);
  };

  const currentTestimonial = testimonials[currentIndex];

  return (
    <section className="py-16 bg-[#FDF7EE]">
      <div className="container mx-auto px-4">
        <h2 className="text-4xl font-bold text-center mb-4 text-primary">What Our Clients Say</h2>
        <p className="text-center text-gray-600 mb-12 max-w-2xl mx-auto">
          Don&lsquo;t just take our word for it. Here&apos;s what our clients have to say about our services and the results we&apos;ve delivered.
        </p>
        
        <div className="max-w-4xl mx-auto">
          <div className="bg-white rounded-2xl shadow-lg p-12 relative">
            {/* Background accent */}
            <div className="absolute top-0 left-0 transform -translate-x-4 -translate-y-4 h-full w-full bg-primary/10 rounded-2xl -z-10"></div>
            
            <div className="flex flex-col items-center">
              <div className="w-24 h-24 mb-8 rounded-full overflow-hidden border-4 border-primary/20">
                <CustomImage
                  src={currentTestimonial.image}
                  alt={currentTestimonial.name}
                  width={96}
                  height={96}
                  className="w-full h-full object-cover"
                />
              </div>
              
              <div className="flex mb-6">
                {[...Array(currentTestimonial.rating)].map((_, i) => (
                  <FaStar key={i} size={24} color="#FFD700" />
                ))}
              </div>
              
              <p className="text-xl text-gray-700 text-center mb-8 italic leading-relaxed">
                &ldquo;{currentTestimonial.content}&rdquo;
              </p>
              
              <div className="text-center">
                <h3 className="text-xl font-semibold text-primary mb-1">{currentTestimonial.name}</h3>
                <p className="text-gray-500">{currentTestimonial.role}</p>
              </div>
            </div>
            
            <div className="flex flex-col items-center mt-12 gap-6">
              <div className="flex justify-center gap-4">
                <Button
                  onClick={prevTestimonial}
                  className="p-2 rounded-full bg-gray-100 hover:bg-gray-200 transition-colors"
                >
                  <IoIosArrowBack size={24} color="#666" />
                </Button>
                <Button
                  onClick={nextTestimonial}
                  className="p-2 rounded-full bg-gray-100 hover:bg-gray-200 transition-colors"
                >
                  <IoIosArrowForward size={24} color="#666" />
                </Button>
              </div>
              
              {/* Dots navigation */}
              <div className="flex gap-2">
                {testimonials.map((_, index) => (
                  <Button
                    key={index}
                    onClick={() => setCurrentIndex(index)}
                    className={`w-2 h-2 rounded-full transition-all duration-300 ${
                      index === currentIndex 
                        ? 'bg-primary w-6' 
                        : 'bg-gray-300 hover:bg-gray-400'
                    }`}
                    aria-label={`Go to testimonial ${index + 1}`}
                  />
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}