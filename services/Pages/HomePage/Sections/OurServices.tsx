// OurServices

import React from "react";
import Link from "next/link";

const services = [
    {
        title: "Plumbing",
        icon: "🔧",
        description: "Professional solutions for any plumbing issue.",
    },
    {
        title: "Electrical",
        icon: "⚡",
        description: "Safe and fast electrical maintenance and installation.",
    },
    {
        title: "Cleaning",
        icon: "🧽",
        description: "Comprehensive residential and office cleaning services.",
    },
    {
        title: "Furniture Moving",
        icon: "📦",
        description: "Secure and efficient furniture transportation.",
    },
    {
        title: "General Maintenance",
        icon: "🧰",
        description: "All-in-one maintenance services for your home.",
    },
    {
        title: "Gas Services",
        icon: "🔥",
        description: "Expert gas installation and emergency handling.",
    },
];

const OurServices = () => {
    return (
        <section className="py-16 px-4" style={{ backgroundColor: "#F5F5F5" }}>
            <div className="max-w-7xl mx-auto text-center">
                <h2 className="text-3xl font-bold mb-4" style={{ color: "#6A1B9A" }}>
                    Our Services
                </h2>
                <p className="mb-10 max-w-2xl mx-auto" style={{ color: "#212121" }}>
                    Discover the wide range of home services we provide. Select the category to find available professionals.
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                    {services.map((service, index) => (
                        <div
                            key={index}
                            className="p-6 rounded-2xl shadow-md hover:shadow-lg transition-all duration-300"
                            style={{ backgroundColor: "#FFFFFF" }}
                        >
                            <div className="text-4xl mb-4" style={{ color: "#6A1B9A" }}>
                                {service.icon}
                            </div>
                            <h3 className="text-xl font-semibold mb-2" style={{ color: "#6A1B9A" }}>
                                {service.title}
                            </h3>
                            <p className="mb-4" style={{ color: "#212121" }}>{service.description}</p>
                            <Link href="/workers">
                                <button
                                    className="mt-auto px-4 py-2 rounded-xl hover:opacity-90"
                                    style={{
                                        backgroundColor: "#EFB036",
                                        color: "#23486A",
                                        fontWeight: "bold"
                                    }}
                                >
                                    View Workers
                                </button>
                            </Link>
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
};

export default OurServices;
