"use client";

import React, { useEffect, useState } from "react";
import Link from "@/components/ui/Link/Link";
import { LoadingSkeleton } from "@/components/ui/LoadingSkeleton";

// Dummy Feature component
const Feature = ({ icon, text }: { icon: string; text: string }) => (
    <div className="bg-white p-6 rounded-xl shadow-md">
        <div className="text-4xl mb-2">{icon}</div>
        <p className="text-lg font-medium">{text}</p>
    </div>
);

const ValueCard = ({ icon, title, desc }: { icon: string; title: string; desc: string }) => (
    <div className="bg-[#f9f9f9] shadow-md rounded-xl p-5 space-y-2 text-center">
        <div className="text-4xl">{icon}</div>
        <h3 className="text-xl font-semibold text-dark">{title}</h3>
        <p className="text-sm text-gray-700">{desc}</p>
    </div>
);

const AboutUs = () => {
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        const timer = setTimeout(() => setIsLoading(false), 1500);
        return () => clearTimeout(timer);
    }, []);

    if (isLoading) {
        return (
            <div className="min-h-screen bg-[#F5F5F5] flex items-center justify-center">
                <LoadingSkeleton className="h-[500px] w-3/4 rounded-2xl bg-[#6A1B9A]/20" />
            </div>
        );
    }

    return (
        <div className="bg-white text-[#1e293b] py-12 px-6 md:px-20 space-y-20">

            {/* Who We Are */}
            <section className="text-center max-w-5xl mx-auto">
                <h2 className="text-4xl font-bold text-primary mb-4">Who We Are</h2>
                <p className="text-lg font-medium">
                    In a fast-paced world, we bring trusted, hassle-free home services right to your doorstep.
                    <span className="font-semibold"> [Your Website Name] </span>
                    is your go-to platform for professional home services, bookable with just a click.
                </p>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-6">
                    <ValueCard icon="🤝" title="Trust" desc="We carefully vet every service provider to ensure your peace of mind." />
                    <ValueCard icon="⚡" title="Speed" desc="Quick booking, fast service — all in just a few taps." />
                    <ValueCard icon="🛠️" title="Professionalism" desc="Skilled experts who take pride in their work." />
                </div>
            </section>

            {/* Our Mission */}
            <section className="md:flex items-center gap-10">
                <div className="flex-1 space-y-4">
                    <h2 className="text-3xl font-bold text-secondary">Our Mission</h2>
                    <p className="font-medium">
                        Our mission is to ensure every home enjoys safety and comfort with fast, secure services
                        delivered by truly experienced professionals. Whether you need an electrician,
                        plumber, or deep cleaning — we&apos;re here for you.
                    </p>
                    <p className="font-medium">
                        Our goal is not only to fix what&apos;s broken — but to build lasting peace of mind, one household at a time.
                        Imagine being able to book a certified technician within 2 minutes — that’s the experience we deliver every day.
                    </p>
                </div>
                <iframe
                    className="flex-1 w-full h-64 md:h-80 rounded-2xl shadow-lg"
                    src="https://www.youtube.com/embed/XMWYZ-uZjnQ"
                    title="Home Cleaning Video"
                    frameBorder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowFullScreen
                ></iframe>
            </section>

            {/* Why Choose Us */}
            <section>
                <h2 className="text-3xl font-bold text-primary text-center mb-10">Why Choose Us?</h2>
                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8 text-center">
                    <Feature icon="✅" text="Vetted Professionals" />
                    <Feature icon="⏱️" text="Quick & Reliable" />
                    <Feature icon="💬" text="24/7 Support" />
                    <Feature icon="💵" text="Transparent Pricing" />
                    <Feature icon="🔧" text="Wide Range of Services" />
                    <Feature icon="🧼" text="Clean & Safe Procedures" />
                </div>
            </section>

            {/* Sustainability Section */}
            <section className="text-center max-w-4xl mx-auto space-y-6">
                <h2 className="text-3xl font-bold text-primary">Our Commitment to Sustainability</h2>
                <p className="text-lg font-medium">
                    We care about the future as much as we care about your home. That’s why we promote eco-friendly practices
                    in our services — using safe, sustainable cleaning materials and reducing waste wherever possible.
                </p>
                <p className="text-lg font-medium">
                    Choosing us means choosing a greener, cleaner world.
                </p>
            </section>

            {/* Our Team */}
            <section className="md:flex items-center gap-10">
                <img
                    src="/images/team.jpg"
                    alt="Our Team"
                    className="flex-1 w-full h-full md:h-[320px] object-cover rounded-2xl shadow-md"
                />
                <div className="flex-1 space-y-4">
                    <h2 className="text-3xl font-bold text-primary">Meet Our Team</h2>
                    <p className="font-medium">
                        Behind every service request is a strong network of certified and well-trained technicians.
                        Every member is carefully selected and trained to deliver top-tier quality with attention to detail.
                    </p>
                    <p className="font-medium">
                        Every technician goes through a 3-stage verification and skills test before serving customers.
                        We’re proud to work with people who love what they do.
                    </p>
                </div>
            </section>

            {/* Service Locations */}
            <section className="text-center space-y-4">
                <h2 className="text-3xl font-bold text-primary">Where Do We Operate?</h2>
                <p className="font-medium">Currently serving:</p>
                <ul className="flex flex-wrap justify-center gap-4 text-lg font-medium">
                    <li>Greater Cairo</li>
                    <li>Alexandria</li>
                    <li>Mansoura</li>
                    <li>...and more coming soon!</li>
                </ul>
            </section>

            {/* Contact Us CTA */}
            <section className="text-center">
                <Link
                    href="/contact"
                    className="bg-[#FFA726] hover:bg-secondary text-secondary px-6 py-3 rounded-full text-lg font-semibold transition duration-300"
                >
                    Contact Us
                </Link>
            </section>
        </div>
    );
}


export default React.memo(AboutUs);
